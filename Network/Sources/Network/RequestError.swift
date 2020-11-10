//
//  RequestError.swift
//  NetworkService
//

import Foundation

struct DomainError: Equatable {
    let code: String
    var message: String?
    var fields: [String: Any]?

    init(code: String) {
        self.code = code
    }

    init?(jsonData: Data) {
        guard let json = (try? JSONSerialization.jsonObject(with: jsonData)),
            let dict = json as? [String: Any],
            let errorCode = dict["errorCode"] as? String
            else {
                return nil
        }

        code = errorCode
        message = (dict["operationMessage"] as? String)
            ?? (dict["message"] as? String)
        fields = dict["fields"] as? [String: Any]
    }

    static let unknown = DomainError(code: "UNKNOWN-0001")

    static func == (lhs: DomainError, rhs: DomainError) -> Bool {
        return lhs.code == rhs.code
    }
}

/// Request specific error
enum RequestError: Error {
    static let connectionErrorCodes: [URLError.Code] =
        [
            .timedOut,
            .notConnectedToInternet,
            .cannotFindHost,
            .cannotConnectToHost,
            .cannotLoadFromNetwork,
            .backgroundSessionWasDisconnected,
            .secureConnectionFailed,
            .networkConnectionLost,
            .dnsLookupFailed,
            .internationalRoamingOff,
        ]

    /// Request could not be fulfilled because token has expired
    case tokenExpired
    /// Request could not be constructed
    case requestBuildFailed
    /// Result is successful but there is no response
    case noResponse
    /// Custom error with data. e.g. when backend returns successful result with error
    case custom(DomainError)
    /// All internet connection errors
    case connection
    /// URL errors
    case url(URLError)

    init(error: Error) {
        // by default error is the generic error
        self = .custom(.unknown)

        // we want to detect as much connection problems as possible, so users can inspect their connectivity
        // as developers, we are not really handling specific cases for URLError connections, so it is fine to collaps
        switch error {
        case let error as URLError:
            if RequestError.connectionErrorCodes.contains(error.code) {
                self = .connection
            } else {
                self = .url(error)
            }
        default:
            break
        }
    }

    init(code: String) {
        self = .custom(DomainError(code: code))
    }

    init(underlyingError: DomainError) {
        self = .custom(underlyingError)
    }

    static let unknown = RequestError.custom(.unknown)
}

extension RequestError {
    /// Transient error codes that can be retried
    var isTransient: Bool {
        switch self {
        case .connection:
            return true
        case .custom(let error):
            switch error.code {
            case "400", // Bad Request
                 "408", // Request Timeout error
                 "429", // Request limit
                 "500", // Internal Server Error
                 "502", // Bad Gateway
                 "503", // Service Unavailable
                 "504": // Gateway Timeout error:
                return true
            default:
                return false
            }
        default:
            return false
        }
    }
}

extension RequestError: Equatable {
    static func == (lhs: RequestError, rhs: RequestError) -> Bool {
        switch (lhs, rhs) {
        case (.tokenExpired, .tokenExpired):
            return true
        case (.requestBuildFailed, .requestBuildFailed):
            return true
        case (.noResponse, .noResponse):
            return true
        case let (.custom(lhsCode), .custom(rhsCode)):
            return lhsCode.code == rhsCode.code
        case (.connection, .connection):
            return true
        case let (.url(lhsString), .url(rhsString)):
            return lhsString == rhsString
        default:
            return false
        }
    }
}

extension RequestError: CustomStringConvertible {
    var description: String {
        switch self {
        case .tokenExpired:
            return "tokenExpired"
        case .requestBuildFailed:
            return "requestBuildFailed"
        case .noResponse:
            return "noResponse"
        case let .custom(domainError):
            return "custom(\(domainError.code))"
        case .connection:
            return "connection"
        case let .url(urlError):
            return "url(\(urlError.errorCode))"
        }
    }
}
