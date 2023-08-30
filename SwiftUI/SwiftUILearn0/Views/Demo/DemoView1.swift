//
//  DemoView1.swift
//  SwiftUILearn0
//
//  Created by instinct on 2023/8/24.
//

import SwiftUI

struct DemoView1: View {
    
    @State private var name = ""
    @State private var pw = ""

    var body: some View {
        VStack {
            Text("Hello, World!")
            Text("Hello, World!")
                .font(.title)
                .underline(color: .red)
                .shadow(radius: 10)
                .bold()
            
            HStack {
                Text("user name")
                    .font(.title)
                    .onTapGesture {
                        print("tap name")
                    }
//                Spacer()
                TextField("name", text: $name)
                    .padding(10)
                    .background(.gray.opacity(0.3), in: RoundedRectangle(cornerRadius: 20))
                    
            }
            
            Button("btn") {
                pw += "@@"
                print("\(pw)")
            }
            
            HStack {
                TextField("pww", text: $pw, prompt: nil)
                    .onSubmit(of: [.text], {
                        print("\(pw)")
                        if pw.contains(where: { c in
                            return c == "."
                        }) {
                            pw = "new"
                            print("\(pw)")
                        }
                    })
                .foregroundColor(.blue)
                .padding(10)
                .background(.yellow, in: Rectangle())
                
            }
            
            WebImage()
                .frame(width: 200, height: 200)
                .background(.red, in: Rectangle())
                .clipped()
            
            
        }
    }
}

struct WebImage: View {
    
    var placeholder: String? = nil
    var isWebImage = false
    private var webImage: Image? = nil
    
    var body: some View {
        AsyncImage(url: URL(string: "https://gitee.com/guangjie2021/SwiftUICn/raw/master/images/example/WebImage.png"), content: { image in
            image
                .resizable(resizingMode: .stretch)
                .aspectRatio(contentMode: .fit)
                .background(.red, in: Rectangle())
        }, placeholder: {
            Color.gray
        })
    }
}

struct DemoView1_Previews: PreviewProvider {
    static var previews: some View {
        DemoView1()
    }
}
