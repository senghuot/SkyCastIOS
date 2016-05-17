//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Senghuot Lim on 5/16/16.
//  Copyright © 2016 Home Brew. All rights reserved.
//

import Foundation

protocol WeatherServiceDelegate {
    func setWeather(weather: Weather)
}

class WeatherService {
    
    var delegate: WeatherServiceDelegate?
    
    func getWeather(city: String) {
        let cityEscaped = city.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
        let path = "http://52.53.195.194/search?keyword=\(cityEscaped!)"
        let url = NSURL(string: path)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data: NSData?, res: NSURLResponse?, err: NSError?) in
            
            var status = 0
            if let httpRes = res as? NSHTTPURLResponse {
                status = httpRes.statusCode
            }
            
            if status == 200 {
                let json = JSON(data: data!)
                if json == nil {
                    print("SwiftyJSON failed given data")
                    return
                }
                
                let weather = Weather(location: json["keyword"].string!,
                                      description: json["data"][0]["summary"].string!,
                                      temperature: json["data"][0]["temperatureMax"].double!,
                                      icon: "\(json["data"][0]["icon"].string!).png")
                
                if self.delegate != nil {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.delegate?.setWeather(weather)
                    })
                }
                
            } else {
                print("requeset failed.")
            }
        
            
        }
        
        task.resume()
        
    }
}
