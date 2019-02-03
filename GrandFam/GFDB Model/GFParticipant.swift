//
//  File.swift
//  GrandFam
//
//  Created by Filip Palmqvist on 2018-12-21.
//  Copyright © 2018 Filip Palmqvist. All rights reserved.
//

import Foundation


class GFPatricipant : GFUser {
    
    public var pId = "0"
    public var eventId: String?
    public var joining = "0"
    public var leaving: String?
    public var pCreated = "0"
    
    private enum DecodingKeys : String, CodingKey {
        
        //  Mapping between class variables and json keys.
        
        case pId = "p_id"
        case eventId = "event_id"
        case joining
        case leaving
        case pCreated = "p_created"
    }
    
    private enum EncodingKeys : String, CodingKey {
        
        //  Order of how the data is to be structured in php.
        
        case pId = "0"
        case eventId = "1"
        case userId = "2"
        case joining = "3"
        case leaving = "4"
        case pCreated = "5"
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        
        self.pId = try container.decode(String.self, forKey: .pId)
        self.eventId = try container.decodeIfPresent(String.self, forKey: .eventId)
        self.joining = try container.decode(String.self, forKey: .joining)
        self.leaving = try container.decodeIfPresent(String.self, forKey: .leaving)
        self.pCreated = try container.decode(String.self, forKey: .pCreated)
    }
    
    override func encode(to encoder: Encoder) throws {
        
        //  From class to json
        
        var container = encoder.container(keyedBy: EncodingKeys.self)
        try container.encode((pId != "0") ? "'\(pId)'" : "DEFAULT", forKey: .pId)
        try container.encode("'\(eventId ?? "")'", forKey: .eventId)
        try container.encode("'\(super.userId)'", forKey: .userId)
        try container.encode((joining != "0") ? "'\(joining)'" : "DEFAULT", forKey: .joining)
        try container.encode("'\(leaving ?? "")'", forKey: .leaving)
        try container.encode((pCreated != "0") ? "'\(pCreated)'" : "DEFAULT", forKey: .pCreated)
    }
}
