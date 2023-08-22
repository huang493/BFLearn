//
//  ModelData.swift
//  SwiftUILearn0
//
//  Created by instinct on 2023/8/18.
//

import Foundation

final class ModelData: ObservableObject {
    @Published var landmarks: [Landmark] = load("landmarkData.json")
    @Published var profile = Profile.default
    
    var hikes: [Hike] = load("hikeData.json")
    
    var categories: [String: [Landmark]] {
        Dictionary(grouping: landmarks) { e in
            e.category.rawValue
        }
    }
    
    var features: [Landmark] {
        landmarks.filter { $0.isFeatured }
    }
}

func load<T:Decodable>(_ fileName: String) -> T {
    let data: Data
    
    guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else {
        fatalError("")
    }
    
    do {
        data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("")
    }
}
