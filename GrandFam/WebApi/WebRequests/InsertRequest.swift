//
//  InsertRequest.swift
//  GrandFam
//
//  Created by Filip Palmqvist on 2018-12-21.
//  Copyright © 2018 Filip Palmqvist. All rights reserved.
//

import Foundation

extension WebApi {
    
    class Insert {
        
        static public func InsertUser(user: GFUser) -> String {
            let tableName = "users"
            let dest = "insert.php"
            let response = InsertData(tableName: tableName, dest: dest, encodableValue: user) { (error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
            }
            
            return DataToString(data: response)
        }
        
        static public func InsertParticipant(user: GFPatricipant) -> String {
            let tableName = "p_events"
            let dest = "insert.php"
            let response = InsertData(tableName: tableName, dest: dest, encodableValue: user) { (error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
            }
            
            return DataToString(data: response)
        }
        
        static public func InsertLocation(location: GFLocation) -> String {
            let tableName = "locations"
            let dest = "insert.php"
            let response = InsertData(tableName: tableName, dest: dest, encodableValue: location) { (error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
            }
            
            return DataToString(data: response)
        }
        
        static public func InsertEvent(event: GFEvent) -> String {
            let tableName = "events"
            let dest = "insert.php"
            let response = InsertData(tableName: tableName, dest: dest, encodableValue: event) { (error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
            }
            
            return DataToString(data: response)
        }
        
        
    }
}
