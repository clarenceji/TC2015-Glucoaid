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
    
    var timeline = [DAEntry]()
    
    func convertDataToDAEntries(data: [[String]]?) {
        
        for entry: [String] in data! {
            var entryTime = entry[0]
            entryTime = entryTime.substringWithRange(Range<String.Index>(start: entryTime.startIndex, end: entryTime.endIndex.advancedBy(-3)))
            
            let entryDate = NSDate(timeIntervalSince1970: Double(entryTime)!)
            
            let daEntry = DAEntry(level: Int(entry[1])!, estimate: 60, entryDate: entryDate)
            
            timeline.append(daEntry)
        }
    }
    
    func getEntryForDate(date: NSDate) -> DAEntry {
        if timeline.count > 0 {
            let filtered = timeline.filter({ (entry) -> Bool in
                return entry.entryDate.timeIntervalSinceDate(date) > 0
            })
            
            return filtered[0]
        }
        
        return timeline[0]
    }
    
    func dummyTimeline() -> [DAEntry] {
    
        let entries = [DAEntry(level: 10 * 5, estimate: 100, entryDate: NSDate(timeIntervalSinceNow: -20 * DATimeline.MINUTE)),
            DAEntry(level: 10 * 4, estimate: 100, entryDate: NSDate(timeIntervalSinceNow: -60 * DATimeline.MINUTE)),
            DAEntry(level: 10 * 3, estimate: 100, entryDate: NSDate(timeIntervalSinceNow: -100 * DATimeline.MINUTE)),
            DAEntry(level: 10 * 2, estimate: 100, entryDate: NSDate(timeIntervalSinceNow: -140 * DATimeline.MINUTE)),
            DAEntry(level: 10 * 1, estimate: 100, entryDate: NSDate(timeIntervalSinceNow: -180 * DATimeline.MINUTE)),
            DAEntry(level: 10 * 6, estimate: 100, entryDate: NSDate(timeIntervalSinceNow: 0 * DATimeline.MINUTE)),
            DAEntry(level: 10 * 6, estimate: 100, entryDate: NSDate(timeIntervalSinceNow: 20 * DATimeline.MINUTE)),
            DAEntry(level: 10 * 7, estimate: 100, entryDate: NSDate(timeIntervalSinceNow: 60 * DATimeline.MINUTE)),
            DAEntry(level: 10 * 8, estimate: 100, entryDate: NSDate(timeIntervalSinceNow: 100 * DATimeline.MINUTE)),
            DAEntry(level: 10 * 9, estimate: 100, entryDate: NSDate(timeIntervalSinceNow: 140 * DATimeline.MINUTE)),
            DAEntry(level: 10 * 10, estimate: 100, entryDate: NSDate(timeIntervalSinceNow: 180 * DATimeline.MINUTE))]
        return entries
    }
}
