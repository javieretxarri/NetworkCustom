//
//  Extensions.swift
//
//
//  Created by Javier Etxarri on 20/3/23.
//

import Foundation

public extension URLSession {
    func dataRequest(from: URL) async throws -> (Data, URLResponse) {
        do {
            return try await data(from: from)
        } catch {
            throw NetworkError.general(error)
        }
    }
}

public enum NetworkError: Error {
    case general(Error)
    case status(Int)
    case json(Error)
    case dataNotValid
    case noHTTP
    case unknown

    public var description: String {
        switch self {
        case .general(let error):
            return "Error general \(error.localizedDescription)"
        case .status(let int):
            return "Error de Status: \(int)"
        case .json(let error):
            return "Error en el JSON: \(error)"
        case .dataNotValid:
            return "Dato no válido"
        case .noHTTP:
            return "No es una conexión HTTP"
        case .unknown:
            return "Error desconocido"
        }
    }
}
