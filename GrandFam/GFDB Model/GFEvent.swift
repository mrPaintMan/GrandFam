//
//  GFEntity.swift
//  GrandFam
//
//  Created by Filip Palmqvist on 2018-12-17.
//  Copyright © 2018 Filip Palmqvist. All rights reserved.
//

import Foundation

class GFEvent : GFObject {
    
    public var eventId: String?
    public var locationId: String?
    public var owner: GFUser?
    public var participants: [GFUser]?
    public var eventTypeId: String?
    public var eventName: String?
    public var timeStart: String?
    public var timeStop: String?
    public var created: String?
    
    private enum DecodingKeys : String, CodingKey {
        
        //  Mapping between class variables and json keys.
        
        case eventId = "event_id"
        case locationId = "location_id"
        case owner
        case eventTypeId = "event_type_id"
        case eventName = "event_name"
        case timeStart = "time_start"
        case timeStop = "time_stop"
        case created
    }
    
    private enum EncodingKeys : String, CodingKey {
        
        //  Order of how the data is to be structured in php.
        
        case eventId = "0"
        case locationId = "1"
        case owner = "2"
        case eventTypeId = "3"
        case eventName = "4"
        case timeStart = "5"
        case timeStop = "6"
        case created = "7"
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        
        self.eventId = try container.decodeIfPresent(String.self, forKey: .eventId)
        self.locationId = try container.decodeIfPresent(String.self, forKey: .locationId)
        self.owner = WebApi.Select.GetUsers(cond: "where user_id = \(try container.decodeIfPresent(String.self, forKey: .owner) ?? "0")").first
        self.participants = WebApi.Select.GetParticipants(eventId: try container.decodeIfPresent(String.self, forKey: .eventId) ?? "0")
        self.eventTypeId = try container.decodeIfPresent(String.self, forKey: .eventTypeId)
        self.eventName = try container.decodeIfPresent(String.self, forKey: .eventName)
        self.timeStart = try container.decodeIfPresent(String.self, forKey: .timeStart)
        self.timeStop = try container.decodeIfPresent(String.self, forKey: .timeStop)
        self.created = try container.decodeIfPresent(String.self, forKey: .created)
    }
    
    override func encode(to encoder: Encoder) throws {
        
        //  From class to json
        
        var container = encoder.container(keyedBy: EncodingKeys.self)
        try container.encode((eventId != nil) ? "'\(eventId!)'" : "DEFAULT", forKey: .eventId)
        try container.encode("'\(locationId ?? "")'", forKey: .locationId)
        try container.encode("'\(owner?.userId ?? "")'", forKey: .owner)
        try container.encode("'\(eventTypeId ?? "")'", forKey: .eventTypeId)
        try container.encode("'\(eventName ?? "")'", forKey: .eventName)
        try container.encode((timeStart != nil) ? "'\(timeStart!)'" : "DEFAULT", forKey: .timeStart)
        try container.encode("'\(timeStop ?? "")'", forKey: .timeStop)
        try container.encode((created != nil) ? "'\(created!)'" : "DEFAULT", forKey: .created)
    }
    
    init(array: [String], owner: GFUser, participants: [GFUser]) {
        super.init()
        
        if array.count > 4 {
            
            eventTypeId = array[0]
            locationId = array[1]
            eventName = array[2]
            timeStart = array[3]
            timeStop = array[4]
            self.owner = owner
            self.participants = participants
        }
    }
    
    
    
}


