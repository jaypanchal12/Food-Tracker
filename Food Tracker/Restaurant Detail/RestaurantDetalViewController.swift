//
//  RestaurantDetalViewController.swift
//  Food Tracker
//
//  Created by KWTMAC01 on 11/13/17.
//  Copyright © 2017 KWTMAC01. All rights reserved.
//

import UIKit
import ParallaxHeader
import EMAccordionTableViewController


class RestaurantDetalViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    weak var parallaxHeaderView: UIView?
    weak var tableHeaderVC: UIView?


    @IBOutlet weak var detailTabvle: UIExpandableTableView!
    @IBOutlet weak var rImageView: UIImageView!
    
    var items:[[String]] = [["Chocolate Mosse Crepe", "Cookies Crepe","Banana Wrap Crepe","Digestive Crepe","Mighty Crepe","Browny Crepe"], ["Chocolate Mosse Crepe", "Cookies Crepe","Banana Wrap Crepe","Digestive Crepe","Mighty Crepe","Browny Crepe"],["Chocolate Mosse Crepe", "Cookies Crepe","Banana Wrap Crepe","Digestive Crepe","Mighty Crepe","Browny Crepe"],["Chocolate Mosse Crepe", "Cookies Crepe","Banana Wrap Crepe","Digestive Crepe","Mighty Crepe","Browny Crepe"],["Chocolate Mosse Crepe", "Cookies Crepe","Banana Wrap Crepe","Digestive Crepe","Mighty Crepe","Browny Crepe"],["Chocolate Mosse Crepe", "Cookies Crepe","Banana Wrap Crepe","Digestive Crepe","Mighty Crepe","Browny Crepe"],["Chocolate Mosse Crepe", "Cookies Crepe","Banana Wrap Crepe","Digestive Crepe","Mighty Crepe","Browny Crepe"],["Chocolate Mosse Crepe", "Cookies Crepe","Banana Wrap Crepe","Digestive Crepe","Mighty Crepe","Browny Crepe"],["Chocolate Mosse Crepe", "Cookies Crepe","Banana Wrap Crepe","Digestive Crepe","Mighty Crepe","Browny Crepe"]]
    var sectionArray=["CREPES","FAMILY DISHES","WAFFLES","CHOCOLATE","ICE CREAM","SIDES","FROZEN BLENDED","SODA & WATER","HOT DRINKS"]

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupParallaxHeader()


    }
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        self.automaticallyAdjustsScrollViewInsets=false
       // self.detailTabvle.scrollView.contentInsetAdjustmentBehavior = .automatic
        self.detailTabvle.isScrollEnabled=true

    }

    private func setupParallaxHeader() {
        self.tableHeaderVC = (Bundle.main.loadNibNamed("headView", owner: self, options: nil)?.last as? UIView)!
        
        parallaxHeaderView = self.tableHeaderVC
        tableHeaderVC?.frame = CGRect(x: 0.0, y: 0.0, width:UIScreen.main.bounds.width, height: 200.0)

        detailTabvle.parallaxHeader.view = self.tableHeaderVC!
        detailTabvle.parallaxHeader.height=200
        detailTabvle.parallaxHeader.minimumHeight = 200

    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
     @IBAction func goB(_ sender: Any) {
     }
     */
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (!items.isEmpty) {
            if (self.detailTabvle.sectionOpen != NSNotFound && section == self.detailTabvle.sectionOpen) {
                return items[section].count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        cell.textLabel?.text = items[indexPath.section][indexPath.row]
        cell.textLabel?.backgroundColor = UIColor.clear
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70.0
        
    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let a="this is section"
//        return a
//    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderView(tableView: self.detailTabvle, section: section)
        headerView.backgroundColor = UIColor.white
       // let a = sectionArray[section]
        
        let label = UILabel(frame: headerView.frame)
        label.text = sectionArray[section]
        label.text="abc"
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.textColor = UIColor(red:0.0/255.0,green:0.0/255.0,blue:0.0/255.0,alpha:0.8)
        
        headerView.addSubview(label)
        
        
        //headerView.layer.zPosition = 1
       // headerView.clipsToBounds=true
        
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    
    
    
    
    
    
    
    
    

}
