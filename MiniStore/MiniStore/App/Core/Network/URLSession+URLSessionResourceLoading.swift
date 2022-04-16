import Foundation

protocol URLSessionResourceLoading {
    func loadResource(url: URL) async throws -> (Data ,URLResponse)
}

extension URLSession: URLSessionResourceLoading {
    func loadResource(url: URL) async throws -> (Data ,URLResponse)  {
        return try await data(from: url)
    }
    
    func loadResource(url: URL, completionHandler: @escaping (Data? ,Error?) -> Void) {
        let dataTask = dataTask(with: url) { data, _, error in
            completionHandler(data, error)
        }
        dataTask.resume()
    }
}
