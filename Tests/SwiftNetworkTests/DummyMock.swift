import SwiftNetwork
import Foundation

enum DummyEndpoint {
    case dummy
}

extension DummyEndpoint: Endpoint {
    var host: String { "dummyHost" }
    
    var path: String {
        switch self {
        case .dummy:
            return "dummy"
        }
    }

    var method: RequestMethod {
        switch self {
        case .dummy:
            return .get
        }
    }

    var header: [String: String]? {
        // Access Token to use in Bearer header
        let accessToken = "123456789"
        switch self {
        case .dummy:
            return [
                "Authorization": "Bearer \(accessToken)",
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }

    var body: [String: String]? {
        switch self {
        case .dummy:
            return nil
        }
    }
}

struct DummyCodable: Codable {
    let identifier: Int
    let name: String
}

protocol DummyServiceable {
    func getDummy() async -> Result<DummyCodable, RequestError>
}

final class DummyServiceMock: Mockable, DummyServiceable {
    func getDummy() async -> Result<DummyCodable, RequestError> {
        return .success(loadJSON(filename: "dummy", type: DummyCodable.self))
    }
}
