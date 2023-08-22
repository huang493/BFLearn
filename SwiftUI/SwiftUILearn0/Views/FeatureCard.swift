//
//  FeatureCard.swift
//  SwiftUILearn0
//
//  Created by instinct on 2023/8/22.
//

import SwiftUI

struct FeatureCard: View {
    var landmark: Landmark

    var body: some View {
        landmark
            .featureImage?
            .resizable()
            .aspectRatio(3 / 2, contentMode: .fit)
            .overlay(content: {
                TextOverlay(landmark: landmark)
            })
    }
}

struct FeatureCard_Previews: PreviewProvider {
    static var previews: some View {
        FeatureCard(landmark: ModelData().features[0])
    }
}


struct TextOverlay: View {
    var landmark: Landmark
    
    var gradient: LinearGradient {
        LinearGradient(colors: [.black.opacity(0.0), .black.opacity(0.6)], startPoint: UnitPoint(x: 0.5, y: 0), endPoint: UnitPoint(x: 0.5, y: 1.0))
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            gradient
            VStack(alignment: .leading) {
                Text(landmark.name)
                    .bold()
                    .font(.title)
                Text(landmark.park)
            }
            .foregroundColor(.white)
            .padding()
        }
    }
}

struct TextOverlay_Previews: PreviewProvider {
    static var previews: some View {
        TextOverlay(landmark: ModelData().features[0])
    }
}
