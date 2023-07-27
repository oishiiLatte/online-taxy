//
//  LocationSearchViewModel.swift
//  Uber Swift
//
//  Created by obbiy on 24/07/23.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {
    
    // MARK - Properties
    
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedLocation: String?
    
    private let seacrhCompleter = MKLocalSearchCompleter()
    var queryFragment: String = "" {
        didSet {
            seacrhCompleter.queryFragment = queryFragment
        }
    }
    
    override init() {
        super.init()
        seacrhCompleter.delegate = self
        seacrhCompleter.queryFragment = queryFragment
    }
    
    // MARK: Helper
    
    func selectedLocation(_ location: String) {
        self.selectedLocation = location
        
        print("DEBUG: Selected location in \(self.selectedLocation)")
    }
}

// MARK - MKLocalSearchCompleterDelegate

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
