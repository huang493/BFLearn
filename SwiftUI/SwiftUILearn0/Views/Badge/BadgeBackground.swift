//
//  BadgeBackground.swift
//  SwiftUILearn0
//
//  Created by instinct on 2023/8/21.
//

import SwiftUI

struct BadgeBackground: View {
    
    static let gradientStart = Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255)
    static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)
    
    var body: some View {
        GeometryReader { geo in
            Path { path in
                var width: CGFloat = min(geo.size.width, geo.size.height)
                print("\(geo.size)" + "")
                let xScale: CGFloat = 0.832
                let xOffset = (width * (1.0 - xScale)) / 2.0
                width *= xScale
                let height = width
                path.move(to: CGPoint(x: width * 0.95 + xOffset,
                                      y: height * (0.2 + HexagonParameters.adjustment)))
                
                HexagonParameters.segments.forEach { seg in
                    path.addLine(to: CGPoint(x: width * seg.line.x + xOffset,
                                             y: height * seg.line.y))
                    
                    path.addQuadCurve(to: CGPoint(x: width * seg.curve.x + xOffset,
                                                  y: height * seg.curve.y),
                                      control: CGPoint(x: width * seg.control.x + xOffset,
                                                       y: height * seg.control.y))
                }
            }
            .fill(.linearGradient(Gradient(colors: [Self.gradientStart, Self.gradientEnd]),
                                  startPoint: UnitPoint(x: 0.5, y: 0),
                                  endPoint: UnitPoint(x: 0.5, y: 0.6)
                                 )
            )
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

struct BadgeBackground_Previews: PreviewProvider {
    static var previews: some View {
        BadgeBackground()
    }
}
