//
//  HeaderHomeShape.swift
//  ABakersJourney
//
//  Created by Gabriel Taques on 20/06/20.
//  Copyright © 2020 Gabriel Taques. All rights reserved.
//

import SwiftUI

struct HeaderHomeShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY * 0.50))
//        path.addArc(center: <#T##CGPoint#>, radius: <#T##CGFloat#>, startAngle: <#T##Angle#>, endAngle: <#T##Angle#>, clockwise: <#T##Bool#>)
//        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
//        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY))
        return path
    }
}
