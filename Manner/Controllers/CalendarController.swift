//
//  CalendarController.swift
//  Manner
//
//  Created by Robo Atenaga on 1/30/18.
//  Copyright © 2018 Robo Atenaga. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarController: UIViewController {
    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var lblMonthYear: UILabel!
    
    let dateFormatter = DateFormatter()
    var selectedDate : String = ""
    var buttonTag : Int = -1
    // function type to help pass data back to vc
    var onSelect: ((_ date: String, _ buttonTag: Int) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCalendar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeMonth(_ sender: UIButton) {
        if sender.tag == 1 {
            self.calendarView.scrollToSegment(.previous)
        }
        else if sender.tag == 2 {
            self.calendarView.scrollToSegment(.next)
        }
    }
    
    @IBAction func choose(_ sender: UIButton) {
        if selectedDate.elementsEqual("") {return}
        onSelect?(selectedDate, buttonTag)
        dismiss(animated: true)
    }
    
    func setUpCalendar() {
        // Setup calendar spacing
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        
        // Setup calendar labels
        calendarView.visibleDates{ visibleDates in
            self.setUpCalendarLabels(from: visibleDates)
        }
    }
    
    func setUpCalendarLabels(from visibleDates: DateSegmentInfo) {
        let date = visibleDates.monthDates.first!.date
        self.dateFormatter.dateFormat = "MMMM yyyy"
        self.lblMonthYear.text = self.dateFormatter.string(from: date)
    }
    
    func handleSelectedCell(cell: JTAppleCell?, cellState: CellState) {
        // Make sure cell is not nil
        guard let dateCell = cell as? CalendarCell else { return}
        if cellState.isSelected {
            dateCell.selectedView.isHidden = false
            dateCell.dateLabel.textColor = UIColor.white
        }
        else {
            dateCell.selectedView.isHidden = true
            if cellState.day == .sunday {
                dateCell.dateLabel.textColor = UIColor.red
            }
            else {
                dateCell.dateLabel.textColor = UIColor.black
            }
        }
    }
}

extension CalendarController: JTAppleCalendarViewDataSource {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        dateFormatter.dateFormat = "yyyy MM dd"
        dateFormatter.timeZone = Calendar.current.timeZone
        dateFormatter.locale = Calendar.current.locale
        
        let startDate = dateFormatter.date(from: "2018 01 01")
        let endDate = dateFormatter.date(from: "2019 12 31")
        
        let params = ConfigurationParameters(startDate: startDate!, endDate: endDate!, numberOfRows: 5)
        return params
    }
}

extension CalendarController: JTAppleCalendarViewDelegate {
    
    // Displaying the cell
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let dateCell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "calendarCell", for: indexPath) as! CalendarCell
        self.calendar(calendar, willDisplay: dateCell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        return dateCell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleSelectedCell(cell: cell, cellState: cellState)
        dateFormatter.dateFormat = buttonTag == 1 ? "dd-MM" : "dd-MM-yyyy"
        selectedDate = dateFormatter.string(from: date)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleSelectedCell(cell: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setUpCalendarLabels(from: visibleDates)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        guard let dateCell = cell as? CalendarCell else { return}
        dateCell.dateLabel?.text = cellState.text
        if cellState.dateBelongsTo == .thisMonth{
            dateCell.isHidden = false
        }
        else {
            dateCell.isHidden = true
        }
        handleSelectedCell(cell: dateCell, cellState: cellState)
    }
}

