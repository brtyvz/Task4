//
//  task4_appApp.swift
//  task4_app
//
//  Created by Berat Yavuz on 30.08.2023.
//

import SwiftUI

@main
struct task4_appApp: App {
    var body: some Scene {
        WindowGroup {
            let weatherService = WeatherService()
            let viewModel = WeatherViewModel(weatherService: weatherService)
            ContentView(viewModel: viewModel)
        }
    }
}
