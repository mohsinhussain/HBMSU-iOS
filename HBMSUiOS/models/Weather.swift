//
//  Weather.swift
//  HBMSUiOS
//
//  Created by Mohsin Hussain on 8/22/18.
//  Copyright © 2018 Mohsin Hussain. All rights reserved.
//

import Foundation

class Weather {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
    
    init(id: Int?, main: String?, description: String?,icon: String?) {
        self.id = id
        self.main = main
        self.description = description
        self.icon = icon
    }
}
