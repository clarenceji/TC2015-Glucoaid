//
//  InterfaceController.swift
//  Diabetapp for AppleWatch Extension
//
//  Created by Alex Telek on 05/12/2015.
//  Copyright © 2015 Diabetapp. All rights reserved.
//

import WatchKit
import Foundation
import ClockKit

class InterfaceController: WKInterfaceController {

    @IBOutlet var level: WKInterfaceLabel!
    
    var timeline = DATimeline()
    var timer: NSTimer!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        DAServer.sharedSession().fetchData("http://tc2015.herokuapp.com/graph") { (data, error) -> Void in
            if data != nil {
                self.timeline.convertDataToDAEntries(data)
                
                self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "loadCurrentSugarLevel", userInfo: nil, repeats: true)
                self.timer.fire()
                self.loadCurrentSugarLevel()
            }
        }
    }
    
    func loadCurrentSugarLevel() {
        let entry = timeline.getEntryForDate(NSDate())
        if entry.level < 180 && entry.level > 70 {
            level.setTextColor(UIColor.blueColor())
        } else {
            level.setTextColor(UIColor.redColor())
        }
        level.setText("\(entry.level)")
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
