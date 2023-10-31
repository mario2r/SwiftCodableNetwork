import Foundation

// Protocol that avoids boilerplate with a default implementation of the loadJSON function,
// which reads an internal .json file and converts it into a given Codable model
public protocol Mockable: AnyObject {
    var bundle: Bundle { get }
    func loadJSON<T: Decodable>(filename: String, type: T.Type) -> T
}

public extension Mockable {
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }

    func loadJSON<T: Decodable>(filename: String, type: T.Type) -> T {
        guard let path = Bundle.module.url(forResource: filename, withExtension: "json") else {
            fatalError("Failed to load JSON")
        }
        do {
            let data = try Data(contentsOf: path)
            let decodedObject = try JSONDecoder().decode(type, from: data)

            return decodedObject
        } catch {
            fatalError("Failed to decode loaded JSON")
        }
    }
}
