    //
//  DATimeline.swift
//  Diabetapp
//
//  Created by Alex Telek on 05/12/2015.
//  Copyright © 2015 Diabetapp. All rights reserved.
//

import UIKit

class DATimeline: NSObject {
    static let HOUR: NSTimeInterval = 60 * 60
    static let MINUTE: NSTimeInterval = 60
    
    //var timeline = DATimeline.dummyTimeline()
    
    func addEntryToTimeline(level: Int, estimate: Int) {
        
        let entry = DAEntry(level: level, estimate: estimate, entryDate: NSDate())
        //timeline.append(entry)
    }
    
    func dummyTimeline() -> [DAEntry] {
    
        let entries = [DAEntry(level: 10 * 1, estimate: 100, entryDate: NSDate(timeIntervalSinceNow: -180 * DATimeline.MINUTE)),
            DAEntry(level: 10 * 2, estimate: 100, entryDate: NSDate(timeIntervalSinceNow: -140 * DATimeline.MINUTE)),
            DAEntry(level: 10 * 3, estimate: 100, entryDate: NSDate(timeIntervalSinceNow: -100 * DATimeline.MINUTE)),
            DAEntry(level: 10 * 4, estimate: 100, entryDate: NSDate(timeIntervalSinceNow: -60 * DATimeline.MINUTE)),
            DAEntry(level: 10 * 5, estimate: 100, entryDate: NSDate(timeIntervalSinceNow: -20 * DATimeline.MINUTE)),
            DAEntry(level: 10 * 6, estimate: 100, entryDate: NSDate(timeIntervalSinceNow: 20 * DATimeline.MINUTE)),
            DAEntry(level: 10 * 7, estimate: 100, entryDate: NSDate(timeIntervalSinceNow: 60 * DATimeline.MINUTE)),
            DAEntry(level: 10 * 8, estimate: 100, entryDate: NSDate(timeIntervalSinceNow: 100 * DATimeline.MINUTE)),
            DAEntry(level: 10 * 9, estimate: 100, entryDate: NSDate(timeIntervalSinceNow: 140 * DATimeline.MINUTE)),
            DAEntry(level: 10 * 10, estimate: 100, entryDate: NSDate(timeIntervalSinceNow: 180 * DATimeline.MINUTE))]
        return entries
    }
}
