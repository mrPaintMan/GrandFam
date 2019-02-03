//
//  GFUser.swift
//  GrandFam
//
//  Created by Filip Palmqvist on 2018-12-17.
//  Copyright © 2018 Filip Palmqvist. All rights reserved.
//

import Foundation


class GFUser : GFObject{
    
    //  "0" is just placeholder, and indicates that no value has been assigned.
    
    public var userId = "0"
    public var fName: String?
    public var lName: String?
    public var created = "0"
    public var userName = "0"
    public var password = "0"
    
    private enum DecodingKeys : String, CodingKey {
        
        //  Mapping between class variables and json keys.
        
        case userId = "user_id"
        case fName = "f_name"
        case lName = "l_name"
        case userName = "user_name"
        case password
        case created
    }
    
    private enum EncodingKeys : String, CodingKey {
        
        //  Order of how the data is to be structured in php.
        
        case userId = "0"
        case fName = "1"
        case lName = "2"
        case userName = "3"
        case password = "4"
        case created = "5"
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        
        self.userId = try container.decode(String.self, forKey: .userId)
        self.fName = try container.decodeIfPresent(String.self, forKey: .fName)
        self.lName = try container.decodeIfPresent(String.self, forKey: .lName)
        self.created = try container.decode(String.self, forKey: .created)
    }
    
    override func encode(to encoder: Encoder) throws {
        
        //  From class to json
        
        var container = encoder.container(keyedBy: EncodingKeys.self)
        try container.encode((userId != "0") ? "'\(userId)'" : "DEFAULT", forKey: .userId)
        try container.encode("'\(fName ?? "")'", forKey: .fName)
        try container.encode("'\(lName ?? "")'", forKey: .lName)
        try container.encode("'\(userName)'", forKey: .userName)
        try container.encode("'\(password)'", forKey: .password)
        try container.encode((created != "0") ? "'\(created)'" : "DEFAULT", forKey: .created)
    }
    
    init (fName: String, lName: String, userName: String, password: String, created: String = "0"){
        super.init()
        self.fName = fName
        self.lName = lName
        self.userName = userName
        self.password = password
        self.created = created
    }
    
    init(array: [String] ){
        super.init()
        
        if array.count > 2 {
            
            self.fName = array[0]
            self.lName = array[1]
            self.created = array[2]
        }
    }
    
    
}
