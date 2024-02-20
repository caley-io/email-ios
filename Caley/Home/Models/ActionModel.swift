//
//  ActionModel.swift
//  Caley
//
//  Created by Jeremy Scatigna on 20/02/2024.
//

import Foundation
import SwiftData

@Model
class Action: Codable {
    
    @Attribute(.unique)
    var id: Int?
    
    let title: String
    let status: String
    let from: String
    let userAvatar: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case status
        case from
        case userAvatar
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int?.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.status = try container.decode(String.self, forKey: .status)
        self.from = try container.decode(String.self, forKey: .from)
        self.userAvatar = try container.decode(String.self, forKey: .userAvatar)
    }
    
    func encode(to encoder: Encoder) throws {
      // TODO: Handle encoding if you need to here
    }
}
