//
//  DemoView3.swift
//  SwiftUILearn0
//
//  Created by instinct on 2023/8/24.
//

import SwiftUI

struct DemoView3: View {
    
    let tap = TapGesture()
        .onEnded { _ in
            print("tap")
        }
    
    
    @GestureState private var isDetectingLongGes = false
    @State private var completedLongPress = false
    var longPress: some Gesture {
        LongPressGesture(minimumDuration: 2)
           .updating($isDetectingLongGes) { currentState, gestureState, transaction in
               gestureState = currentState
               print("\(currentState) \(gestureState)")
               transaction.animation = Animation.linear(duration: 1.5)
           }
           .onEnded { finished in
               self.completedLongPress = finished
           }
    }
    
    @GestureState private var dragOffSet = CGSize.zero
    @State private var position = CGSize.zero
    
    var dragGes: some Gesture {
        DragGesture()
            .updating($dragOffSet, body: { currentState, gestureState, transaction in
                gestureState = currentState.translation
                transaction.animation = Animation.easeOut
                print("update")
            })
            .onChanged { value in
//                print("change \(value)")
            }.onEnded { value in
                print("end \(value)")
                self.position.width += value.translation.width
                self.position.height += value.translation.height
                self.completedLongPress = false
            }
    }
    
    var color: Color {
        return self.isDetectingLongGes ? Color.red : (self.completedLongPress ? Color.green : Color.blue)
    }
    
    var body: some View {
        VStack{
            Text("手势状态").onTapGesture {
                completedLongPress = false
            }
            Spacer()
                .frame(height: 40)
            Circle()
                .fill(color)
                .frame(width: 200, height: 200)
                .offset(CGSize(width: position.width + dragOffSet.width,
                               height: position.height + dragOffSet.height))
                .gesture(longPress.sequenced(before: dragGes), including: .all)

        }
    }
}

struct DemoView3_Previews: PreviewProvider {
    static var previews: some View {
        DemoView3()
    }
}
