//
//  WalletViewController.swift
//  Manner
//
//  Created by Robo Atenaga on 2/5/18.
//  Copyright © 2018 Robo Atenaga. All rights reserved.
//

import UIKit

class WalletViewController: UIViewController {
    @IBOutlet weak var tblMini1: UITableView!
    @IBOutlet weak var tblMini2: UITableView!
    @IBOutlet weak var tblMini3: UITableView!
    @IBOutlet weak var heightTB1: NSLayoutConstraint!
    @IBOutlet weak var heightTB2: NSLayoutConstraint!
    @IBOutlet weak var heightTB3: NSLayoutConstraint!
    
    var commoditiesDataProvider = CommoditiesDataProvider()
    var rowHeight = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let tblArray = [self.tblMini1, self.tblMini2, self.tblMini3]
        for tableView: UITableView! in tblArray {
            tableView.reloadData()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! AddCommoditiesViewController
        nextVC.previousVC = self
        nextVC.commoditiesDataProvider = commoditiesDataProvider
    }
    
}

extension WalletViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1 {
            heightTB1.constant = (CGFloat((commoditiesDataProvider.dataForMiniTable1.count) * rowHeight))
            return commoditiesDataProvider.dataForMiniTable1.count
        }
        else if tableView.tag == 2 {
            heightTB2.constant = (CGFloat((commoditiesDataProvider.dataForMiniTable2.count) * rowHeight))
            return commoditiesDataProvider.dataForMiniTable2.count
        }
        else {
            heightTB3.constant = (CGFloat((commoditiesDataProvider.dataForMiniTable3.count) * rowHeight))
            return commoditiesDataProvider.dataForMiniTable3.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "miniTableCell", for: indexPath) as! CustomTableViewCell
        if tableView.tag == 1{
            cell.lblTitle?.text = (commoditiesDataProvider.dataForMiniTable1[(indexPath.row)])[0]
            cell.lblAmount?.text = (commoditiesDataProvider.dataForMiniTable1[(indexPath.row)])[1]
        }
        else if tableView.tag == 2{
            cell.lblTitle?.text = (commoditiesDataProvider.dataForMiniTable2[(indexPath.row)])[0]
            cell.lblAmount?.text = (commoditiesDataProvider.dataForMiniTable2[(indexPath.row)])[1]
        }
        else{
            cell.lblTitle?.text = (commoditiesDataProvider.dataForMiniTable3[(indexPath.row)])[0]
            cell.lblAmount?.text = (commoditiesDataProvider.dataForMiniTable3[(indexPath.row)])[1]
        }
        return cell
    }
}
