//
//  ComplicationController.swift
//  Diabetapp for AppleWatch Extension
//
//  Created by Alex Telek on 05/12/2015.
//  Copyright © 2015 Diabetapp. All rights reserved.
//

import ClockKit

class ComplicationController: NSObject, CLKComplicationDataSource {
    
    let timeline = DATimeline().timeline
    
    // MARK: - Timeline Configuration
    func getEntryFor(complication: CLKComplication, entry: DAEntry, date: NSDate) -> CLKComplicationTimelineEntry? {
        switch complication.family {
        case .ModularSmall:
            let modularSmallTemplate = CLKComplicationTemplateModularSmallRingText()
            modularSmallTemplate.textProvider = CLKSimpleTextProvider(text: "\(entry.level)")
            modularSmallTemplate.fillFraction = Float(entry.estimate) / 100.0
            modularSmallTemplate.ringStyle = .Closed
            let entry = CLKComplicationTimelineEntry(date: date, complicationTemplate: modularSmallTemplate)
            return entry
        case .ModularLarge:
            let modularLargeTemplate = CLKComplicationTemplateModularLargeStandardBody()
            modularLargeTemplate.headerTextProvider = CLKTimeIntervalTextProvider(startDate: entry.entryDate,
                endDate: NSDate(timeInterval: 60, sinceDate: entry.entryDate))
            modularLargeTemplate.body1TextProvider =
                CLKSimpleTextProvider(text: "\(entry.level) mg/dL", shortText: "\(entry.level) mg/dL")
            modularLargeTemplate.body2TextProvider =
                CLKSimpleTextProvider(text: "\(entry.estimate)% confidence", shortText: nil)
            let entry = CLKComplicationTimelineEntry(date: date, complicationTemplate: modularLargeTemplate)
            return entry
        case .UtilitarianLarge:
            let template = CLKComplicationTemplateUtilitarianLargeFlat()
            template.textProvider = CLKSimpleTextProvider(text: "\(entry.level) mg/dL (\(entry.estimate)%)")
            let entry = CLKComplicationTimelineEntry(date: date, complicationTemplate: template)
            return entry
        default: return nil
        }
    }
    
    func getSupportedTimeTravelDirectionsForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.Forward, .Backward])
    }
    
    func getTimelineStartDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(NSDate(timeIntervalSinceNow: -3.5 * DATimeline.HOUR))
    }
    
    func getTimelineEndDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
         handler(NSDate(timeIntervalSinceNow: 3.5 * DATimeline.HOUR))
    }
    
    func getPrivacyBehaviorForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.ShowOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntryForComplication(complication: CLKComplication, withHandler handler: ((CLKComplicationTimelineEntry?) -> Void)) {
        
        for entry in timeline {
            if (entry.entryDate.timeIntervalSinceNow >= 0) {
                handler(getEntryFor(complication, entry: entry, date: entry.entryDate))
                return
            }
        }
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, beforeDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {

        var timelineEntries: [CLKComplicationTimelineEntry] = []
        
        for entry in timeline {
            if timelineEntries.count < limit && entry.entryDate.timeIntervalSinceDate(date) < 0 {
                timelineEntries.append(getEntryFor(complication, entry: entry, date: entry.entryDate)!)
            }
        }
        
        handler(timelineEntries)
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, afterDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        
        var timelineEntries: [CLKComplicationTimelineEntry] = []
        
        for entry in timeline {
            if timelineEntries.count < limit && entry.entryDate.timeIntervalSinceDate(date) > 0  {
                timelineEntries.append(getEntryFor(complication, entry: entry, date: entry.entryDate)!)
            }
        }
        handler(timelineEntries)
    }
    
    // MARK: - Update Scheduling
    
    func getNextRequestedUpdateDateWithHandler(handler: (NSDate?) -> Void) {
        // Call the handler with the date when you would next like to be given the opportunity to update your complication content
        handler(NSDate(timeIntervalSinceNow: 5 * DATimeline.MINUTE));
    }
    
    // MARK: - Placeholder Templates
    
    func getPlaceholderTemplateForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        handler(nil)
    }
    
}
