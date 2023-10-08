//
//  DemoView8.swift
//  SwiftUILearn0
//
//  Created by instinct on 2023/9/15.
//

import SwiftUI

struct DemoView8: View {
    @State private var redOffX: CGFloat = 0
    @State private var greenOffX: CGFloat = 0
    @State private var blueOffX: CGFloat = 0
    @State private var yellowOffX: CGFloat = 0

    
    var body: some View {
        GeometryReader(content: { geo in
            VStack(alignment: .leading, spacing: 40) {
                Circle()
                    .frame(width: 80)
                    .foregroundColor(.red)
                    .offset(x: redOffX, y: 0)
                Circle()
                    .frame(width: 80)
                    .foregroundColor(.green)
                    .offset(x: greenOffX, y: 0)
                    .animation(.easeIn(duration: 0.5), value: greenOffX)
                
                BlueCircle(blueBindOffX: $blueOffX.animation(.linear(duration: 0.5)), maxOffX: geo.size.width - 80)
                if #available(iOS 17.0, *) {
                    Circle()
                        .frame(width: 80)
                        .foregroundColor(.yellow)
                        .offset(x: yellowOffX, y: 0)
                        .animation(.myLiner(duration: 0.5), value: yellowOffX)
                }
                

                
                Button("Action") {
                    withAnimation(.linear(duration: 0.5).delay(0.2)) {
                        redOffX = geo.size.width - 80
                    }
                    greenOffX = geo.size.width - 80
                    blueOffX = geo.size.width - 80
                    yellowOffX = geo.size.width - 80
                }
                
                Button("reset") {
                    redOffX = 0
                    greenOffX = 0
                    blueOffX = 0
                    yellowOffX = 0
                }
            }
        })
        .border(.red)
    }
}

extension Animation {
    @available(iOS 17.0, *)
    public static func myLiner(duration: TimeInterval) -> Animation {
        return Animation(MyLineAnimation(duration: duration))
    }
}

struct MyLineAnimation: CustomAnimation {
    var duration: TimeInterval = 0.5
    @available(iOS 17.0, *)
    func animate<V>(value: V, time: TimeInterval, context: inout AnimationContext<V>) -> V? where V : VectorArithmetic {
        if time < duration {
            return value.scaled(by: time / duration)
        }
        return nil
    }
}

struct BlueCircle: View {
    @Binding var blueBindOffX: CGFloat
    let maxOffX: CGFloat
    var body: some View {
        return VStack {
            Circle()
                    .foregroundColor(.blue)
                    .frame(width: 80)
                    .offset(x: blueBindOffX)
            Button("blue action") {
                blueBindOffX = maxOffX
            }
        }
    }
}


struct DemoView8_Previews: PreviewProvider {
    static var previews: some View {
        DemoView8()
    }
}
