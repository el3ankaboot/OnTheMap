//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Gamal Gamaleldin on 2/13/19.
//  Copyright © 2019 el3ankaboot. All rights reserved.
//

import Foundation
import UIKit
import MapKit


class MapViewController : UIViewController , MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var students : [Student]! {
        return appDelegate.students
    }
    var annotations = [MKPointAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for student in students {
            let lat = CLLocationDegrees(student.latitude ?? 0.0)
            let long = CLLocationDegrees(student.longitude ?? 0.0)
            
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = (student.firstName ?? "" ) + " " + (student.lastName ?? "" )
            annotation.subtitle = student.mediaURL ?? ""
            
            annotations.append(annotation)
        }
        
         self.mapView.addAnnotations(annotations)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let toOpen = view.annotation?.subtitle! {
                let url = URL(string: toOpen)!
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
    


    @IBAction func refresh(_ sender: Any) {
        appDelegate.loadLocations()
        mapView.reloadInputViews()
    }
    
    
    
}
