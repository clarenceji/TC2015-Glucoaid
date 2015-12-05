//
//  ViewController.swift
//  Diabetapp
//
//  Created by Clarence Ji on 12/5/15.
//  Copyright © 2015 Diabetapp. All rights reserved.
//

import UIKit
import Charts

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
    
    @IBOutlet var view_Graph: UIView!
    
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
        let lineChartView = LineChartView(frame: view_Graph.bounds)
        lineChartView.data = LineChartData(xVals: [0, 1, 2, 3, 4, 5])
        
        view_Graph.addSubview(lineChartView)
    }

}
