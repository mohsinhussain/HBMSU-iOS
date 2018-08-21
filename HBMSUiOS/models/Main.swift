//
//  Main.swift
//  HBMSUiOS
//
//  Created by Mohsin Hussain on 8/22/18.
//  Copyright © 2018 Mohsin Hussain. All rights reserved.
//

import Foundation


class Main{
    var temp: Double?
    var temp_min: Double?
    var temp_max: Double?
    var pressure: Double?
    var sea_level: Double?
    var grnd_level: Double?
    var humidity: Int?
    
    init(temp: Double?, temp_min: Double?, temp_max: Double?,pressure: Double?, sea_level: Double?, grnd_level: Double?, humidity: Int?) {
        self.temp = temp
        self.temp_min = temp_min
        self.temp_max = temp_max
        self.pressure = pressure
        self.sea_level = sea_level
        self.grnd_level = grnd_level
        self.humidity = humidity
    }
}
