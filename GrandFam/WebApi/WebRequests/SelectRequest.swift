//
//  SelectRequest.swift
//  GrandFam
//
//  Created by Filip Palmqvist on 2018-12-20.
//  Copyright © 2018 Filip Palmqvist. All rights reserved.
//

import Foundation

extension WebApi {
    
    class Select {
        
        static public func GetEvents(cond: String = "") -> [GFEvent]{
            
            let tableName = "events"
            let data = getData(tableName: tableName, cond: cond)
            var eventData = [GFEvent]()
            
            do {
                //Decode retrived data with JSONDecoder and assing type of GFObject object
                let resultData = try JSONDecoder().decode([GFEvent].self, from: data)
                
                eventData = resultData
            } catch let jsonError {
                print(jsonError)
            }
            return eventData
        }
        
        static public func GetLocations(cond: String = "") -> [GFLocation]{
            
            let tableName = "locations"
            let data = getData(tableName: tableName, cond: cond) //makeRequest(sql: sql, dest: dest)
            var locationData = [GFLocation]()
            
            do {
                //Decode retrived data with JSONDecoder and assing type of GFObject object
                let eventData = try JSONDecoder().decode([GFLocation].self, from: data)
                
                locationData = eventData
            } catch let jsonError {
                print(jsonError)
            }
            return locationData
        }
        
        static public func GetUsers(cond: String = "") -> [GFUser]{
            
            let tableName = "users"
            
            let data = getData(tableName: tableName, cond: cond)
            var userData = [GFUser]()
            
            do {
                //Decode retrived data with JSONDecoder and assing type of GFObject
                let eventData = try JSONDecoder().decode([GFUser].self, from: data)
                
                userData = eventData
            } catch let jsonError {
                print(jsonError)
            }
            return userData
        }
        
        static public func GetParticipants(eventId: String) -> [GFPatricipant] {
            
            let tableName = "event_p"
            let cond = " join users on event_p.user_id = users.user_id where event_id = \(eventId)"
            var pData = [GFPatricipant]()
            
            let data = getData(tableName: tableName, cond: cond)
            
            do {
                //Decode retrived data with JSONDecoder and assing type of GFObject
                let eventData = try JSONDecoder().decode([GFPatricipant].self, from: data)
                
                pData = eventData
            } catch let jsonError {
                print(jsonError)
            }
            return pData
        }
        
        static public func GetParticipantInfo(eventId: Int) -> [GFPatricipant] {
            
            let tableName = "event_p"
            let cond = " where event_id = \(eventId)"
            var partData = [GFPatricipant]()
            
            let data = getData(tableName: tableName, cond: cond)
            
            do {
                //Decode retrived data with JSONDecoder and assing type of GFObject
                let eventData = try JSONDecoder().decode([GFPatricipant].self, from: data)
                
                partData = eventData
            } catch let jsonError {
                print(jsonError)
            }
            return partData
        }
    }
}
