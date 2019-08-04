//
//  Sources.swift
//  NewsApp
//
//  Created by Radya Albasha on 8/3/19.
//  Copyright © 2019 Ember. All rights reserved.
//

import Foundation
// MARK: - Sources
struct Sources: Codable {
    let status: String
    let sources: [Source]
}

// MARK: - Source
struct Source: Codable {
    let id, name, sourceDescription: String
    let url: String
    let category, language, country: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case sourceDescription = "description"
        case url, category, language, country
    }
}
