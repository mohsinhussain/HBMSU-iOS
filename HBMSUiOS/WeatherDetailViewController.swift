//
//  DetailViewController.swift
//  HBMSUiOS
//
//  Created by Mohsin Hussain on 8/22/18.
//  Copyright © 2018 Mohsin Hussain. All rights reserved.
//


import UIKit
import Alamofire
import AlamofireImage

class WeatherDetailViewController: UIViewController{
    
    var titleText: String?
    var descText: String?
    var tempText: String?
    var minTempText: String?
    var maxTempText: String?
    var humidityText: String?
    var airText: String?
    var windText: String?
    var cloudsText: String?
    var iconText: String?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var airLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var cloudsLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if titleText != nil
        {
            self.titleLabel.text = titleText
            self.dateLabel.text = descText
            self.tempLabel.text = tempText
            self.minTempLabel.text = minTempText
            self.maxTempLabel.text = maxTempText
            self.humidityLabel.text = humidityText
            self.airLabel.text = airText
            self.windLabel.text = windText
            self.cloudsLabel.text = cloudsText
            Alamofire.request("http://openweathermap.org/img/w/"+iconText!+".png").responseImage { response in
                debugPrint(response)
                
                if let image = response.result.value {
                    self.iconImageView.image = image
                }
            }
        }
    }
}
