//
//  HourlyCollectionViewCell.swift
//  WeatherGift2App
//
//  Created by Carol Yu on 3/29/22.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var hourlyTemperature: UILabel!
    
    var hourlyWeather: HourlyWeather! {
        didSet {
            hourLabel.text = hourlyWeather.hour
            iconImageView.image = UIImage(systemName: hourlyWeather.hourlyIcon)
            hourlyTemperature.text = "\(hourlyWeather.hourlyTemperature)°"
            
        }
    }

}
