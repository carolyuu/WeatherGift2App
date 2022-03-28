//
//  LocationDetailViewController.swift
//  WeatherGift2App
//
//  Created by Carol Yu on 3/26/22.
//

import UIKit

class LocationDetailViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var temperatureLable: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var weatherLocation: WeatherLocation!
    var weatherLocations: [WeatherLocation] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if weatherLocation == nil {
            weatherLocation = WeatherLocation(name: "Current Location", latitude: 0.0, longitude: 0.0)
            weatherLocations.append(weatherLocation)
            
        }
        loadLocations()
        updateUserInterface()
    }
    
    func loadLocations() {
        guard let locationsEncoded = UserDefaults.standard.value(forKey: "weatherLocations") as? Data else {
            print("⚠️ Warning: could not load weatherLocations data from UserDefaults. This would always be the case the first time an app is installed, so if that is the case, ignore this error")
            return
        }
        let decoder = JSONDecoder()
        if let weatherLocations = try? decoder.decode(Array.self, from: locationsEncoded) as [WeatherLocation] {
            self.weatherLocations = weatherLocations
        } else {
            print("Error: Couldn't decode data read from UserDefaults.")
        }
        
    }
    
    func updateUserInterface() {
        dateLabel.text = ""
        placeLabel.text = weatherLocation.name
        temperatureLable.text = "--°"
        summaryLabel.text = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! LocationListViewController
        destination.weatherLocations = weatherLocations
    }
    
    @IBAction func unwindFromLocationListViewController(segue: UIStoryboardSegue) {
        
        let source = segue.source as! LocationListViewController
        weatherLocations = source.weatherLocations
        weatherLocation = weatherLocations[source.selectedLocationIndex]
        updateUserInterface()
        
    }
    
}
