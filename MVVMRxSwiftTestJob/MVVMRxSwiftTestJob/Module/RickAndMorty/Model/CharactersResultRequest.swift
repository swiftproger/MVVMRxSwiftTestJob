//
//  CharactersResultRequest.swift
//  MVVMRxSwiftTestJob
//
//  Created by Александр Новиков on 15.11.2022.
//

import Foundation

struct CharactersResultRequest: Codable {
    private var info: Info?
    private var results: [Characters]?
    
    private enum CodingKeys: CodingKey {
        case info, results
    }
    
    public init() {}
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.info = try container.decodeIfPresent(Info.self, forKey: .info)
        self.results = try container.decodeIfPresent([Characters].self, forKey: .results)
    }
    
    public func getInfo() -> Info {
        guard let info = info else { return Info() }
        return info
    }
    
    public func getCharacters() -> [Characters] {
        guard let results = results else { return [] }
        return results
    }
}
