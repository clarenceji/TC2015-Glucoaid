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
    var timeline = DATimeline()
    var timer: NSTimer!
    
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
        
        lineChart = LineChart()
        
        loadData()
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
    
    func makeGraph(line: [CGFloat], xLabelValues: [String], shouldCreateLabel: [Bool]) {
        
        dispatch_async(dispatch_get_main_queue(), {
            
            self.lineChart = LineChart(frame: self.scrollView_Graph.bounds)
            self.lineChart.addLine(line)
            
            self.lineChart.dots.visible = false
            
            self.lineChart.x.grid.color = UIColor.clearColor()
            self.lineChart.y.grid.color = self.lineChart.y.grid.color.colorWithAlphaComponent(0.3)
            self.lineChart.x.axis.color = UIColor(red: 0.121569, green: 0.466667, blue: 0.705882, alpha: 1)
            
            self.lineChart.y.labels.visible = false
            self.lineChart.x.labels.values = xLabelValues
            self.lineChart.x.labels.shouldCreateLabel = shouldCreateLabel
            
            self.scrollView_Graph.contentSize = self.lineChart.bounds.size
            self.scrollView_Graph.autoresizingMask = .FlexibleWidth
            self.scrollView_Graph.addSubview(self.lineChart)
            
        })
        
    }
    
    func loadData() {
        
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("downloadedData") {
            timeline.convertDataToDAEntries(data as? [[String]])
            loadDataAndMakeGraph(timeline.timeline)
        } else {
            DAServer.sharedSession().fetchData("http://tc2015.herokuapp.com/graph") { (data, error) -> Void in
                if data != nil {
                    self.timeline.convertDataToDAEntries(data)
                    self.loadDataAndMakeGraph(self.timeline.timeline)
                    
                    self.timer = NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: "loadCurrentSugarLevel", userInfo: nil, repeats: true)
                    self.timer.fire()
                    self.loadCurrentSugarLevel()
                }
            }
        }
    }
    
    func loadCurrentSugarLevel() {
        label_data_SugarLevel.text = "\(self.timeline.getEntryForDate(NSDate()).level)"
    }
    
    func loadDataAndMakeGraph(entries: [DAEntry]) {
        var line = [CGFloat]()
        var xLabelValues = [String]()
        var shouldCreateLabel = [Bool]()
        for (index, entry) in entries.enumerate() {
//            if index > 30 && index < 60 {
                line.append(CGFloat(entry.level))
                
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "HH:MM"
            
            if index == 0 || index % 50 == 0 || index == entries.count - 1 {
                xLabelValues.append(dateFormatter.stringFromDate(entry.entryDate))
                print(entry.entryDate)
                shouldCreateLabel.append(true)
            } else {
                xLabelValues.append("")
                shouldCreateLabel.append(false)
            }
//            } else if index >= 60 {
//                break
//            }
        }
        makeGraph(line, xLabelValues: xLabelValues, shouldCreateLabel: shouldCreateLabel)
    }
    
    func storeFetchResults(data: [[String]]?) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(data, forKey: "downloadedData")
    }
}
