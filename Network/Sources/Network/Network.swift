//
//  Network.swift
//  NetworkService
//

import Foundation
import RxSwift

/// A type providing needed edge information
public protocol Edge {
    /// Edge base URL, `https` is added automatically as a prefix.
    var baseURL: String { get }
}

public struct AdditionalHeaders: OptionSet {
    public let rawValue: Int
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    /// Device information headers
    public static let device = AdditionalHeaders(rawValue: 1 << 0)
    /// Authorization header
    public static let authorization = AdditionalHeaders(rawValue: 1 << 1)
}

/// A type providing information about additional headers
public protocol HeaderInterceptor {
    /// Headers to add to each built request
    var additionalHeaders: [AdditionalHeaders] { get }
}

/// A composite type providing needed information to build a network request
public protocol RequestBuilder: BaseResource, Edge, HeaderInterceptor {}

public protocol NetworkType {
    func request(_ request: URLRequest,
                 completion: @escaping (Result<(HTTPURLResponse?, Data?), Error>) -> Void) -> Disposable
}

extension URLSession: NetworkType {
    public func request(_ request: URLRequest,
                        completion: @escaping (Result<(HTTPURLResponse?, Data?), Error>) -> Void) -> Disposable {
        let task = dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success((response as? HTTPURLResponse, data)))
            }
        }

        task.resume()

        return Disposables.create {
            task.cancel()
        }
    }
}
