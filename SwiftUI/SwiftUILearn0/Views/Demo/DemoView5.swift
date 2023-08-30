//
//  DemoView5.swift
//  SwiftUILearn0
//
//  Created by instinct on 2023/8/28.
//

import SwiftUI

struct DemoView5: View {
    var emoji : String
    @State private var listCount = 0
    var body: some View {
        EmojiView(emoji: emoji)
    }
}

struct EmojiView: View {
    var emoji: String
    
    var body: some View {
        Text(emoji)
            .font(.largeTitle)
    }
}

struct DemoView5_Previews: PreviewProvider {
    static var previews: some View {
        DemoView5(emoji: "❤️")
    }
}
