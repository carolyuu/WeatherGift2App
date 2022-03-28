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
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var weatherLocation: WeatherLocation!
    var locationIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUserInterface()
    }
    
    
    
    func updateUserInterface() {
        let pageViewController = UIApplication.shared.windows.first!.rootViewController as! PageViewController
        weatherLocation = pageViewController.weatherLocations[locationIndex]
        dateLabel.text = ""
        placeLabel.text = weatherLocation.name
        temperatureLable.text = "--°"
        summaryLabel.text = ""
        
        pageControl.numberOfPages = pageViewController.weatherLocations.count
        pageControl.currentPage = locationIndex
        weatherLocation.getData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! LocationListViewController
        let pageViewController = UIApplication.shared.windows.first!.rootViewController as! PageViewController
        destination.weatherLocations = pageViewController.weatherLocations
    }
    
    @IBAction func unwindFromLocationListViewController(segue: UIStoryboardSegue) {
        
        let source = segue.source as! LocationListViewController
        locationIndex = source.selectedLocationIndex
        let pageViewController = UIApplication.shared.windows.first!.rootViewController as! PageViewController
        
        pageViewController.weatherLocations = source.weatherLocations
        pageViewController.setViewControllers([pageViewController.createLocationDeatilViewController(forPage: locationIndex)], direction: .forward, animated: false, completion: nil)

    }

    @IBAction func pageControlTapped(_ sender: UIPageControl) {
        let pageViewController = UIApplication.shared.windows.first!.rootViewController as! PageViewController
        
        var direction : UIPageViewController.NavigationDirection = .forward
        if sender.currentPage < locationIndex {
            direction = .reverse
        }
        
        pageViewController.setViewControllers([pageViewController.createLocationDeatilViewController(forPage: sender.currentPage)], direction: .forward, animated: true, completion: nil)
    }
    
}
