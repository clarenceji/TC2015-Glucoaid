//
//  DAExtensions.swift
//  Diabetapp
//
//  Created by Clarence Ji on 12/5/15.
//  Copyright © 2015 Diabetapp. All rights reserved.
//
import UIKit

extension UIColor {
    class func diabetRed() -> UIColor {
        return UIColor(red: 244/255, green: 76/255, blue: 91/255, alpha: 1)
    }
    
    class func diabetBlue() -> UIColor {
        return UIColor(red: 102/255, green: 161/255, blue: 231/255, alpha: 1)
    }
}

extension LineChart {
    func quadCurvedPathWithPoints(points: [CGPoint]) -> UIBezierPath {
        let path = UIBezierPath()
        
        var p1 = points[0]
        path.moveToPoint(p1)
        
        if (points.count == 2) {
            let point = points[1]
            path.addLineToPoint(point)
            return path
        }
        
        for (var i = 1; i < points.count; i++) {
            let p2 = points[i]
            let midpoint = midPointForPoints(p1, p2)
            path.addQuadCurveToPoint(midpoint, controlPoint: controlPointForPoints(midpoint, p1))
            path.addQuadCurveToPoint(p2, controlPoint: controlPointForPoints(midpoint, p2))
            
            p1 = p2
        }
        
        return path
    }
    
    func midPointForPoints(p1: CGPoint, _ p2: CGPoint) -> CGPoint {
        return CGPointMake((p1.x + p2.x) / 2, (p1.y + p2.y) / 2)
    }
    
    func controlPointForPoints(p1: CGPoint, _ p2: CGPoint) -> CGPoint {
        var controlPoint = midPointForPoints(p1, p2)
        let diffY = fabs(p2.y - controlPoint.y)
        
        if (p1.y < p2.y) { controlPoint.y += diffY }
        else if (p1.y > p2.y) { controlPoint.y -= diffY }
        
        return controlPoint
    }

}