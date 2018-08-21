//
//  Hero.swift
//  HBMSUiOS
//
//  Created by Mohsin Hussain on 8/22/18.
//  Copyright © 2018 Mohsin Hussain. All rights reserved.
//

import Foundation


class ForeCast {
    
    var dt: Int?
    var main: Main?
    var weather: Weather?
    var clouds: Clouds?
    var wind: Wind?
    var dt_txt: String?
    var humidity: Int?
    
    init(dt: Int?, main: Main?, weather: Weather?,clouds: Clouds?, wind: Wind?, dt_txt: String?, humidity: Int?) {
        self.dt = dt
        self.main = main
        self.weather = weather
        self.clouds = clouds
        self.wind = wind
        self.dt_txt = dt_txt
    }
}
