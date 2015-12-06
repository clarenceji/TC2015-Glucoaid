//
//  ViewController.swift
//  Diabetapp
//
//  Created by Clarence Ji on 12/5/15.
//  Copyright © 2015 Diabetapp. All rights reserved.
//

import UIKit

enum IsItSafeOrNot {
    case Safe
    case NotSafe
}

class DAViewController: UIViewController {

    @IBOutlet var label_currentEst: UILabel!
    @IBOutlet var label_data_currentEst: UILabel!
    @IBOutlet var label_data_SugarLevel: UILabel!
    @IBOutlet var label_unit: UILabel!
    @IBOutlet var button_AddNewInput: UIButton!
    
    @IBOutlet var scrollView_Graph: UIScrollView!
    
    var lineChart: LineChart!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        label_currentEst.textColor = UIColor.whiteColor()
        label_data_currentEst.textColor = UIColor.whiteColor()
        label_data_SugarLevel.textColor = UIColor.whiteColor()
        label_unit.textColor = UIColor.whiteColor()
        button_AddNewInput.tintColor = UIColor.whiteColor()
        
        // TODO: Change color scheme based on situation
        makeItSafe()
//        makeItScary()
        
        makeGraph()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        print(lineChart.y.labels.values)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func makeNavigationStyle(color: UIColor) {
        self.navigationController?.navigationBar.barTintColor = color
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName  :   UIColor.whiteColor()
        ]
    }
    
    func makeItSafe() {
        makeNavigationStyle(UIColor.diabetBlue())
        makeGradientBg(.Safe)
        self.button_AddNewInput.backgroundColor = UIColor.diabetBlue()
    }
    
    func makeItScary() {
        makeNavigationStyle(UIColor.diabetRed())
        makeGradientBg(.NotSafe)
        self.button_AddNewInput.backgroundColor = UIColor.diabetRed()
    }
    
    func makeGradientBg(isSafe: IsItSafeOrNot) {
        
        var initialColor: UIColor!
        if isSafe == .Safe {
            
            initialColor = UIColor.diabetBlue()
            
        } else {
            
            initialColor = UIColor.diabetRed()
            
        }
        
        let gradientColor = UIColor.whiteColor()
        let gradientColors = [initialColor.CGColor, gradientColor.CGColor]
        let gradientLocations: [CGFloat] = [0.2, 0.8]
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        gradientLayer.frame = view.bounds
        
        view.layer.insertSublayer(gradientLayer, atIndex: 0)
    }
    
    func makeGraph() {
        lineChart = LineChart(frame: scrollView_Graph.bounds)
        lineChart.addLine([3,5,7,1,9,2,12])
        
        lineChart.x.grid.color = UIColor.clearColor()
        lineChart.y.grid.color = lineChart.y.grid.color.colorWithAlphaComponent(0.3)
        lineChart.x.axis.color = UIColor(red: 0.121569, green: 0.466667, blue: 0.705882, alpha: 1)
        
        lineChart.y.labels.visible = false
        lineChart.x.labels.values = ["7:00", "8:00", "9:00", "10:00", "11:00", "12:00", "13:00"]
        
        scrollView_Graph.contentSize = lineChart.bounds.size
        scrollView_Graph.autoresizingMask = .FlexibleWidth
        scrollView_Graph.addSubview(lineChart)
    }

}
