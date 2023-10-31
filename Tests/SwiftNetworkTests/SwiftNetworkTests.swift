import XCTest
@testable import SwiftNetwork

final class SwiftNetworkTests: XCTestCase {
    func testEnpoint() throws {
        let sut: Endpoint = DummyEndpoint.dummy
        let headers = [
            "Authorization": "Bearer 123456789",
            "Content-Type": "application/json;charset=utf-8"
        ]
        XCTAssertEqual(sut.scheme, "https")
        XCTAssertEqual(sut.host, "dummyHost")
        XCTAssertEqual(sut.path, "dummy")
        XCTAssertEqual(sut.method, .get)
        XCTAssertEqual(sut.header, headers)
        XCTAssertNil(sut.body)
    }

    func testHTTPClientSuccess() async throws {
        let sut = DummyServiceMock()
        switch await sut.getDummy() {
        case .success(let dummy):
            XCTAssertEqual(dummy.identifier, 1)
            XCTAssertEqual(dummy.name, "Dummy")
        case .failure:
            XCTFail("The request should not fail")
        }
    }
}
