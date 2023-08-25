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
    
    var drag: some Gesture {
        DragGesture()
            .updating($dragOffSet, body: { currentState, gestureState, transaction in
                gestureState = currentState.translation
            })
            .onChanged { value in
                print("change \(value)")
            }.onEnded { value in
                print("end \(value)")
                position.width += value.translation.width
                position.height += value.translation.height
            }
    }
    
    var body: some View {
        DemoGes()
//        VStack{
//            Text("手势状态").onTapGesture {
//                completedLongPress = false
//            }
//            Spacer().frame(height: 40)
//            Circle()
//                .offset(CGSize(width: position.width + dragOffSet.width, height: position.height + dragOffSet.height))
//            .fill(self.isDetectingLongGes ? Color.red : (self.completedLongPress ? Color.green : Color.blue))
//            .frame(width: 200, height: 200)
//            .gesture(drag)
//        }
    }
}

struct DemoGes: View {
    @State private var circleColorChanged = false
    @State private var heartColorChanged = false
    @State private var heartSizeChanged = false
    @GestureState private var longPressTap = false
    @GestureState private var dragOffset = CGSize.zero
    @State private var position = CGSize.zero

        var body: some View {

            // 绘制
            ZStack {
                Circle()
                    .frame(width: 200, height: 200)
                    .foregroundColor(circleColorChanged ? Color(.systemGray5) : .red)
                Image(systemName: "heart.fill")
                    .foregroundColor(heartColorChanged ? .red : .white)
                    .font(.system(size: 80))
                    .scaleEffect(heartSizeChanged ? 1.0 : 0.5)
            }

            // 移动位置
            .offset(x: position.width + dragOffset.width, y: position.height + dragOffset.height)

            // 手势modifier
            .gesture(

                // 长按手势
                LongPressGesture(minimumDuration: 1.0)

                    // 长按手势更新方法
                    .updating($longPressTap, body: {

                        currentState, state, _ in

                        state = currentState
//                        self.circleColorChanged.toggle()
//                        self.heartColorChanged.toggle()
//                        self.heartSizeChanged.toggle()
                    })

                    // 拖拽手势
                    .sequenced(before: DragGesture())

                    // 拖拽手势更新方法
                    .updating($dragOffset, body: {

                        currentPosition, state, _ in

                        // 顺序执行
                        switch currentPosition {

                        case .first(true):
                            print("正在点击")

                        case .second(true, let drag):
                            state = drag?.translation ?? .zero

                        default:
                            break

                        }
                    })

                    // 拖拽结束后的位置
                    .onEnded({ currentPosition in
                        guard case .second(true, let drag?) = currentPosition else {
                            return
                        }
                        self.position.height += drag.translation.height
                        self.position.width += drag.translation.width
                        self.circleColorChanged.toggle()
                        self.heartColorChanged.toggle()
                        self.heartSizeChanged.toggle()
                    })
            )
        }
}

struct DemoView3_Previews: PreviewProvider {
    static var previews: some View {
        DemoView3()
    }
}
