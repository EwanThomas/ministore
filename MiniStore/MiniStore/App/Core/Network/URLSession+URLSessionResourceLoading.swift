import Foundation

protocol URLSessionResourceLoading {
    func loadResource(url: URL) async throws -> (Data ,URLResponse)
}

extension URLSession: URLSessionResourceLoading {
    func loadResource(url: URL) async throws -> (Data ,URLResponse)  {
        return try await data(from: url)
    }
}
