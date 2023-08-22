//
//  ContentView.swift
//  SwiftUILearn0
//
//  Created by instinct on 2023/8/18.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var modelData = ModelData()
    @State private var selection: Tab = .featured
    
    enum Tab {
        case featured
        case list
    }
    
    var body: some View {
        TabView(selection: $selection, content: {
            CategoryHome()
                .tabItem({
                    Label("Feature", systemImage: "star")
                })
                .tag(Tab.featured)
            LandmarkList()
                .tabItem({
                    Label("Feature", systemImage: "list.bullet")
                })
                .tag(Tab.list)
        })
            .environmentObject(modelData)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
