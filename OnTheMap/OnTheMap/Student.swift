//
//  Student.swift
//  OnTheMap
//
//  Created by Gamal Gamaleldin on 2/12/19.
//  Copyright © 2019 el3ankaboot. All rights reserved.
//

import Foundation

struct result: Codable {
    var results : [Student]
}



struct Student :Codable {
    var createdAt : String?
    var firstName : String?
    var lastName : String?
    var latitude : Double?
    var longitude : Double?
    var mapString : String?
    var mediaURL : String?
    var objectId : String?
    var uniqueKey : String?
    var updatedAt : String?
    
    init( firstName: String , lastName: String , latitude: Double , longitude: Double , mapString: String , mediaURL : String){
       
        self.firstName = firstName
        self.lastName = lastName
        self.latitude = latitude
        self.longitude = longitude
        self.mapString = mapString
        self.mediaURL = mediaURL
        
    }
}
