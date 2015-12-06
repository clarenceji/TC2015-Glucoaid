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
    
    func timelineData() -> [DAEntry] {
        
        let entries = [DAEntry(level: 140, estimate: 100, entryDate: NSDate(dateString: "2015-12-06 10:53:00")),
            DAEntry(level: 139, estimate: 90, entryDate: NSDate(dateString: "2015-12-06 10:54:00")),
            DAEntry(level: 139, estimate: 85, entryDate: NSDate(dateString: "2015-12-06 11:02:00")),
            DAEntry(level: 138, estimate: 90, entryDate: NSDate(dateString: "2015-12-06 11:03:00")),
            DAEntry(level: 138, estimate: 90, entryDate: NSDate(dateString: "2015-12-06 11:11:00")),
            DAEntry(level: 137, estimate: 92, entryDate: NSDate(dateString: "2015-12-06 11:12:00")),
            DAEntry(level: 137, estimate: 80, entryDate: NSDate(dateString: "2015-12-06 11:20:00")),
            DAEntry(level: 136, estimate: 70, entryDate: NSDate(dateString: "2015-12-06 11:21:00")),
            DAEntry(level: 136, estimate: 78, entryDate: NSDate(dateString: "2015-12-06 11:30:00")),
            DAEntry(level: 135, estimate: 80, entryDate: NSDate(dateString: "2015-12-06 11:31:00")),
            DAEntry(level: 135, estimate: 90, entryDate: NSDate(dateString: "2015-12-06 11:41:00")),
            DAEntry(level: 134, estimate: 90, entryDate: NSDate(dateString: "2015-12-06 11:42:00")),
            DAEntry(level: 134, estimate: 85, entryDate: NSDate(dateString: "2015-12-06 11:52:00")),
            DAEntry(level: 133, estimate: 90, entryDate: NSDate(dateString: "2015-12-06 11:53:00")),
            DAEntry(level: 133, estimate: 90, entryDate: NSDate(dateString: "2015-12-06 12:04:00")),
            DAEntry(level: 132, estimate: 92, entryDate: NSDate(dateString: "2015-12-06 12:05:00")),
            DAEntry(level: 132, estimate: 80, entryDate: NSDate(dateString: "2015-12-06 12:17:00")),
            DAEntry(level: 131, estimate: 70, entryDate: NSDate(dateString: "2015-12-06 12:18:00")),
            DAEntry(level: 131, estimate: 78, entryDate: NSDate(dateString: "2015-12-06 12:31:00")),
            DAEntry(level: 130, estimate: 80, entryDate: NSDate(dateString: "2015-12-06 12:32:00")),]
        return entries
    }
}
    
extension NSDate
{
    convenience init(dateString:String) {
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        let d = dateStringFormatter.dateFromString(dateString)!
        self.init(timeInterval:0, sinceDate:d)
    }
}
