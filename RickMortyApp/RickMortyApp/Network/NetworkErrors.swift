//
//  NetworkErrors.swift
//  RickMortyApp
//
//  Created by Silvia Casanova Martinez on 21/8/24.
//

import Foundation

enum APIErrors: Error {
    case general
    case json
    case nonHTTP
    case status(Int)
    case invalidData
    case noData
    case defaultError(String)
    
    var description: String {
        switch self {
        case .general:
            return "\("error_general".localized) \("error_message_default".localized)"
        case .json:
            return "\("error_json".localized) \("error_message_default".localized)"
        case .nonHTTP:
            return "\("error_http".localized) \("error_message_default".localized)"
        case .status(let int):
            return "\("error_status".localized) \(int)"
        case .invalidData:
            return "error_invalid_data".localized
        case .noData:
            return "\("error_no_data".localized)"
        case .defaultError(let message):
            return message
        }
    }
}

struct DefaultError: LocalizedError {
    var messageDefault: String
}

struct APIErrorCodeMessage: LocalizedError, Codable {
    var reason: String?
}

