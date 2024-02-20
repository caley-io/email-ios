//
//  EmailModel.swift
//  Caley
//
//  Created by Jeremy Scatigna on 20/02/2024.
//

import Foundation
import SwiftData

@Model
class Email: Codable {
    
    @Attribute(.unique)
    var id: Int?
    
    let subject: String
    let from: String
    let userAvatar: String
    let to: String
    let body: String
    let summary: String
    let urgency: String
    
    enum CodingKeys: String, CodingKey {
        case actions
        case id
        case subject
        case from
        case userAvatar
        case to
        case body
        case summary
        case urgency
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int?.self, forKey: .id)
        self.subject = try container.decode(String.self, forKey: .subject)
        self.from = try container.decode(String.self, forKey: .from)
        self.userAvatar = try container.decode(String.self, forKey: .userAvatar)
        self.to = try container.decode(String.self, forKey: .to)
        self.body = try container.decode(String.self, forKey: .body)
        self.summary = try container.decode(String.self, forKey: .summary)
        self.urgency = try container.decode(String.self, forKey: .urgency)

    }
    
    func encode(to encoder: Encoder) throws {
      // TODO: Handle encoding if you need to here
    }
}
