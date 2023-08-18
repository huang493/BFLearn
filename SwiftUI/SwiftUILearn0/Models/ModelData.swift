//
//  ModelData.swift
//  SwiftUILearn0
//
//  Created by instinct on 2023/8/18.
//

import Foundation

var landmarks: [Landmark] = load("landmarkData.json")

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
