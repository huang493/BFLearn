//
//  ProfileSummary.swift
//  SwiftUILearn0
//
//  Created by instinct on 2023/8/21.
//

import SwiftUI

struct ProfileSummary: View {
    var profile: Profile
    @EnvironmentObject var modelData: ModelData

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(profile.username)
                    .bold()
                    .font(.title)
                
                 Text("Notifications: \(profile.prefersNotifications ? "On": "Off" )")
                 Text("Seasonal Photos: \(profile.seasonalPhoto.rawValue)")
                 Text("Goal Date: ") + Text(profile.goalDate, style: .date)
                
                Divider()
                Text("Completed Badges")
                        .font(.headline)
                ScrollView {
                    HStack {
                        HikeBadge(name: "First Hike")
                        HikeBadge(name: "First Hike")
                            .hueRotation(Angle(degrees: 90))
                        HikeBadge(name: "First Hike")
                            .hueRotation(Angle(degrees: 45))
                    }
                }
                Divider()
                VStack(alignment: .leading) {
                    Text("Recent Hikes")
                        .font(.headline)
                    HikeView(hike: modelData.hikes[0])
                }
            }
        }
    }
}

struct ProfileSummary_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSummary(profile: Profile.default)
            .environmentObject(ModelData())
    }
}
