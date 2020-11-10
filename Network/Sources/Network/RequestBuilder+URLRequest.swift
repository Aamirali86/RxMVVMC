//
//  RequestBuilder+Ext.swift
//  NetworkService
//

import Foundation

extension RequestBuilder {

    private var headers: [String: String] {
        let headers: [String: String] = [:]
        guard let params = parameters else { return headers }

        return params.reduce(into: headers) { header, p in
            switch p.value {
            case .header(let v):
                header[p.key] = v
            default:
                break
            }
        }
    }

    private var body: [String: Any]? {
        guard let params = parameters else { return nil }

        let body = params.reduce(into: [String: Any]()) { body, p in
            switch p.value {
            case .body(let v):
                body[p.key] = v
            default:
                break
            }
        }

        guard !body.isEmpty else { return nil }

        return body
    }

    private var query: [String: String] {
        guard let params = parameters else { return [:] }

        return params.reduce(into: [String: String]()) { body, p in
            switch p.value {
            case .query(let v):
                body[p.key] = v
            default:
                break
            }
        }
    }

    private func url() -> URL {
        var comps = URLComponents()
        comps.scheme = "https"
        comps.host = baseURL

        let path = self.path.components(separatedBy: "/").map { component -> String in
            guard component.hasPrefix("{"), component.hasSuffix("}") else {
                return String(describing: component)
            }

            guard let pathValue = parameters?.compactMap({ key, parameter -> String? in
                if case .path(let value) = parameter, "{\(key)}" == component {
                    return String(describing: value)
                }

                return nil
            }).first else {
                fatalError("Couldn't find matching parameter")
            }

            return pathValue
        }

        if !path.isEmpty {
            comps.path = "/" + path.joined(separator: "/")
        }

        if !query.isEmpty {
            comps.queryItems = query.map { URLQueryItem(name: $0, value: $1) }
        }

        // NOTE: after reading NSURLComponents doc, it's impossible this will be nil
        return comps.url!
    }

    func buildURLRequest(with headers: [String: String]) throws -> URLRequest {
        var request = URLRequest(url: url())
        request.httpMethod = method.rawValue.uppercased()

        let mergedHeaders = headers.merging(self.headers) { (_, new) in new }

        for header in mergedHeaders {
            request.setValue(header.value, forHTTPHeaderField: header.key)
        }

        if let body = body {
            request.allHTTPHeaderFields?["Content-Type"] = "application/json"
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        }

        request.timeoutInterval = 0.0

        return request
    }
}
