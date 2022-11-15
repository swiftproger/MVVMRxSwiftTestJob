//
//  Characters.swift
//  MVVMRxSwiftTestJob
//
//  Created by Александр Новиков on 15.11.2022.
//

import Foundation

struct Characters: Codable {
    private var id: Int?
    private var name: String?
    private var image: String?
    private var url: String?

    private enum CodingKeys: CodingKey {
        case
        id, name, image, url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
    }
    
    public func getId() -> Int {
        guard let id = id else { return 0 }
        return id
    }
    
    public func getName() -> String {
        guard let name = name else { return "" }
        return name
    }
    
    public func getImage() -> String {
        guard let image = image else { return "" }
        return image
    }
    
    public func getUrl() -> String {
        guard let url = url else { return "" }
        return url
    }
}
