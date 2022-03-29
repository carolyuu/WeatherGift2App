//
//  LocationDetailViewController.swift
//  WeatherGift2App
//
//  Created by Carol Yu on 3/26/22.
//

import UIKit

private let dateFormatter: DateFormatter = {
    print("📆 I JUST CREATED A DATE FORMATTER!")
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE, MMM d, h:mm aaa"
    return dateFormatter
}()

class LocationDetailViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var temperatureLable: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var weatherDetail: WeatherDetail!
    var locationIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUserInterface()
    }
    
    
    
    func updateUserInterface() {
        let pageViewController = UIApplication.shared.windows.first!.rootViewController as! PageViewController
        let weatherLocation = pageViewController.weatherLocations[locationIndex]
        weatherDetail = WeatherDetail(name: weatherLocation.name, latitude: weatherLocation.latitude, longitude: weatherLocation.longitude)
        
        
        pageControl.numberOfPages = pageViewController.weatherLocations.count
        pageControl.currentPage = locationIndex
        
        weatherDetail.getData {
            DispatchQueue.main.async {
                dateFormatter.timeZone = TimeZone(identifier: self.weatherDetail.timezone)
                let usableDate = Date(timeIntervalSince1970: self.weatherDetail.currentTime)
                self.dateLabel.text = dateFormatter.string(from: usableDate)
                self.placeLabel.text = self.weatherDetail.name
                self.temperatureLable.text = "\(self.weatherDetail.temperature)°"
                self.summaryLabel.text = self.weatherDetail.summary
                self.imageView.image = UIImage(named: self.weatherDetail.dailyIcon)
            }
        }
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
