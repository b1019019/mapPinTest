//
//  MKMapView+Extention.swift
//  mapPinTest
//
//  Created by 山田純平 on 2021/10/29.
//

import UIKit
import MapKit

extension MKMapView {
    func getRoute(source: CLLocationCoordinate2D, dest: CLLocationCoordinate2D) {
        let sourcePlaceMark = MKPlacemark(coordinate: source)
        let destPlaceMark = MKPlacemark(coordinate: dest)
        //経路探索のリクエストを編集
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
        directionRequest.destination = MKMapItem(placemark: destPlaceMark)
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (response, error) in
            guard let directionResponse = response else {
                if let error = error {
                    print("we have error getting directions==\(error.localizedDescription)")
                }
                return
            }
                //　ルートを追加
            let route = directionResponse.routes[0]
            self.addOverlay(route.polyline, level: .aboveRoads)
                //　縮尺を設定
            /*let rect = route.polyline.boundingMapRect
            self.setRegion(MKCoordinateRegion(rect), animated: true)*/
            
        }
    }
}
