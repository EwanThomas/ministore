import Foundation

protocol URLSessionResourceLoading {
    func load(url: URL) async throws -> (Data ,URLResponse)
}

extension URLSession: URLSessionResourceLoading {
    func load(url: URL) async throws -> (Data ,URLResponse)  {
        return try await data(from: url)
    }
}
