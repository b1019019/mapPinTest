//
//  CustomAnnotationView.swift
//  mapPinTest
//
//  Created by 山田純平 on 2021/10/22.
//

import UIKit
import MapKit

class CustomAnnotationView: MKPinAnnotationView {
    var weatherData: OpenWeatherData? {
        didSet{
            canShowCallout = true
            //事前にアプリの中に画像を入れておいて同期的に取り出すように改変する
            if weatherData != nil {
                print(weatherData?.weather[0].icon)
                let rightImageView = UIImageView(image: UIImage(named: (weatherData?.weather[0].icon)! ))
                rightImageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
                rightImageView.contentMode = .scaleAspectFit
                rightImageView.backgroundColor = UIColor.lightGray
                rightCalloutAccessoryView = rightImageView
            }
            
        }
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func getWeatherData(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        
        let url: URL = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&APPID=97e21808b7b889be6e8f5f656ab3e361")!
        
        let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            //バックグラウンドスレッドからURLにアクセス
            do {
                let decoder: JSONDecoder = JSONDecoder()
                let decodedWeatherData = try decoder.decode(OpenWeatherData.self, from: data!)
                DispatchQueue.main.async {
                    self.weatherData = decodedWeatherData
                }
                print("オープンデータ",self.weatherData)
                
            }
            catch {
                print(error)
            }
        })
        task.resume() //実行する
    }
    
    func getWeatherImage(icon: String) -> UIImage {
        let fixIcon = icon.dropLast() + "d"
        let url = URL(string: "http://openweathermap.org/img/wn/\(fixIcon).png")!
        
        let data = try? Data(contentsOf: url)
        let image = UIImage(data: data!)
        
        return image!
    }
    
}
