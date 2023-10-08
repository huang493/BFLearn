//
//  DemoView7.swift
//  SwiftUILearn0
//
//  Created by instinct on 2023/9/1.
//

import SwiftUI

struct CirleStack: Layout {
    
    let radius: CGFloat
    let angle: Double
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let maxLength = subviews.map { subView in
            let size = subView.sizeThatFits(.unspecified)
            return max(size.width, size.height)
        }.max() ?? 0
        
        let result = CGSize(width: (maxLength/2.0 + radius) * 2.0 , height: (maxLength/2.0 + radius) * 2.0)
        print("result:\(result)")
        return result
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let angleStep = Angle(degrees: 360).radians / Double(subviews.count)
        for (i, subview) in subviews.enumerated() {
            var p = CGPoint(x: 0, y: -radius).applying(CGAffineTransform(rotationAngle: Angle(degrees: angle).radians + angleStep * Double(i)))
            p.x += bounds.minX + (subview.sizeThatFits(.unspecified).width) / 2.0 + radius
            p.y += bounds.midY
            print("place: \(i) \(p)")
            subview.place(at: p, anchor: .center, proposal: .unspecified)
        }
    }
}

struct CirleAnimationView: View, Animatable {
    typealias AnimatableData = Double
    var toAngle: Double = 0
    var animatableData: Double {
        get {
            toAngle
        }
        set {
            toAngle = newValue
        }
    }
        
    var body: some View {
        VStack {
            CirleStack(radius: 150, angle: toAngle) {
                ForEach(0..<12) { i in
                    Text("Hello \(i)")
                        .padding(10)
                        .background(.red.opacity(0.1 * Double(i)), in: RoundedRectangle(cornerRadius: 10))
                }
            }
            .border(.green)
            
            Text("\(toAngle)")
        }
    }
}


struct DemoView7: View {
    @State private var toAngle: Double = 0.0
    var body: some View {
        VStack{
            CirleAnimationView(toAngle: toAngle)
                .animation(.linear(duration: 0.3), value: toAngle)
                .border(.red)
            
            Spacer().frame(height: 50)
            
            HStack {
                Button {
                    withAnimation {
                        toAngle += 90
                    }
                } label: {
                    Image(systemName: "rotate.right")
                }
                .padding()
                                
                Button("Reset") {
                    withAnimation {
                        toAngle = 0
                    }
                }
                .padding()
            }
            .font(.largeTitle)
            .border(.gray)
        }
    }
}

struct DemoView7_Previews: PreviewProvider {
    static var previews: some View {
        DemoView7()
    }
}
