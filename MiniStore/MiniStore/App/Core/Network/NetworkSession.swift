import Foundation

protocol Networking {
    func load<Model: Codable>(_ resource: Resource) async throws -> Model
}

enum NetworkError: Error {
    case badRequest
    case badResponse
    case decode
    case badStatusCode
    case unknown
}

struct NetworkSession: Networking {
    private let urlSession: URLSessionResourceLoading
    
    init(urlSession: URLSessionResourceLoading = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func load<Model: Codable>(_ resource: Resource) async throws -> Model {
        guard let url = resource.url else {
            throw NetworkError.badRequest
        }
        do {
            let (data, response) = try await urlSession.load(url: url)
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.badResponse
            }
            switch response.statusCode {
            case 200...299:
                return try decode(data: data, to: Model.self)
            default:
                throw NetworkError.badStatusCode
            }
        } catch let error {
            throw error
        }
    }
}

private extension NetworkSession {
    func decode<Model: Codable>(data: Data, to model: Model.Type) throws -> Model {
        do {
            return try JSONDecoder().decode(model, from: data)
        } catch {
            throw NetworkError.decode
        }
    }
}
