//
//  CategoryHome.swift
//  SwiftUILearn0
//
//  Created by instinct on 2023/8/21.
//

import SwiftUI

struct CategoryHome: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showingProfile = false
    
    var body: some View {
        NavigationStack {
            List(content: {
                PageView(pages: modelData.features.map({ landmark in
                    FeatureCard(landmark: landmark)
                })).aspectRatio(3/2, contentMode: .fill)
                    .listRowInsets(EdgeInsets())
                ForEach(modelData.categories.keys.sorted(), id:\.self) { key in
                    CategoryRow(categoryName: key, items: modelData.categories[key]!)
                }
                .listRowInsets(EdgeInsets())
            })
           //inset ~~ group~~
            .listStyle(.inset)
                .navigationTitle("Featured")
                .toolbar {
                    Button {
                        showingProfile.toggle()
                    } label: {
                        Label("User Profile", systemImage: "person.crop.circle")
                    }
                }
                .sheet(isPresented: $showingProfile) {
                    ProfileHost()
                        .environmentObject(modelData)
                }
        }
    }
}

struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
            .environmentObject(ModelData())
    }
}
