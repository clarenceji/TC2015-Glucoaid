import UIKit
import XCPlayground

<<<<<<< HEAD
//let path = UIBezierPath()
//path.moveToPoint(CGPointMake(10, 10))
//path.addLineToPoint(CGPointMake(290, 10))
//path.lineWidth = 6
//
//let dashes: [CGFloat] = [path.lineWidth * 2, path.lineWidth * 2]
//path.setLineDash(dashes, count: dashes.count, phase: 0)
//path.lineCapStyle = .Round
//
//UIGraphicsBeginImageContextWithOptions(CGSizeMake(300, 20), false, 2)
//path.stroke()
//
//let view = UIView(frame: CGRectMake(0,0,500,500))
//view.backgroundColor = UIColor.whiteColor()
//
//let image = UIGraphicsGetImageFromCurrentImageContext()
//
//UIGraphicsEndImageContext()

// ------------------ curve line ------------------------

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

let points: [CGPoint] = [CGPointMake(10, 10), CGPointMake(20, 20), CGPointMake(30, 30), CGPointMake(40, 40), CGPointMake(50, 50)]
quadCurvedPathWithPoints(points)
=======
let path = UIBezierPath()
path.moveToPoint(CGPointMake(10, 10))
path.addLineToPoint(CGPointMake(290, 10))
path.lineWidth = 6

let dashes: [CGFloat] = [path.lineWidth * 3, path.lineWidth * 3]
path.setLineDash(dashes, count: dashes.count, phase: 0)
path.lineCapStyle = .Round

UIGraphicsBeginImageContextWithOptions(CGSizeMake(300, 20), false, 2)
path.stroke()

let view = UIView(frame: CGRectMake(0,0,500,500))
view.backgroundColor = UIColor.whiteColor()

let image = UIGraphicsGetImageFromCurrentImageContext()

UIGraphicsEndImageContext()

// ------------------ curve line ------------------------


>>>>>>> 673fc6f1e4e4b00c4dbbdba146b548fe0fddb6ab
