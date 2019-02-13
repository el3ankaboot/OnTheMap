//
//  PostInformationViewController.swift
//  OnTheMap
//
//  Created by Gamal Gamaleldin on 2/13/19.
//  Copyright © 2019 el3ankaboot. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class PostInformationViewController : UIViewController {
    
    @IBOutlet weak var locationText: UITextField!
    
    @IBOutlet weak var urlText: UITextField!
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var studentVar: Student!
    
    @IBAction func findLocation(_ sender: Any) {
        guard !((locationText.text?.isEmpty)!) else {
            let alertVC = UIAlertController(title: "Enter Your Location", message: "please enter your location", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.show(alertVC, sender: nil)
            return
        }
        
        guard !((urlText.text?.isEmpty)!) else {
            let alertVC = UIAlertController(title: "Enter your URL", message: "Please enter your URL", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.show(alertVC, sender: nil)
            return
        }
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(locationText.text ?? "") { (clplacemark, error) in
            if let _ = error {
                let alertVC = UIAlertController(title: "Address Not Valid !", message: "The location you entered is not valid", preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler:{(alert: UIAlertAction!) in self.dismiss(animated: true, completion: nil)}))
                
                self.show(alertVC, sender: nil)
                
                return
            }
            
            for place in clplacemark! {
                let coordinate = place.location?.coordinate
                let longitude = coordinate?.longitude
                let latitude = coordinate?.latitude
                
                UdacityClient.getUserData(handler: { (result, error) in
                    if let error = error {
                        print(error)
                        return
                    }
                    else {
                        var student = Student(firstName: "", lastName: "", latitude: latitude!, longitude: longitude!, mapString: (self.locationText?.text)!, mediaURL: (self.urlText?.text)!)
                        
                        do {
                            
                            let json = try JSONSerialization.jsonObject(with: result!, options: []) as! [String: Any]
                            if let error = json["error"]{
                                print(error)
                                return
                            }
                            
                            if let firstName = json["first_name"]{
                                student.firstName = firstName as! String
                            }
                            if let lastName = json["last_name"]{
                               student.lastName = lastName as! String
                            }
                            
                            self.studentVar = student
                            
                        }
                        catch {
                            print(error)
                        }
                        print(result)
                    }
                })
                
                self.performSegue(withIdentifier: "findLocationSegue" , sender: self)
                
            }
            
            
            
        }
   
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        let controller = segue.destination as! AddLocationViewController
        controller.theStudent = studentVar
        
        
    }
    
   
}
