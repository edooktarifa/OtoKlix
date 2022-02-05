//
//  GetPostsList.swift
//  OtoKlix
//
//  Created by Phincon on 04/02/22.
//

import Foundation

struct GetPostsListModel: Codable {
    
    var id: Int?
    var content, title, publishedAt, createAt, updateAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, content, title
        case publishedAt = "published_at"
        case createAt = "created_at"
        case updateAt = "updated_at"
    }
}
