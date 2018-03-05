//
//  CommoditiesViewController.swift
//  Manner
//
//  Created by Robo Atenaga on 2/2/18.
//  Copyright © 2018 Robo Atenaga. All rights reserved.
//

import UIKit

class CommoditiesViewController: UIViewController {
    
    var addButtonTag : Int? = nil
    var previousVC : AddCommoditiesViewController? = nil
    var commoditiesDataProvider = CommoditiesDataProvider()
    let itemsPerRow: CGFloat = 3
    let sectionInsets = UIEdgeInsets(top: 5.0, left: 0.0, bottom: 5.0, right: 0.0)
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var commoditiesCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if addButtonTag == 1 {
            lblTitle.text! = "Thêm ngân sách tối thiểu"
            var imageData = ["Thuê nhà","iconHouseBright"]
            commoditiesDataProvider.commodities.append(imageData)
            imageData = ["Điện","iconElectricityBright"]
            commoditiesDataProvider.commodities.append(imageData)
            imageData = ["Nước","iconWaterBright"]
            commoditiesDataProvider.commodities.append(imageData)
            imageData = ["Thực phẩm","iconFoodBright"]
            commoditiesDataProvider.commodities.append(imageData)
            imageData = ["TV, Internet","iconTelevisionBright"]
            commoditiesDataProvider.commodities.append(imageData)
            imageData = ["Điện thoại","iconPhoneBright"]
            commoditiesDataProvider.commodities.append(imageData)
            imageData = ["Xăng xe","iconGasBright"]
            commoditiesDataProvider.commodities.append(imageData)
            imageData = ["Trả nợ","iconLoanBright"]
            commoditiesDataProvider.commodities.append(imageData)
            imageData = ["Ngân sách khác","iconPlusBright"]
            commoditiesDataProvider.commodities.append(imageData)
        }
        else if addButtonTag == 2 {
            lblTitle.text! = "Thêm ngân sách cơ bản"
            var imageData = ["Mua sắm","iconShoppingBright"]
            commoditiesDataProvider.commodities.append(imageData)
            imageData = ["Giáo dục","iconEduBright"]
            commoditiesDataProvider.commodities.append(imageData)
            imageData = ["Thể thao","iconSportsBright"]
            commoditiesDataProvider.commodities.append(imageData)
            imageData = ["Làm đẹp","iconMakeupBright"]
            commoditiesDataProvider.commodities.append(imageData)
            imageData = ["Phí hội nhóm","iconHoinhomBright"]
            commoditiesDataProvider.commodities.append(imageData)
            imageData = ["Nuôi trẻ nhỏ","iconBabyBright"]
            commoditiesDataProvider.commodities.append(imageData)
            imageData = ["Cha mẹ","iconFamilyBright"]
            commoditiesDataProvider.commodities.append(imageData)
            imageData = ["Người giúp việc","iconMaidBright"]
            commoditiesDataProvider.commodities.append(imageData)
            imageData = ["Ngân sách khác","iconPlusBright"]
            commoditiesDataProvider.commodities.append(imageData)
        }
        else {
            lblTitle.text! = "Thêm phong cách sống"
            var imageData = ["Đi du lịch","iconTravelBright"]
            commoditiesDataProvider.commodities.append(imageData)
            imageData = ["Từ thiện","iconCareBright"]
            commoditiesDataProvider.commodities.append(imageData)
            imageData = ["Cafe","iconCoffeeBright"]
            commoditiesDataProvider.commodities.append(imageData)
            imageData = ["Sưu tập","iconCollectBright"]
            commoditiesDataProvider.commodities.append(imageData)
            imageData = ["Trang trí","iconDecorationBright"]
            commoditiesDataProvider.commodities.append(imageData)
            imageData = ["Xem phim","iconFilmBright"]
            commoditiesDataProvider.commodities.append(imageData)
            imageData = ["Bảo hiểm","iconInsuranceBright"]
            commoditiesDataProvider.commodities.append(imageData)
            imageData = ["Nhà hàng","iconRestaurantBright"]
            commoditiesDataProvider.commodities.append(imageData)
            imageData = ["Ngân sách khác","iconPlusBright"]
            commoditiesDataProvider.commodities.append(imageData)
        }
        
        commoditiesCollection.reloadData()
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension CommoditiesViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return commoditiesDataProvider.commodities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = commoditiesCollection.dequeueReusableCell(withReuseIdentifier: "budgetCollectionCell",
                                                             for: indexPath) as! CustomCollectionViewCell
        cell.lblCommodity?.text = (commoditiesDataProvider.commodities[indexPath.row])[0]
        cell.imgCommodity?.image = UIImage(named: (commoditiesDataProvider.commodities[indexPath.row])[1])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selected = (commoditiesDataProvider.commodities[indexPath.row])[0]
        if addButtonTag == 1{
            previousVC?.commoditiesDataProvider?.dataForMiniTable1.append([selected,"0 vnd"])
        }
        else if addButtonTag == 2{
            previousVC?.commoditiesDataProvider?.dataForMiniTable2.append([selected,"0 vnd"])
        }
        else{
            previousVC?.commoditiesDataProvider?.dataForMiniTable3.append([selected,"0 vnd"])
        }
        self.dismiss(animated: true, completion: nil)
    }
}

extension CommoditiesViewController: UICollectionViewDelegateFlowLayout{
    // Resizing the cell
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //            let paddingSpace : CGFloat = 10.0
        //            let availableWidth = view.frame.width - paddingSpace
        //            //let availableWidth = commoditiesCollection.contentSize.width
        //            let availableHeight = commoditiesCollection.contentSize.height
        //            NSLog("width = \(availableWidth)")
        //            NSLog("height = \(availableHeight)")
        //            let widthPerItem = availableWidth/itemsPerRow
        //            let heightPerItem = availableHeight/itemsPerRow
        let widthPerItem = 120
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    // Returns the spacing between the cells, headers, and footers
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // Controls the spacing between each line in the layout, match the padding at the left and right.
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
