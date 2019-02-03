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
        
        static public func UpdateUser(user: GFUser) -> String {
            let tableName = "users"
            let dest = "update.php"
            
            let values : [String:String] = [
                "user_id": user.userId,
                "f_name": user.fName!,
                "l_name": user.lName!,
                "user_name": user.userName,
                "password": user.password
            ]
            
            
            let response = UpdateData(tableName: tableName, dest: dest, id: Int(user.userId)!, value: values) { (error) in
                
                if error != nil {
                    print(error!.localizedDescription)
                }
            }
            
            return DataToString(data: response)
        }
        
        //        static public func UpdateParticipant(user: GFPatricipant) -> String {
        //            let tableName = "p_events"
        //            let dest = "update.php"
        //            let response = InsertData(tableName: tableName, dest: dest, value: user)
        //
        //            return DataToString(data: response)
        //        }
        //
        //        static public func UpdateLocation(location: GFLocation) -> String {
        //            let tableName = "locations"
        //            let dest = "update.php"
        //            let response = InsertData(tableName: tableName, dest: dest, value: location)
        //
        //            return DataToString(data: response)
        //        }
        //
        //        static public func UpdateEvent(event: GFEvent) -> String {
        //            let tableName = "events"
        //            let dest = "update.php"
        //            let response = InsertData(tableName: tableName, dest: dest, value: event)
        //
        //            return DataToString(data: response)
        //        }
        
        
        
    }
}
