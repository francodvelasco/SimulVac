import SwiftUI

public extension Color { 
    public static let backgroundColor = Color(red: 232 / 255, green: 232 / 255, blue: 237 / 255)
}

public extension Dictionary where Self.Value == Int {
    func asTupleArray() -> [(Self.Key, Int)] {
        var array: [(Self.Key, Int)] = []
        let keys = self.keys
        
        for key in keys {
            array.append((key, self[key]!))
        }
        
        return array
    }
}

