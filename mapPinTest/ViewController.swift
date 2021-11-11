//
//  ViewController.swift
//  mapPinTest
//
//  Created by 山田純平 on 2021/10/13.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.delegate = self
        }
    }
    //セマフォについて記事で書く
    
    //復習
    @IBAction func longPressMap(_ sender: UILongPressGestureRecognizer) {
        let location: CGPoint = sender.location(in: mapView)
        if sender.state == UIGestureRecognizer.State.ended {
            let mapPoint: CLLocationCoordinate2D = mapView.convert(location, toCoordinateFrom: mapView)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(mapPoint.latitude, mapPoint.longitude)
            annotation.title = "目的地"
            
            mapView.addAnnotation(annotation)
            
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    
}


extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        /*
        let testView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        testView.canShowCallout = true
        
        let rightImageView = UIImageView(image: getWeatherImage(icon: (openWeatherData?.weather[0].icon)!))
        rightImageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        rightImageView.contentMode = .scaleAspectFit
        rightImageView.backgroundColor = UIColor.lightGray
        testView.rightCalloutAccessoryView = rightImageView
        
        return testView
        */
        let customAnnotationView = CustomAnnotationView(annotation: annotation, reuseIdentifier: nil)
        customAnnotationView.getWeatherData(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
        return customAnnotationView
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        //経路設定
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 4.0
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let presentLocation = CLLocationCoordinate2DMake(41.75770240785372, 140.46292658775687)
        if let annotation = view.annotation {
            mapView.getRoute(source: presentLocation, dest: annotation.coordinate)
        }
        
        
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        for overlay in mapView.overlays {
            if overlay as? MKPolyline != nil{
                mapView.removeOverlay(overlay)
            }
        }
    }
    /*
     func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
     let calloutView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
     calloutView.backgroundColor = UIColor.red
     view.addSubview(calloutView)
     
     }
     
     func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
     view.subviews.forEach {
     $0.removeFromSuperview()
     }
     }
     */
}

