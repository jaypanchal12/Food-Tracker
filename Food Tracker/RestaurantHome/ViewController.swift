//
//  ViewController.swift
//  Food Tracker
//
//  Created by KWTMAC01 on 11/7/17.
//  Copyright © 2017 KWTMAC01. All rights reserved.
//

import UIKit
import TTGTagCollectionView

struct DrawerArray {
    static let array:NSArray = ["Orders", "Change Language","FAQs", "Customer Care ", "About"]
    
    
}

class ViewController: UIViewController , DrawerControllerDelegate,UITableViewDelegate,UITableViewDataSource,TTGTextTagCollectionViewDelegate {
    @IBOutlet weak var textCollectionView1: TTGTextTagCollectionView!
    
    @IBOutlet weak var clearAllOutlet: DesignableButton!
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var restaurantTable: UITableView!
    @IBOutlet weak var tableTopSpace: NSLayoutConstraint?
    @IBOutlet weak var filterVw: UIView?
    var indexArray = [UInt]()
    var vc = UIView()
    //var tags:[UIView] = []
    var tags:[String] = ["American","Arabic","Arabic","Bakery","Breakfast","Chinese","Coffee","Crepes","Dessert","Healthy Food","Indian","Internartional","Iranian","Italian","Japanese","Korean","Kuwaiti","Lebanese","Pizza","Sandwiches","Seafood","Ice-Cream"]

    
    
    

    
    var aar=[[String:String]]()
    var i=0

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aar.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell=tableView.dequeueReusableCell(withIdentifier: "Cell") as? RestaurantCell
        Cell?.restaurantTitle?.text=aar[indexPath.row]["name"]
        Cell?.restaurantSubTitle?.text=aar[indexPath.row]["detail"]
        Cell?.preparationTime?.text=aar[indexPath.row]["time"]

        
        let img:UIImage=UIImage(named:aar[indexPath.row]["image"]!)!
        
        Cell?.restaurantImage.image = img
       // Cell?.restaurantImage.image=UIImageView(ima)
        
        

        return Cell!
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 220.0
    }
    
    
    
    var backgroundView: UIView?
    
    var drawerView: UIView?
    

    var drawerVw = DrawerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aar=[["name":"International Mill ",
                   "detail":"mill",
                   "image":"restaurant_one",
                   "time":"40 Mins"],
                  ["name":"Marble Slab Creamery",
                   "detail":"The finest ice cream on the planet",
                   "image":"restaurant_two",
                   "time":"20 Mins"],
                  ["name":"32 Burger",
                   "detail":"Freshly made using the finest ingredients",
                   "image":"restaurant_three",
                   "time":"50 Mins"],
                  ["name":"Nuts and More",
                   "detail":"Damlouj",
                   "image":"restaurant_four",
                   "time":"60 Mins"],
                  ["name":"MANZO",
                   "detail":"You are about to eat",
                   "image":"restaurant_five",
                   "time":"60 Mins"]
                  
        ]

        self.navigationController?.navigationBar.isTranslucent = false
        
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden=false

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func pushTo(viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func pushModalTo(viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
        
    }
    
    @IBAction func actShowMenu(_ sender: Any) {
        drawerVw = DrawerView(aryControllers:DrawerArray.array, isBlurEffect:false, isHeaderInTop:true, controller:self)
        drawerVw.delegate = self
        
        drawerVw.changeGradientColor(colorTop: UIColor(red:0.788, green: 0.078, blue: 0.435, alpha: 1.00), colorBottom: UIColor(red:0.929, green: 0.204, blue: 0.165, alpha: 1.00))
        
        drawerVw.changeCellTextColor(txtColor: UIColor.black)
        drawerVw.changeFont(font:UIFont(name:"Optima", size:18)!)
        drawerVw.show()
        
        

    }
    
    @IBAction func goTOLogin(_ sender: Any) {
        let login = LoginViewController()
        login.modalPresentationStyle = .fullScreen
        login.modalTransitionStyle = .coverVertical
        present(login, animated: true, completion: nil)
    }
    
    @IBAction func filter(_ sender: Any) {
        vc.backgroundColor=UIColor.blue
        if (i==0) {
            i=1
            
        self.filterVw = (Bundle.main.loadNibNamed("FilterView", owner: self, options: nil)?.last as? UIView)!
            
            
            self.filterVw?.frame = CGRect(x: 0, y: 59.0, width: UIScreen.main.bounds.width, height: 0)
            self.view .addSubview(self.filterVw!)
            self.filterVw?.clipsToBounds=true
            self.view .layoutIfNeeded()

            textCollectionView1.delegate=self
            collectionConfig()

            UIView.animate(withDuration: 0.4, delay: 0.0, options: [.curveEaseInOut], animations: {
            self.filterVw?.frame = CGRect(x: 0, y: 59.0, width: UIScreen.main.bounds.width, height: 295.0)
            self.tableTopSpace?.constant = 295.0
            self.view .layoutIfNeeded()

            })
                { (finished) in
                    if finished {
                }
            }
        }
        else
        {
            i=0
                UIView.animate(withDuration: 0.4, delay: 0.0, options: [.curveEaseInOut], animations: {
                    self.filterVw?.frame = CGRect(x: 0, y: 59.0, width: UIScreen.main.bounds.width, height: 0.0)
                self.tableTopSpace?.constant = 0
                self.view .layoutIfNeeded()

            })
                { (finished) in
                    if finished {
                        self.filterVw?.removeFromSuperview()
                        self.view .layoutIfNeeded()
                    }
                }
            }
}
    
    
    func collectionConfig() -> Void {
        textCollectionView1.horizontalSpacing=CGFloat(20.0)
        textCollectionView1.verticalSpacing=CGFloat(20.0)
        textCollectionView1.contentInset=UIEdgeInsetsMake(10, 5, 5, 10)
        
        textCollectionView1.showsVerticalScrollIndicator = true;
        let config:TTGTextTagConfig?=textCollectionView1.defaultConfig
        config?.tagTextFont = UIFont.systemFont(ofSize: 18.0)
        config?.tagTextColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.80)
        config?.tagSelectedTextColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.00)
        config?.tagBackgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.00)
        config?.tagSelectedBackgroundColor = UIColor(red: 207.0/255.0, green: 92.0/255.0, blue: 70.0/255.0, alpha: 1.00)
        config?.tagBorderColor = UIColor(red: 185.0/255.0, green: 184.0/255.0, blue: 185.0/255.0, alpha: 0.30)
        config?.tagSelectedBorderColor = UIColor(red: 0.18, green: 0.19, blue: 0.22, alpha: 1.00)
        config?.tagBorderWidth = 1
        config?.tagSelectedBorderWidth = 0
        config?.tagCornerRadius = 16
        config?.tagSelectedCornerRadius=16
        config?.tagExtraSpace = CGSize(width:28,height:15)
        config?.tagShadowRadius=0.0
        config?.tagShadowColor=UIColor.clear
        textCollectionView1.addTags(tags)
        textCollectionView1.alignment = .center
        textCollectionView1.reload()
        self.textCollectionView1.delegate=self


    }
    


    @IBAction func ClearFilter(_ sender: Any) {
        for i in indexArray {
            textCollectionView1.setTagAt(i, selected: false)
            clearAllOutlet.isHidden=true
        }
    }
    
    
    func textTagCollectionView(_ textTagCollectionView: TTGTextTagCollectionView!, didTapTag tagText: String!, at index: UInt, selected: Bool) {
        print("tap tag: \(tagText), at:\(Int(index)), selected: \(selected)")
        indexArray.append(index)
        clearAllOutlet.isHidden=false


    }


    
}


