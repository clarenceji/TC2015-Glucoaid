import UIKit
import XCPlayground

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


