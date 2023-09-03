//
//  WeatherViewModel.swift
//  task4_app
//
//  Created by Berat Yavuz on 2.09.2023.
//

import Foundation

private let defaultIcon = "❕"
private let iconMap = [

    "Drizzle" : "🌧️",
    "Thunderstorm" : "⛈️",
    "Rain" : "🌧️",
    "Snow" : "❄️",
    "Clear" : "☀️",
    "Clouds" : "☁️"


]

public class WeatherViewModel:ObservableObject {
    @Published var cityName:String = "City"
    @Published var temparature:String = "0"
    @Published var weatherDescription:String = "0"
    @Published var temp_max:String = "0"
    @Published var temp_min:String = "0"
    @Published var weatherIcon:String = defaultIcon
    
    public let weatherService: WeatherService
    
    public init(weatherService:WeatherService) {
        self.weatherService = weatherService
    }
    
    public func refresh() {
        weatherService.loadWeatherData { weather in
            DispatchQueue.main.async {
                self.cityName = weather.city
                self.temparature = "\(weather.temp)°C"
                self.temp_max = "\(weather.temp_max)°C"
                self.temp_min = "\(weather.temp_min)°C"
                self.weatherDescription = weather.description.capitalized
                self.weatherIcon = iconMap[weather.iconName] ?? defaultIcon
            }
        }
    }
}
