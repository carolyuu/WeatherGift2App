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
    
    func getData() {
        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&exclude=minutely&units=imperial&appid=\(APIkeys.openWeatherKey)"
        
        print("🕸 we are accessing the url \(urlString)")
        
        // create a URL
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: could not create a URL from \(urlString)")
            return
        }
        
        // create session
        let session = URLSession.shared
        
        // get data with .dataTask method
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("😡 ERROR: \(error.localizedDescription)")
            }
            
            // note: there are some additional things that could go wrong when using URLSession, but we shouldn't experience them, so we'll ignore tesing for these for now...
            
            // deal with the data
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print("😎\(json)")
            } catch {
                print("😡 JSON ERROR: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
}
