//
//  NetworkPersistance.swift
//  RickMortyApp
//
//  Created by Silvia Casanova Martinez on 21/8/24.
//

import Foundation

extension NetworkInterface {
    /// Método para obtener un JSON lanzando una petición asíncrona y controlando los errores
    func response<T: Codable>() async throws -> T {
        var request = URLRequest.request(networkRequest: self)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else { throw APIErrors.nonHTTP }
            
            debugPrint("📩 Response received with status code: \(httpResponse.statusCode)")
            
            switch httpResponse.statusCode {
            case 200...299:
                debugPrint("✅ \(request.httpMethod ?? "") (\(httpResponse.statusCode)): \(request.url!)")
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                debugPrint("🧠 Data: ", json ?? "No data")
                
                if data.isEmpty, T.self == EmptyResponse.self {
                    guard let emptyResponse = EmptyResponse() as? T else {
                        throw APIErrors.noData
                    }
                    return emptyResponse
                }
                
                do {
                    return try JSONDecoder().decode(T.self, from: data)
                } catch {
                    debugPrint("❌ JSONError \(request.httpMethod ?? "") (\(httpResponse.statusCode)): \(request.url!)")
                    // debugPrint("JSONError \(String(describing: try! JSONDecoder().decode(T.self, from: data)))")
                    throw APIErrors.json
                }
                
            case 400...499:
                debugPrint("❌ Client error \(request.httpMethod ?? "") (\(httpResponse.statusCode)): \(request.url!)")
                let dec = JSONDecoder()
                if let apiError = try? dec.decode(APIErrorCodeMessage.self, from: data) {
                    throw apiError
                } else {
                    throw APIErrors.defaultError("Client error \(httpResponse.statusCode)")
                }
                
            case 500...599:
                debugPrint("❌ Server error \(request.httpMethod ?? "") (\(httpResponse.statusCode)): \(request.url!)")
                throw APIErrors.defaultError("Server error \(httpResponse.statusCode)")
                
            default:
                debugPrint("❌ Unexpected error \(request.httpMethod ?? "") (\(httpResponse.statusCode)): \(request.url!)")
                throw APIErrors.defaultError("Unexpected error \(httpResponse.statusCode)")
            }
        } catch {
            if let error = error as? APIErrors {
                throw error
            } else {
                throw APIErrors.general
            }
        }
    }
}
