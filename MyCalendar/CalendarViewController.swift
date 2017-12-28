//
//  CalendarViewController.swift
//  MyCalendar
//
//  Created by Rabih Fawaz on 12/26/17.
//  Copyright © 2017 PCTools. All rights reserved.
//

import UIKit
import EventKit


class CalendarViewController: UIViewController {
    
    @IBAction func btnAddEventTapped(_ sender: Any) {
        let eventStore: EKEventStore = EKEventStore()
        /*
         must add in the info.plist Privacy - "Calendars Usage Description"
         a string to request access to calendar ex. "This app requires Calendar Access"
         */
        eventStore.requestAccess(to: .event) { (granted, error) in
            if (granted) && (error == nil)
            {
                let curDate:String = "2017-12-02 5:00 PM"
                var myDate:Date? = nil
                let df : DateFormatter = {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd h:mm a"
                    formatter.timeZone = TimeZone.current // go back to user's timezone
                    return formatter
                }()
                guard let date = df.date(from: curDate)    else {
                    fatalError("ERROR: Date conversion failed due to mismatched format.")
                }
                myDate = date
                
                let event:EKEvent = EKEvent(eventStore: eventStore)
                event.title = "Add Event test string"
                event.startDate = myDate
                event.endDate = myDate
                event.notes = "This is a note"
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch  {
                    print("try error  \(error)")
                }
                print("Event saved...")
                
            }else{
                print("else error: \(String(describing: error))")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    
    
}


