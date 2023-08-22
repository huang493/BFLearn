//
//  PageViewController.swift
//  SwiftUILearn0
//
//  Created by instinct on 2023/8/22.
//

import SwiftUI
import UIKit

struct PageViewController<Page: View>: UIViewControllerRepresentable {
    
    // 在makeUIViewController之前调用，说白了，数据先行，暴露给UIKit的配置。
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    var pages: [Page]
    @Binding var currentPage: Int
    
    //
    typealias UIViewControllerType = UIPageViewController
    
    //只会调用一次或者构造一次, SwiftUI会自主管理其生命周期
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageVC = UIPageViewController(transitionStyle: .scroll,
                                          navigationOrientation: .horizontal)
        pageVC.dataSource = context.coordinator
        pageVC.delegate = context.coordinator
        print("2222")
        return pageVC
    }
    
    //多次调用
    func updateUIViewController(_ uiViewController: UIPageViewController, context: Context) {
        print("3333")
        //Fuck:setViewControllers只能设置一个数据！！！！
        uiViewController.setViewControllers([context.coordinator.controllers[currentPage]],
                                            direction: .forward,
                                            animated: true)
    }
    
    
    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

        var parent: PageViewController
        var controllers: [UIViewController]
        
        init(_ pageViewController: PageViewController) {
            parent = pageViewController
            controllers = pageViewController.pages.map { UIHostingController(rootView: $0) }
            print("11111:\(controllers)")
        }
        
        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index == 0 {
                return controllers.last
            }
            return controllers[index - 1]
        }

        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index + 1 == controllers.count {
                return controllers.first
            }
            return controllers[index + 1]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            guard completed, finished else {
                return
            }
            
            guard let vc = pageViewController.viewControllers?.first, let index = controllers.firstIndex(of: vc) else {
                return
            }
            
            parent.currentPage = index
            
        }
    }
    
    
}

