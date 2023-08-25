//
//  DemoView2.swift
//  SwiftUILearn0
//
//  Created by instinct on 2023/8/24.
//

import SwiftUI

struct DemoView2: View {
    
    @State private var isAlert = false
    var alertView: Alert {
        Alert(title: Text("alert"),
              message: Text("are you ok"),
              dismissButton: .cancel(Text("cancell"), action: {
            print("cancell")
        }))
    }
    
    var alertView1: Alert {
        Alert(title: Text("alert"), message: Text("message message asdadasda"),primaryButton: .default(Text("Ok"), action: {
            print("Ok")
        }), secondaryButton: .destructive(Text("cancell"), action: {
            print("cancell")
        }))
    }
    
    @State private var isSheet = false
    var sheetAction: ActionSheet {
        ActionSheet(title: Text("title"),
                    message: Text("please make a choice"),
                    buttons: [.default(Text("one")),
                        .default(Text("two")),
                        .destructive(Text("3")),
                        .cancel(Text("cancell"))])
    }
    
    @State private var isDialog = false

    @State private var isModal = false
    
    //ipad 上才能看出sheet和popover的区别
    @State private var isPop = false

    var body: some View {
        VStack {
            Text("DemoView2")
                .onTapGesture {
                    print("tap")
                }
            Button("alert") {
                isAlert = true
            }
            
            Button("sheet") {
                isSheet = true
            }
            
            Button("dialog") {
                isDialog = true
            }
            
            Button("Modal") {
                isModal = true
            }
            
            Button("Pop") {
                isPop = true
            }
        }
        .font(.title)
        .alert(isPresented: $isAlert) {
            alertView1
        }
        .actionSheet(isPresented: $isSheet) {
            sheetAction
        }
        .confirmationDialog("Permanently erase the items in the Trash?",
                            isPresented: $isDialog ) {
            ForEach(0..<3) { i in
                Button("hello \(i)", role: .none) {
                    print("\(i)")
                }
            }
        }
                            .sheet(isPresented: $isModal) {
                                Text("is Modal present")
                            }
                            .popover(isPresented: $isPop) {
                                Text("pop")
                            }
    
    }
}

struct DemoView2_Previews: PreviewProvider {
    static var previews: some View {
        DemoView2()
    }
}
