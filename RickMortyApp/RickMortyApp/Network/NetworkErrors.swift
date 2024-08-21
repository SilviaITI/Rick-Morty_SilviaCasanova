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
            return "\("ERROR_GENERAL".localized) \("ERROR_MESSAGE_DEFAULT".localized)"
        case .json:
            return "\("ERROR_JSON".localized) \("ERROR_MESSAGE_DEFAULT".localized)"
        case .nonHTTP:
            return "\("ERROR_HTTP".localized) \("ERROR_MESSAGE_DEFAULT".localized)"
        case .status(let int):
            return "\("ERROR_STATUS".localized) \(int)"
        case .invalidData:
            return "ERROR_INVALID_DATA".localized
        case .noData:
            return "\("ERROR_NO_DATA".localized)"
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

