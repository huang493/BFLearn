//
//  DemoView6.swift
//  SwiftUILearn0
//
//  Created by instinct on 2023/8/28.
//

import SwiftUI

struct DemoView6: View {
    @State private var expand = false
    
    let animationId = "change"
    @Namespace private var change
    
    var body: some View {
        VStack(alignment:.center) {
            Spacer()
            if expand {
                RoundedRectangle(cornerRadius: 20)
                    .matchedGeometryEffect(id: animationId, in: change)
                    .foregroundColor(.green)
                    .ignoresSafeArea()
                    .transition(.push(from: .leading))
                    .animation(Animation.linear)
                    .onTapGesture {
//                        withAnimation {
                            expand.toggle()
//                        }
                        
                    }
            } else {
                Circle()
                    .matchedGeometryEffect(id: animationId, in: change)
                    .frame(width: 80, height: 80)
                    .foregroundColor(.orange)
                    .transition(.opacity)
                    .padding()
                    .animation(Animation.linear)
                    .onTapGesture {
//                        withAnimation {
                            expand.toggle()
//                        }
                    }
            }
        }
    }
}

struct DemoView6_Previews: PreviewProvider {
    static var previews: some View {
        DemoView6()
    }
}
