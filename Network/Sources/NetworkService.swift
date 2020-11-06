//
//  NetworkService.swift
//  NetworkService
//

import Foundation
import RxSwift

public protocol NetworkServiceType: AnyObject {
    func request<R: RequestBuilder>(_ resource: R) -> Observable<R.Response>
}

public class NetworkService {
    private let network: NetworkType
    private let vendorId: String
    private let appVersion: String

    public init(network: NetworkType, vendorId: String, appVersion: String) {
        self.network = network
        self.vendorId = vendorId
        self.appVersion = appVersion
    }
}

extension NetworkService: NetworkServiceType {

    public func request<R: RequestBuilder>(_ resource: R) -> Observable<R.Response> {
        Observable.create { [unowned self] observer in
            return self.request(resource, completion: { (result) in
                switch result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            })
        }
    }

    // MARK: - Helpers

    private func buildRequest<R: RequestBuilder>(resource: R) throws -> URLRequest {
        var headers: [String: Any] = [:]
        headers["Content-Type"] = "application/json"
        if resource.additionalHeaders.contains(.device) {
            headers["Device"] = vendorId
            headers["Version"] = appVersion
        }

        return try resource.buildURLRequest(with: headers.mapValues { "\($0)" })
    }

    private func request<R: RequestBuilder>(_ resource: R, completion: @escaping (Result<R.Response, RequestError>) -> Void) -> Disposable {
        let builtRequest: URLRequest
        do {
            builtRequest = try buildRequest(resource: resource)
        } catch {
            completion(.failure(.requestBuildFailed))
            return Disposables.create()
        }

        return network.request(builtRequest) { result in
            switch result {
            case .success((let response, let data)):
                do {
                    // Check that data and response are available, otherwise return failure
                    guard let data = data, let response = response else {
                        throw RequestError.noResponse
                    }

                    // ⚠️
                    // Check for custom backend error, because backend can send an error DTO while result is 200
                    if let error = DomainError(jsonData: data).flatMap(RequestError.init(underlyingError:)) {
                        throw error
                    }

                    // Additional check for status code, because URLSession can give Error as nil
                    if response.statusCode > 299 {
                        throw RequestError.custom(DomainError(code: "\(response.statusCode)"))
                    }

                    let value = try resource.parse(data: data, response: response)
                    completion(.success(value))
                } catch {
                    let actualError: RequestError
                    if let domainError = error as? RequestError {
                        actualError = domainError
                    } else {
                        actualError = RequestError(error: error)
                    }

                    completion(.failure(actualError))
                }
            case .failure(let error):
                let actualError = RequestError(error: error)
                completion(.failure(actualError))
            }
        }
    }
}
