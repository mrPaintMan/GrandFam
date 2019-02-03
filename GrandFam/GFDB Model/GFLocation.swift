//
//  GFLocation.swift
//  GrandFam
//
//  Created by Filip Palmqvist on 2018-12-17.
//  Copyright © 2018 Filip Palmqvist. All rights reserved.
//

import Foundation

class GFLocation : GFObject {
    
    //  "0" is just placeholder, and indicates that no value has been assigned.
    
    public var locationId: String = "0"
    public var locationTypeId: String?
    public var street: String?
    public var streetNo: String?
    public var zip: String?
    public var city: String?
    public var coordNS: String?
    public var coordEW: String?
    public var created: String = "0"
    
    private enum DecodingKeys : String, CodingKey {
        
        //  Mapping between class variables and json keys.
        
        case locationId = "location_id"
        case locationTypeId = "location_type_id"
        case street
        case streetNo = "street_no"
        case zip
        case city
        case coordNS = "coord_NS"
        case coordEW = "coord_EW"
        case created
    }
    
    private enum EncodingKeys : String, CodingKey {
        
        //  Order of how the data is to be structured in php.
        
        case locationId = "0"
        case locationTypeId = "1"
        case street = "2"
        case streetNo = "3"
        case zip = "4"
        case city = "5"
        case coordNS = "6"
        case coordEW = "7"
        case created = "8"
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        self.locationId = try container.decode(String.self, forKey: .locationId)
        self.locationTypeId = try container.decodeIfPresent(String.self, forKey: .locationTypeId)
        self.street = try container.decodeIfPresent(String.self, forKey: .street)
        self.streetNo = try container.decodeIfPresent(String.self, forKey: .streetNo)
        self.zip = try container.decodeIfPresent(String.self, forKey: .zip)
        self.city = try container.decodeIfPresent(String.self, forKey: .city)
        self.coordNS = try container.decodeIfPresent(String.self, forKey: .coordNS)
        self.coordEW = try container.decodeIfPresent(String.self, forKey: .coordEW)
        self.created = try container.decode(String.self, forKey: .created)
    }
    
    override func encode(to encoder: Encoder) throws {
        
        //  From class to json
        
        var container = encoder.container(keyedBy: EncodingKeys.self)
        
        try container.encode((locationId != "0") ? "'\(locationId)'" : "DEFAULT", forKey: .locationId)
        try container.encode("'\(locationTypeId ?? "")'", forKey: .locationTypeId)
        try container.encode("'\(street ?? "")'", forKey: .street)
        try container.encode("'\(streetNo ?? "")'", forKey: .streetNo)
        try container.encode("'\(zip ?? "")'", forKey: .zip)
        try container.encode("'\(city ?? "")'", forKey: .city)
        try container.encode("'\(coordNS ?? "")'", forKey: .coordNS)
        try container.encode("'\(coordEW ?? "")'", forKey: .coordEW)
        try container.encode((created != "0") ? "'\(created)'" : "DEFAULT", forKey: .created)
    }
    
    
    init(array: [String]) {
        super.init()
        
        if array.count > 7 {
            
            locationTypeId = array[0]
            street = array[1]
            streetNo = array[2]
            zip = array[3]
            city = array[4]
            coordNS = array[5]
            coordEW = array[6]
            created = array[7]
        }
    }
    
}
