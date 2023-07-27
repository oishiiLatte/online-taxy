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
}

// MARK - MKLocalSearchCompleterDelegate

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
