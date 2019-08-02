//
//  Article.swift
//  NewsApp
//
//  Created by Radya Albasha on 8/1/19.
//  Copyright © 2019 Ember. All rights reserved.
//

import Foundation

// MARK: - Article
struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let articleDescription: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
    
    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}
