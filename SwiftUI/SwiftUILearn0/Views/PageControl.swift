//
//  PageControl.swift
//  SwiftUILearn0
//
//  Created by instinct on 2023/8/22.
//

import SwiftUI

struct PageControl: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    typealias UIViewType = UIPageControl

    var numberOfPages: Int
    @Binding var currentPage: Int
    
    func makeUIView(context: Context) -> UIPageControl {
        let controller = UIPageControl()
        controller.numberOfPages = numberOfPages
        controller.addTarget(context.coordinator, action: #selector(Coordinator.updateIndex(_:)), for: .valueChanged)
        return controller
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }
    
    class Coordinator: NSObject {
        
        var parent: PageControl
        
        init(_ parent: PageControl) {
            self.parent = parent
        }
        
        @objc func updateIndex(_ pageControl: UIPageControl) {
            parent.currentPage = pageControl.currentPage
        }
    }
}
