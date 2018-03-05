//
//  HomeViewController.swift
//  Manner
//
//  Created by Robo Atenaga on 1/23/18.
//  Copyright © 2018 Robo Atenaga. All rights reserved.
//

import UIKit
import Charts

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var pieChart1: PieChartView!
    @IBOutlet weak var lineChart: LineChartView!
    @IBOutlet weak var pieChart2: PieChartView!
    @IBOutlet weak var secondTable: UITableView!
    @IBOutlet weak var firstTable: UITableView!
    @IBOutlet weak var heightTB1: NSLayoutConstraint!
    @IBOutlet weak var heightTB2: NSLayoutConstraint!
    @IBOutlet weak var lblToDate: UILabel!
    @IBOutlet weak var lblFromDate: UILabel!
    
    let homeDataProvider = HomeDataProvider()
    var rowHeight1 = 30
    var rowHeight2 = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updatePieChart1()
        updatePieChart2()
        updateLineChart()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let tblArray = [self.firstTable, self.secondTable]
        for tableView: UITableView! in tblArray {
            tableView.reloadData()
        }
    }
    
    @IBAction func chooseDate(_ sender: UIButton) {
        self.view.alpha = 0.5
        performSegue(withIdentifier: "dateSegue", sender: sender.tag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier!){
        case "dateSegue":
            let popUp = segue.destination as! CalendarController
            popUp.buttonTag = sender as! Int
            // Assign to a function
            //        popUp.onSelect = onSelect
            // Or use a closure
            popUp.onSelect = { (_ date: String, _ buttonTag: Int) -> () in
                self.view.alpha = 1.0
                if buttonTag == 1 {
                    self.lblFromDate.text = "Từ \(date)"
                }
                else {
                    self.lblToDate.text = "Đến \(date)"
                }
            }
            break
        default:
            break
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1 {
            heightTB1.constant = (CGFloat(homeDataProvider.dataForFirstTable.count * rowHeight1))
            return homeDataProvider.dataForFirstTable.count
        }
        else if tableView.tag == 2 {
            heightTB2.constant = (CGFloat(homeDataProvider.dataForSecondTable.count * rowHeight2))
            return homeDataProvider.dataForSecondTable.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customTableCell", for: indexPath) as! CustomTableViewCell
        if tableView.tag == 1 {
            cell.lblTitle?.text = (homeDataProvider.dataForFirstTable[indexPath.row])[0]
            cell.lblAmount.text = (homeDataProvider.dataForFirstTable[indexPath.row])[1]
        }
        else if tableView.tag == 2 {
            cell.lblTitle?.text = (homeDataProvider.dataForSecondTable[indexPath.row])[0]
            cell.lblAmount.text = (homeDataProvider.dataForSecondTable[indexPath.row])[1]
        }
        return cell
    }
    
    func updatePieChart1() {
        let colors : [UIColor] = [#colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1),#colorLiteral(red: 0.4705882353, green: 0.7882352941, blue: 0.2078431373, alpha: 1),#colorLiteral(red: 0.8210947514, green: 0.07326758653, blue: 0.1934489012, alpha: 1),#colorLiteral(red: 0.9314855933, green: 0.8804892898, blue: 0.02383280732, alpha: 1)]
        let entry1 = PieChartDataEntry(value: 50.0)
        let entry2 = PieChartDataEntry(value: 25.5)
        let entry3 = PieChartDataEntry(value: 14.5)
        let entry4 = PieChartDataEntry(value: 10.0)
        let dataSet = PieChartDataSet(values: [entry1, entry2, entry3, entry4], label: "")
        dataSet.drawValuesEnabled = false
        dataSet.colors = colors
        let data = PieChartData(dataSets: [dataSet])
        
        pieChart1.data = data
        pieChart1.highlightPerTapEnabled = false
        pieChart1.chartDescription?.enabled = false
        pieChart1.legend.enabled = false
        pieChart1.setExtraOffsets(left: 0, top: -5, right: -5, bottom: 0)
        pieChart1.holeRadiusPercent = 0.65
        pieChart1.transparentCircleRadiusPercent = 0.1
        pieChart1.animate(xAxisDuration: 1.5, easingOption: .easeOutBack)
        
        // This must always be at the end of function
        pieChart1.notifyDataSetChanged()
    }
    
    func updatePieChart2() {
        let colors : [UIColor] = [#colorLiteral(red: 0.5019607843, green: 0.5254901961, blue: 0.8705882353, alpha: 1),#colorLiteral(red: 0.9396448731, green: 0.913020432, blue: 0.9737439752, alpha: 1)]
        let entry1 = PieChartDataEntry(value: 63.0)
        let entry2 = PieChartDataEntry(value: 37.0)
        let dataSet = PieChartDataSet(values: [entry1, entry2], label: "")
        dataSet.colors = colors
        dataSet.drawValuesEnabled = false
        let data = PieChartData(dataSets: [dataSet])
        
        let centerText = NSMutableAttributedString(string: "63%")
        centerText.setAttributes([.font : UIFont(name: "HelveticaNeue-Bold", size: 30)!, .foregroundColor : #colorLiteral(red: 0.5019607843, green: 0.5254901961, blue: 0.8705882353, alpha: 1)], range: NSRange(location: 0, length: centerText.length))
        pieChart2.data = data
        pieChart2.centerAttributedText = centerText
        pieChart2.highlightPerTapEnabled = false
        pieChart2.chartDescription?.enabled = false
        pieChart2.legend.enabled = false
        pieChart2.holeRadiusPercent = 0.85
        pieChart2.setExtraOffsets(left: -10, top: -20, right: -5, bottom: -20)
        pieChart2.animate(xAxisDuration: 1.5, easingOption: .easeOutBack)
        
        // This must always be at the end of function
        pieChart2.notifyDataSetChanged()
    }
    
    func updateLineChart() {
        let dollars1 = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        // 1 - creating an array of data entries
        var values : [ChartDataEntry] = [ChartDataEntry]()
        
        for i in 0 ..< months.count {
            values.append(ChartDataEntry(x: Double(i + 1), y: dollars1[i]))
        }
        let dataSet = LineChartDataSet(values: values, label: "")
        dataSet.drawValuesEnabled = false
        dataSet.setColor(#colorLiteral(red: 0.4549019608, green: 0.6941176471, blue: 0.8470588235, alpha: 1))
        dataSet.setCircleColor(#colorLiteral(red: 0.05490196078, green: 0.4901960784, blue: 0.7568627451, alpha: 1))
        dataSet.drawCircleHoleEnabled = false
        dataSet.circleRadius = 3
        let data = LineChartData(dataSet: dataSet)
        lineChart.data = data
        lineChart.chartDescription?.enabled = false
        lineChart.legend.enabled = false

        lineChart.xAxis.drawGridLinesEnabled = false
        lineChart.xAxis.labelPosition = .bottom
        lineChart.rightAxis.enabled = false
        
        // This must always be at the end of function
        lineChart.notifyDataSetChanged()
    }
    
}
