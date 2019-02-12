//
//  UdacityClient.swift
//  OnTheMap
//
//  Created by Gamal Gamaleldin on 2/12/19.
//  Copyright © 2019 el3ankaboot. All rights reserved.
//

import Foundation


class UdacityClient {
    
    struct UdacityAuth {
        static var accountId = 0
        static var sessionId = ""
    }
    
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1"
        
        
        case login
        
        var stringValue : String {
            switch self {
            case .login :
                return Endpoints.base + "/session"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func login (username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        var request = URLRequest(url: Endpoints.login.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}".data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                
                completion(false,error)
                return
            }
            let range = 5..<data!.count
            let newData = data?.subdata(in: range)
            
            print(String(data: newData!, encoding: .utf8)!)
            do {
                
                let json = try JSONSerialization.jsonObject(with: newData!, options: []) as! [String: Any]
                if let _ = json["error"]{
                    
                    completion(false, nil)
                    return
                }
                
                completion(true,nil)
                
            }
            catch {
                completion(false,error)
            }
            
            
        }
        task.resume()
    }
    
}
