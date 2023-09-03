//
//  ContentView.swift
//  task4_app
//
//  Created by Berat Yavuz on 30.08.2023.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel:WeatherViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.cityName)
                .font(.largeTitle)
                .padding()
            Text(viewModel.weatherIcon)
                .font(.system(size: 60))
                .padding()
            Text(viewModel.temparature)
                .font(.largeTitle)
                .bold()
            HStack {
                Text("Max:\(viewModel.temp_max)")
                    .font(.title2)
                    .padding()
                Text("Min:\(viewModel.temp_min)")
                    .font(.title2)
                    .padding()
            }
        }.onAppear(perform: viewModel.refresh)
            .padding(.top,-300)
    }
}
