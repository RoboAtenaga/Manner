//
//  AddCommoditiesViewController.swift
//  Manner
//
//  Created by Robo Atenaga on 2/5/18.
//  Copyright © 2018 Robo Atenaga. All rights reserved.
//

import UIKit

class AddCommoditiesViewController: UIViewController {
    
    @IBOutlet weak var tblMain1: UITableView!
    @IBOutlet weak var tblMain2: UITableView!
    @IBOutlet weak var tblMain3: UITableView!
    @IBOutlet weak var heightTB1: NSLayoutConstraint!
    @IBOutlet weak var heightTB2: NSLayoutConstraint!
    @IBOutlet weak var heightTB3: NSLayoutConstraint!
    
    var commoditiesDataProvider : CommoditiesDataProvider? = nil
    
    var previousVC : WalletViewController? = nil
    var rowHeight = 90
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let tblArray = [self.tblMain1, self.tblMain2, self.tblMain3]
        for tableView: UITableView! in tblArray {
            tableView.reloadData()
        }
    }
    
    @IBAction func deleteTapped(_ sender: UIButton) {
        if sender.tag < 200{
            commoditiesDataProvider?.dataForMiniTable1.remove(at: (sender.tag - 100))
            tblMain1.reloadData()
        }
        else if sender.tag < 300{
            commoditiesDataProvider?.dataForMiniTable2.remove(at: (sender.tag - 200))
            tblMain2.reloadData()
        }
        else{
            commoditiesDataProvider?.dataForMiniTable3.remove(at: (sender.tag - 300))
            tblMain3.reloadData()
        }
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        previousVC?.commoditiesDataProvider = commoditiesDataProvider!
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "addCommodity", sender: sender)
    }
    
    @IBAction func txtValueChanged(_ sender: UITextField) {
        let amount = sender.text!
        if sender.tag < 200{
            (commoditiesDataProvider!.dataForMiniTable1[sender.tag - 100])[1] = amount
        }
        else if sender.tag < 300{
            (commoditiesDataProvider!.dataForMiniTable2[sender.tag - 200])[1] = amount
        }
        else{
            (commoditiesDataProvider!.dataForMiniTable3[sender.tag - 300])[1] = amount
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! CommoditiesViewController
        nextVC.addButtonTag = (sender as! UIButton).tag
        nextVC.previousVC = self
    }
}

extension AddCommoditiesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1 {
            heightTB1.constant = (CGFloat((commoditiesDataProvider?.dataForMiniTable1.count)! * rowHeight))
            return commoditiesDataProvider!.dataForMiniTable1.count
        }
        else if tableView.tag == 2 {
            heightTB2.constant = (CGFloat((commoditiesDataProvider?.dataForMiniTable2.count)! * rowHeight))
            return commoditiesDataProvider!.dataForMiniTable2.count
        }
        else {
            heightTB3.constant = (CGFloat((commoditiesDataProvider?.dataForMiniTable3.count)! * rowHeight))
            return commoditiesDataProvider!.dataForMiniTable3.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainTableCell", for: indexPath) as! CustomTableViewCell2
        cell.txtAmount?.tag = indexPath.row + (tableView.tag * 100)
        cell.btnDelete?.tag = indexPath.row + (tableView.tag * 100)
        if tableView.tag == 1{
            cell.lblTitle?.text = (commoditiesDataProvider!.dataForMiniTable1[(indexPath.row)])[0]
            cell.txtAmount?.text = (commoditiesDataProvider!.dataForMiniTable1[(indexPath.row)])[1]
        }
        else if tableView.tag == 2{
            cell.lblTitle?.text = (commoditiesDataProvider!.dataForMiniTable2[(indexPath.row)])[0]
            cell.txtAmount?.text = (commoditiesDataProvider!.dataForMiniTable2[(indexPath.row)])[1]
        }
        else{
            cell.lblTitle?.text = (commoditiesDataProvider!.dataForMiniTable3[(indexPath.row)])[0]
            cell.txtAmount?.text = (commoditiesDataProvider!.dataForMiniTable3[(indexPath.row)])[1]
        }
        return cell
    }
    
}
