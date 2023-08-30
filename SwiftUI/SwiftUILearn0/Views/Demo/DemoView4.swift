//
//  DemoView4.swift
//  SwiftUILearn0
//
//  Created by instinct on 2023/8/25.
//

import SwiftUI

struct ItemFrameInfo: Equatable {
    let index: Int
    let rect: CGRect
}

struct ItemFramePreferenceKey: PreferenceKey {
    typealias Value = [ItemFrameInfo]
    
    static var defaultValue: [ItemFrameInfo] = []
    
    static func reduce(value: inout [ItemFrameInfo], nextValue: () -> [ItemFrameInfo]) {
        value += nextValue()
    }
}

struct ItemFramePreferenceKey1: PreferenceKey {
    typealias Value = [ItemFrameInfo]
    
    static var defaultValue: [ItemFrameInfo] = []
    
    static func reduce(value: inout [ItemFrameInfo], nextValue: () -> [ItemFrameInfo]) {
        value += nextValue()
    }
}

struct DemoView4: View {
    
    @State private var count = 1
    @State private var isPreview = false
    @State private var rects = [ItemFrameInfo]()
    @State private var preViewIndex: Int? = nil
    
    private let previewTransitionId = "previewTransitionId"
    @Namespace private var previewTransition
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            content.zIndex(0)
            Group {
                if isPreview == true {
                    preview
                        .zIndex(1)
                        .matchedGeometryEffect(id: previewTransitionId, in: previewTransition)
                } else {
                    if let index = preViewIndex {
                        preview
                            .zIndex(1)
                            .background {
                                GeometryReader { ges in
                                    Color.yellow.preference(key: ItemFramePreferenceKey1.self, value: [ItemFrameInfo(index: 100, rect: ges.frame(in: .named("ZStack")))])
                                }
                            }
                            .matchedGeometryEffect(id: previewTransitionId, in: previewTransition)
                            .frame(width: rects[index].rect.width, height: rects[index].rect.height)
                            .position(x: rects[index].rect.midX, y: rects[index].rect.midY)
                            .opacity(0.0)
                    }
                }
            }.center()
            panel.zIndex(2)
        }
        .coordinateSpace(name: "ZStack")
        .onPreferenceChange(ItemFramePreferenceKey1.self) { p in
            p.forEach { info in
                print("update1:\(info.index) \(info.rect)")
            }
        }
    }
    
    var preview: some View {
        Rectangle()
            .foregroundColor(.green)
            .onTapGesture {
                withAnimation {
                    isPreview.toggle()
                }
            }
            .padding(0)
    }
        
    var content: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible(minimum: 150, maximum: .infinity)), GridItem(.flexible(minimum: 150, maximum: .infinity))], spacing: 20) {
                ForEach(0..<count, id: \.self) { i in
                        DemoView4Item(index: i)
                            .onTapGesture {
                                preViewIndex = i
                                withAnimation {
                                    isPreview.toggle()
                                }
                            }
                            .background( GeometryReader(content: { ges in
                                Color
                                    .clear
                                    .preference(key: ItemFramePreferenceKey.self, value: [ItemFrameInfo(index: i, rect: ges.frame(in: .named("ZStack")))])
                            }))
                    }
                }
            }
            .coordinateSpace(name: "Scroll")
            .onPreferenceChange(ItemFramePreferenceKey.self) { p in
                p.forEach { info in
                    if let index = rects.firstIndex(where: { $0.index == info.index }) {
                        rects[index] = info
                    } else {
                        rects.append(info)
                    }
                }
                print("update:\(rects)")
            }
            .padding()

    }
    
    var panel: some View {
        VStack {
            Button {
                withAnimation(.easeIn(duration: 0.5)) {
                    count += 1
                }
            } label: {
                Image(systemName: "plus.circle")
            }
            .padding()
            
            Button {
                withAnimation(.easeIn(duration: 0.5)) {
                    count -= 1
                }
            } label: {
                Image(systemName: "minus.circle")
            }
            .padding()
            
            Button {
                withAnimation {
                    isPreview.toggle()
                }
            } label: {
                Image(systemName: "switch.2")
            }
            .padding()
        }
        .font(.largeTitle)
        .foregroundColor(.black)
        .shadow(color: .white, radius: 10)
    }
}

struct DemoView4Item: View {
    
    let index: Int
    
    var body: some View {
        Rectangle()
            .frame(height: 200)
            .foregroundColor(.red)
                        .overlay {
                            Text("\(index)")
                        }
                        .transition(.move(edge: .bottom))
    }
}

struct DemoView4Preview: View {
    var text: String
    var body: some View {
        Text(text)
            .bold()
    }
}

struct Center : ViewModifier {
    func body(content: Content) -> some View {
        VStack {
            Spacer()
            HStack() {
                Spacer()
                content
                    .padding(-8)
                Spacer()
            }
            Spacer()
        }
        .border(Color.blue, width: 2)
    }
}

extension View {
    func center() -> some View {
        return self.modifier(Center())
    }
}

struct DemoView4_Previews: PreviewProvider {
    static var previews: some View {
        DemoView4()
    }
}    
