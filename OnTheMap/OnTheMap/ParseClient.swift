//
//  ParseClient.swift
//  OnTheMap
//
//  Created by Gamal Gamaleldin on 2/12/19.
//  Copyright © 2019 el3ankaboot. All rights reserved.
//

import Foundation

class ParseClient {
    
    static let appID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    static let apikey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    
    enum Endpoints {
        static let base = "https://parse.udacity.com/parse/classes"
        
        case getLocation
        case limit(Int)
        case skip(Int, Int)
        case order(Bool,String)     //If Bool is true : descending (add -ve sign)
        case Where(String)
        
        var stringValue: String {
            switch self {
            case .getLocation : return ParseClient.Endpoints.base + "/StudentLocation"
            case .limit(let limitTo) : return ParseClient.Endpoints.base + "?limit=\(limitTo)"
            case .skip(let limitTo , let skipBy) : return ParseClient.Endpoints.base + "?limit=\(limitTo)&&skip=\(skipBy)"
            case .order(let descending, let orderBy) : return ParseClient.Endpoints.base + "?order=" + ((descending) ? "-" : "") + "\(orderBy)"
            case.Where(let uniqueID) : return ParseClient.Endpoints.base + "/StudentLocation?where=%7B%22uniqueKey%22%3A%22\(uniqueID)%22%7D"
                
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func getLocations(handler : @escaping (result?, Error?) -> Void){
        var request = URLRequest(url:Endpoints.getLocation.url)
        request.addValue(self.appID, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(self.apikey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                handler(nil,error)
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(result.self, from: data)
                handler(responseObject,nil)
            }
            catch {
                handler(nil,error)
            }
        }
        task.resume()
        
    }
    
    class func getStudentLocation(uniqueID : String , handler : @escaping (Student?, Error?) -> Void){
        var request = URLRequest(url:Endpoints.Where(uniqueID).url)
        request.addValue(self.appID, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(self.apikey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                handler(nil,error)
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(Student.self, from: data)
                handler(responseObject,nil)
            }
            catch {
                handler(nil,error)
            }
        }
        task.resume()
        
    }
    
    class func postStudentLocation (student: Student , handler : @escaping (Data? , Error?)-> Void){
        var request = URLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation")!)
        request.httpMethod = "POST"
        request.addValue(appID, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(apikey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do{
            request.httpBody = try JSONEncoder().encode(student)
        }
        catch {
            print(error)
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                handler(nil,error)
                return
            }
            handler(data,nil)
            print(String(data: data!, encoding: .utf8)!)
        }
        task.resume()
    }
}
