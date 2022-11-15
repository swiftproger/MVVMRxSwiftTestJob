//
//  Info.swift
//  MVVMRxSwiftTestJob
//
//  Created by Александр Новиков on 15.11.2022.
//

import Foundation

struct Info: Codable {
    private var count: Int?
    private var pages: Int?
    private var next: String?
    
    private enum CodingKeys: CodingKey {
        case count, pages, next
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decodeIfPresent(Int.self, forKey: .count)
        self.pages = try container.decodeIfPresent(Int.self, forKey: .pages)
        self.next = try container.decodeIfPresent(String.self, forKey: .next)
    }
    
    public func getCount() -> Int {
        guard let count = count else { return 0 }
        return count
    }
    
    public func getPages() -> Int {
        guard let pages = pages else { return 0 }
        return pages
    }
    
    public func getNextLink() -> String {
        guard let next = next else { return "" }
        return next
    }
}
