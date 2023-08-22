//
//  CategoryRow.swift
//  SwiftUILearn0
//
//  Created by instinct on 2023/8/21.
//

import SwiftUI

struct CategoryRow: View {
    var categoryName: String
    var items: [Landmark]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.headline)
                .padding(EdgeInsets(top: 5, leading: 15, bottom: 0, trailing: 0))
            ScrollView(.horizontal) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(items) { landmark in
                        NavigationLink {
                            LandmarkDetail(landmark: landmark)
                        } label: {
                            CategoryItem(landmark: landmark)
                        }

                    }
                }
            }
            .frame(height: 185)
        }
    }
}

struct CategoryRow_Previews: PreviewProvider {
    
    static var landmarks = ModelData().landmarks
    
    static var previews: some View {
        CategoryRow(categoryName:landmarks.first!.category.rawValue,
                    items: Array(landmarks[1..<4]))
    }
}
