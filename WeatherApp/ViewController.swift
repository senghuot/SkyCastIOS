//
//  ViewController.swift
//  WeatherApp
//
//  Created by Senghuot Lim on 5/13/16.
//  Copyright © 2016 Home Brew. All rights reserved.
//

import UIKit

class ViewController: UIViewController, WeatherServiceDelegate {
    
    let weatherService = WeatherService()
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    @IBAction func setLocationTapped(sender: UIButton) {
        openCityAlert()
    }
    
    @IBOutlet weak var imageViewIcon: UIImageView!
    func openCityAlert() {
        let alert = UIAlertController(title: "City",
                                      message: "Enter location name",
                                      preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: "OK",
                               style: UIAlertActionStyle.Default) { (action: UIAlertAction) in
                                self.weatherService.getWeather((alert.textFields?[0].text!)!)
        })
        
        alert.addAction(UIAlertAction(title: "Cancel",
                                   style: .Cancel,
                                   handler: nil))
        
        alert.addTextFieldWithConfigurationHandler { (uiTextField: UITextField) in
            uiTextField.placeholder = "Location"
        }
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // MARK: Weather Service Delegate
    func setWeather(weather: Weather) {
        tempLabel.text! = "\(weather.temperature) F"
        cityLabel.text! = weather.location
        desLabel.text! = weather.description
//        print(weather.icon)
        iconImage.image = UIImage(named: weather.icon)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        weatherService.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

