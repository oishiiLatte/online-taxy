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
    @Published var selectedLocationCoordinate: CLLocationCoordinate2D?
    
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
    
    func selectedLocation(_ localSearch: MKLocalSearchCompletion) {
        locationSearch(forLocalSearchCompletion: localSearch) { response, error in
            if let error = error {
                print("DEBUG: Location search failed with error \(error.localizedDescription)")
                return
            }
            
            guard let item = response?.mapItems.first else {return}
            let coordinate = item.placemark.coordinate
            self.selectedLocationCoordinate = coordinate
            print("DEBUG: Location coordinates \(coordinate)")
        }
    }
    
    func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        
        search.start(completionHandler: completion)
    }
}

// MARK - MKLocalSearchCompleterDelegate

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
