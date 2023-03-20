import Foundation

public final class NetworkCustom {
    public static let shared: NetworkCustom = .init()

    public func getJSON<JSON: Codable>(url: URL, type: JSON.Type) async throws -> JSON {
        let (data, response) = try await URLSession.shared.dataRequest(from: url)
        guard let response = response as? HTTPURLResponse else { throw NetworkError.noHTTP }
        if response.statusCode == 200 {
            do {
                return try JSONDecoder().decode(JSON.self, from: data)
            } catch {
                throw NetworkError.json(error)
            }
        } else {
            throw NetworkError.status(response.statusCode)
        }
    }
}
