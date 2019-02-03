//
//  WebApi.swift
//  GrandFam
//
//  Created by Filip Palmqvist on 2018-12-17.
//  Copyright © 2018 Filip Palmqvist. All rights reserved.
//

import Foundation

class WebApi {
    
    static private let baseSchema = "http"
    static private let baseHost = "www.ansigroup.se"
    static private let baseURLString = baseSchema + "://" + baseHost + "/"
    static private let encoder = JSONEncoder()
    
    static public func DataToString(data: Data) -> String {
        
        var responseString = ""
        
        if let utf8Representation = String(data: data, encoding: .ascii) {
            responseString = utf8Representation
            print(utf8Representation)
        } else {
            responseString = "no readable data received in response"
        }
        return responseString
    }
    
    static public func makeRequest(path: String, request: URLRequest? = nil) -> Data {
        
        let webPath = path.replacingOccurrences(of: " ", with: "%20")
        var reqData = Data()
        let semaphore = DispatchSemaphore(value: 0)
        
        guard let urlbase = URL(string: "http://www.ansigroup.se/", relativeTo: nil)
            else { print("ERROR CREATING URL"); return reqData }
        guard let sendPath = URL(string: webPath, relativeTo: urlbase)
            else { print("ERROR CREATING URL"); return reqData }
        
        let urlRequest = request ?? URLRequest(url: sendPath)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: urlRequest){ (data, response, error) in
            
            if error != nil {
                print(error!.localizedDescription)
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
            }
            
            guard let data = data else { return }
            reqData = data
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        
        return reqData
    }
    
    static public func makePostRequest(dest: String, tableName: String, jsonData: Data) -> URLRequest {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = baseSchema
        urlComponents.host = baseHost
        urlComponents.path = "/" + dest
        urlComponents.queryItems = [URLQueryItem(name: "table", value: tableName)]
        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
        
        // Specify this request as being a POST method
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // Make sure that we include headers specifying that our request's HTTP body
        // will be JSON encoded
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        // ... and set our request's HTTP body
        request.httpBody = jsonData
        print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
        
        return request
    }
    
    static public func getData(tableName: String, dest: String, cond: String) -> Data {
        
        let path = "\(dest)?sql=select * from \(tableName) \(cond == "" ? "" : cond)"
        return makeRequest(path: path)
    }
    
    static public func InsertData(tableName: String, dest: String, encodableValue: GFObject, completion:((Error?) -> Void)?) -> Data {
        
        //  Encode the passed value to json
        var json : Data?
        do {
            json = try encoder.encode(encodableValue)
        } catch {
            completion?(error)
        }
        
        //  Make a postrequest with the Json as body and post it to ansigroup.se
        let request =  makePostRequest(dest: dest, tableName: tableName, jsonData: json!)
        return makeRequest(path: "\(dest)?=\(tableName)", request: request )
    }
    
    static public func UpdateData(tableName: String, dest: String, id: Int, value: [String:String], completion:((Error?) -> Void)?) -> Data {
        
        //  Encode the passed value to json
        var json : Data?
        do {
            json = try encoder.encode(value)
        } catch {
            completion?(error)
        }
        
        let request = makePostRequest(dest: dest, tableName: tableName, jsonData: json!)
        return makeRequest(path: "\(dest)?id=\(id)", request: request)
    }
}
