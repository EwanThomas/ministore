import Foundation

struct Resource {
    enum Scheme: String {
        case https = "https"
    }
    
    let scheme: Resource.Scheme
    let host: String
    let path: String
    
    init(
        scheme: Resource.Scheme = .https,
        host: String = "fakestoreapi.com",
        path: String
    ) {
        self.scheme = scheme
        self.host = host
        self.path = path
    }
}

extension Resource {
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme.rawValue
        urlComponents.host = host
        urlComponents.path = path
        return urlComponents.url
    }
}
