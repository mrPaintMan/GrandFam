//
//  UpdateRequest.swift
//  GrandFam
//
//  Created by Filip Palmqvist on 2018-12-26.
//  Copyright © 2018 Filip Palmqvist. All rights reserved.
//

import Foundation

extension WebApi {
    
    class Update {
        
//        static private func CheckChanges(object: GFObject, id: Int, table: String) -> Bool  {
//            let dest = "select.php"
//            switch type(of: object) {
//                
//            case is GFUser:
//                let user = object as! GFUser
//                let orgUser = WebApi.Select.GetUsers(cond: "WHERE user_id = \(user.userId)")
//                if user[0] == orgUser {
//                    return true
//                }
//                
//                break
//
//            case is GFEvent:
//
//                break
//
//            case is GFLocation:      // Incomplete function to check wether there is anything to update or not.
//                                     // This, by comparing existing data from database, wioth the altered data in the passed object.
//                break
//
//            case is GFPatricipant:
//
//                break
//
//            default:
//                return false
//            }
//
//            return false
//        }
        
        static public func UpdateUser(user: GFUser) -> String {
            
            let tableName = "users"
            let values : [String:String] = [
                "f_name": "'\(user.fName!)'",
                "l_name": "'\(user.lName!)'",
                "user_name": "'\(user.userName)'",
                "password": "'\(user.password)'"
            ]
            
            let response = UpdateData(tableName: tableName, id: "user_id=\(user.userId)", value: values) { (error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
            }
            return DataToString(data: response)
        }
        
        static public func UpdateParticipant(user: GFPatricipant) -> String {
            
            let tableName = "event_p"
            let values : [String:String] = [
                "event_id": user.eventId!,
                "user_id": user.userId,
                "joining": "'\(user.joining)'",
                "leaving": "'\(user.leaving!)'"
            ]
            
            let response = UpdateData(tableName: tableName, id: "p_id=\(user.pId)", value: values) { (error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
            }
            return DataToString(data: response) + " and " + UpdateUser(user: user)
        }

        static public func UpdateLocation(location: GFLocation) -> String {
            
            let tableName = "locations"
            let values : [String:String] = [
                "location_type_id": location.locationTypeId!,
                "street": "'\(location.street!)'",
                "street_no": location.streetNo ?? "",
                "zip": location.zip!,
                "city": "'\(location.city!)'",
                "coord_NS": location.coordNS!,
                "coord_EW": location.coordEW!
            ]
            
            let response = UpdateData(tableName: tableName, id: "location_id=\(location.locationId)", value: values) { (error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
            }
            return DataToString(data: response)
        }

        static public func UpdateEvent(event: GFEvent) -> String {
            
            let tableName = "events"
            let values : [String:String] = [
                "location_id": event.locationId ?? "0",
                "owner": event.owner!.userId,
                "event_type_id": event.eventTypeId!,
                "event_name": "'\(event.eventName ?? "no-name")'",
                "time_start": event.timeStart!,
                "time_stop": event.timeStop!
            ]
            
            let response = UpdateData(tableName: tableName, id: "event_id=\(event.eventId!)", value: values) { (error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
            }
            return DataToString(data: response)
        }
    }
}
