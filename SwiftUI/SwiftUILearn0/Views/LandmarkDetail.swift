//
//  LandmarkDetail.swift
//  SwiftUILearn0
//
//  Created by instinct on 2023/8/18.
//

import SwiftUI

struct LandmarkDetail: View {
    @EnvironmentObject var modelData: ModelData
    var landmark: Landmark
    
    var index: Int {
        modelData.landmarks.firstIndex { l in
            l.id == landmark.id
        } ?? 0
    }
    
    var body: some View {
        ScrollView {
            MapView(coordinate: landmark.localCoordinates)
                .frame(height: 300)
                .ignoresSafeArea(edges: .top)
            CircleImage(image: landmark.image)
                .offset(y: -130)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(landmark.name)
                        .font(.title)
                    FavoriteButton(isSet: $modelData.landmarks[index].isFavorite)
                }
                HStack {
                    Text(landmark.park)
                    Spacer()
                    Text(landmark.state)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                Divider()
                
                Text(landmark.name)
                    .font(.title2)
                Text(landmark.description)
                    .font(.title2)
                
            }
            .padding()
            Spacer()
        }
        .navigationTitle(landmark.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LandmarkDetail_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkDetail(landmark: ModelData().landmarks[1])
            .environmentObject(ModelData())
    }
}
