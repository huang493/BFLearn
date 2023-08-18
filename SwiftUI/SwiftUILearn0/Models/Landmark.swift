//
//  Landmark.swift
//  SwiftUILearn0
//
//  Created by instinct on 2023/8/18.
//

import Foundation
import SwiftUI
import CoreLocation

struct Landmark: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var state: String
    var park: String
    var description: String
    var imageName: String
    var isFavorite: Bool

    var image: Image {
        Image(imageName)
    }
    
    var coordinates: Coordinates
    var localCoordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
    
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
}

