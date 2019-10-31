//
//  Codable+Extension.swift
//  Created by Yehya El Zein on 8/27/18.

import Foundation


extension Encodable {
    func Encode() throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return try encoder.encode(self)
    }
}

extension Decodable {
    static func Decode(data: Data) throws -> Self {
        let decoder = JSONDecoder()
        return try decoder.decode(Self.self, from: data)
    }
}
