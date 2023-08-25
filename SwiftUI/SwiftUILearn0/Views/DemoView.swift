//
//  DemoView.swift
//  SwiftUILearn0
//
//  Created by instinct on 2023/8/22.
//

import SwiftUI


struct DemoView: View {
    
    @ScaledMetric var space = 5
    
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack(spacing: 30) {
                    NavigationLink {
                        DemoView1()
                    } label: {
                        Text("next")
                    }

                    NavigationLink {
                        DemoView2()
                    } label: {
                        Text("弹出")
                    }

                    NavigationLink {
                        DemoView3()
                    } label: {
                        Text("手势")
                    }
                    
                    CaptionedPhoto()
                    Button("Combine action") {
                        CombineDemo.action()
                    }
                    HStack(spacing: space) {
                        TrainCar("train.side.rear.car")
                        TrainCar("train.side.middle.car")
                        TrainCar("train.side.front.car")
                        
                        Divider()
                        Spacer(minLength: 10)
                        Image(systemName: "train.side.rear.car")
                            .opacity(00.5)
                        Image(systemName: "train.side.middle.car")
                            .hidden()
                        Image(systemName: "train.side.front.car")
                    }.font(.title)
                    
                    Label("Label", systemImage: "figure.cooldown")
                    Image("stmarylake_feature")
                        .resizable()
                        .scaledToFit()
                    HStack{
                        Rectangle()
                            .foregroundColor(.red)
                        Circle()
                            .foregroundColor(.yellow)
                        RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
                        Capsule(style: .continuous)
                            .aspectRatio(2, contentMode: .fit)
                    }
                    .aspectRatio(4, contentMode: .fit)
                    .padding()
                    
                    Label("fern-leaf \nlavender", systemImage: "leaf")
                        .foregroundColor(.white)
                        .font(.title)
                        .padding()
                        .background(alignment: .top) {
                            Capsule()
                        }
                }
            }
        }
        .navigationDestination(for: Int.self) { s in
//            print("\(s)")
            if s == 1 {
                DemoView1()
            }
        }
    }
}

struct DemoView_Previews: PreviewProvider {
    static var previews: some View {
        DemoView()
    }
}

struct CaptionedPhoto: View {
    var body: some View {
        Image("stmarylake_feature")
            .resizable()
            .overlay(alignment: .bottom) {
                Text("风景不错")
                    .foregroundColor(.white)
                    .font(.title)
                    .padding()
                    .background(.black.opacity(0.5),
                                in: RoundedRectangle(cornerRadius: 20))
                    .padding()
            }
    }
}

struct TrainCar: View {
    var imageName: String
    init(_ imageName: String) {
        self.imageName = imageName
    }
    
    var body: some View {
        Image(systemName: imageName)
            .background(.red.opacity(0.5))
    }
}
