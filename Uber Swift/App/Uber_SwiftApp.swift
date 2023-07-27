//
//  Uber_SwiftApp.swift
//  Uber Swift
//
//  Created by obbiy on 22/07/23.
//

import SwiftUI

@main
struct Uber_SwiftApp: App {
    @StateObject var locationViewModel = LocationSearchViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationViewModel)
        }
    }
}
