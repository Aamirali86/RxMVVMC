//
//  BaseResource.swift
//  NetworkService
//

import Foundation

/// A type encapsulating needed information to build network request for a specific resource
public protocol BaseResource {
    /// Expected response type
    associatedtype Response
    /// Resource HTTP method
    var method: HTTPMethod { get }
    /// Resource path
    var path: String { get }
    /// Resource request parameters
    var parameters: [String: Parameter]? { get }
    /// Parsing response JSON data into expected response type
    ///
    /// - Parameter data: JSON response data
    /// - Parameter response: HTTP response
    /// - Returns: Parsed response result
    /// - Throws: Parsing exceptions
    func parse(data: Data, response: HTTPURLResponse) throws -> Response
}

/// Request HTTP methos
public enum HTTPMethod: String {
    case get
    case head
    case post
    case put
    case delete
}

/// Request parameters data
public enum Parameter: Equatable {
    /// JSON-encoded body parameter
    case body(Any)
    /// URL-encoded query parameter
    case query(String)
    /// HTTP header field
    case header(String)
    /// Component in URL path
    case path(CustomStringConvertible)

    public static func optionalBody(_ value: Any?) -> Parameter {
        guard let value = value else {
            return .body(NSNull())
        }
        return .body(value)
    }

    public static func == (lhs: Parameter, rhs: Parameter) -> Bool {
        switch (lhs, rhs) {
        case (.body(let l), .body(let r)):
            // let's convert contents to their Cocoa counterparts to be able to compare
            return (l as? NSObject)?.isEqual(r as? NSObject) ?? false
        case (.query(let l), .query(let r)):
            return l == r
        case (.header(let l), .header(let r)):
            return l == r
        case (.path(let l), .path(let r)):
            return String(describing: l) == String(describing: r)
        default:
            return false
        }
    }
}
