//
//  Weather.swift
//  WeatherApp
//
//  Created by Senghuot Lim on 5/16/16.
//  Copyright © 2016 Home Brew. All rights reserved.
//

import Foundation

struct Weather {
    let location: String
    let description: String
    let temperature: Double
    let icon: String
    
    init(location: String, description: String, temperature: Double, icon: String) {
        self.location = location
        self.description = description
        self.temperature = temperature
        self.icon = icon
    }
}