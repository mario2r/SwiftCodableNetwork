# SwiftCodableNetwork

This package contains a simple and generic network layer for your iOS application without having to write a lot of code every time you make a request, avoiding boilerplate.

## Requirements
- iOS 16.0+
- Xcode 15.0+
- Swift 5.0+

## Installation

### Swift Package Manager
in ```Package.swift``` add the following:

```
dependencies: [
    // Dependencies declare other packages that this package depends on.
    // .package(url: /* package url */, from: "1.0.0"),
    .package(url: "https://github.com/Injector/SwiftCodableNetwork.git", from: "1.0.0")
],
targets: [
    .target(
        name: "MyProject",
        dependencies: [..., "SwiftCodableNetwork"]
    )
    ...
]
```

## Basic Usage

DummyEndpoint is an enum that conforms to the Endpoint protocol. It has all the information needed for each endpoint. To add a new service endpoint, just add a new case and complete the information inside each variable: path, method, header and body.

```
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
```

Create your model structure with codables to receive API responses.

```
struct DummyCodable: Codable {
    let identifier: Int
    let name: String
}
```

Finally, let’s talk about the Service, which is the struct responsible for making the request. 

```
protocol DummyServiceable {
    func getDummy() async -> Result<DummyCodable, RequestError>
}

final class DummyService: DummyServiceable {
    func getDummy() async -> Result<DummyCodable, RequestError> {
        return await sendRequest(endpoint: DummyEndpoint.dummy, responseModel: DummyCodable.self)
    }
}
```