//
//  Weather.swift
//  task4_app
//
//  Created by Berat Yavuz on 1.09.2023.
//

import Foundation

public struct Weather {
    let city: String
    let temp: String
    let description: String
    let iconName: String
    let temp_min:String
    let temp_max:String
    
    init(response:ApiResponse) {
        city = response.name
        temp = "\(Int(response.main.temp))"
        description = response.weather.first?.description ?? ""
        iconName = response.weather.first?.iconName ?? ""
        temp_min = "\(Int(response.main.temp_min))"
        temp_max = "\(Int(response.main.temp_max))"
    }
    
    
}
