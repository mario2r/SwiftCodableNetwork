// https://betterprogramming.pub/async-await-generic-network-layer-with-swift-5-5-2bdd51224ea9
// A protocol to set up all endpoints.
public protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
}

// User must override this EndPoint
public extension Endpoint {
    var scheme: String { "https" }
}
