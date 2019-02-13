//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by Gamal Gamaleldin on 2/13/19.
//  Copyright © 2019 el3ankaboot. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class AddLocationViewController : UIViewController {
    
    var theStudent : Student!
    
    
    @IBAction func finish(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        theStudent = appDelegate.theStudent
        appDelegate.putLocation(student: theStudent) { (data, error) in
            if let error = error {
                print(error)
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    
}
