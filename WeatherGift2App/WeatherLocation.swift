//
//  WeatherLocation.swift
//  WeatherGift2App
//
//  Created by Carol Yu on 3/26/22.
//

import Foundation

struct WeatherLocation: Codable {
    var name: String
    var latitude: Double
    var longitude: Double
    
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}
