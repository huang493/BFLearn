//
//  SwiftUIDemo.swift
//  SwiftUILearn0
//
//  Created by instinct on 2023/8/25.
//

import SwiftUI

struct SwiftUIDemo: View {
    var body: some View {
        NavigationStack {
            List {
                Section("layout") {
                    NavigationLink("弹窗") {
                        DemoView2()
                    }
                    NavigationLink("动画与过渡") {
                        DemoView4()
                    }
                    NavigationLink("Gesture") {
                        DemoView3()
                    }
                    NavigationLink("other") {
                        DemoView()
                    }
                    NavigationLink("Layout protocol & Animatable") {
                        DemoView7()
                    }
                    NavigationLink("动画总结") {
                        DemoView8()
                    }
                }
            }
        }
    }
}

struct SwiftUIDemo_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIDemo()
    }
}
