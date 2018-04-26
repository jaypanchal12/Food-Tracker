//
//  DrawerView.swift
//  NavigationDrawer
//


import UIKit

// Delegate protocolo for parsing viewcontroller to push the selected viewcontroller
protocol DrawerControllerDelegate: class {
    func pushTo(viewController : UIViewController)
    func pushModalTo(viewController : UIViewController)

}

class DrawerView: UIView, drawerProtocolNew, UITableViewDelegate, UITableViewDataSource {

    public let screenSize = UIScreen.main.bounds
    var backgroundView = UIView()
    var drawerView = UIView()
    
    var tblVw = UITableView()
    var aryViewControllers = NSArray()
    weak var delegate:DrawerControllerDelegate?
    var currentViewController = UIViewController()
    var cellTextColor:UIColor?
    var userNameTextColor:UIColor?
    //var btnChangeCountry = UIButton()
    var vwForHeader = UIView()
    var vwContryView = UIView()

    var lblunderLine = UILabel()
    var imgBg : UIImage?
    var fontNew : UIFont?

    //fileprivate var imgProPic = UIImageView()
    fileprivate let imgBG = UIImageView()
   // fileprivate var lblUserName = UILabel()
    fileprivate var gradientLayer: CAGradientLayer!

    convenience init(aryControllers: NSArray, isBlurEffect:Bool, isHeaderInTop:Bool, controller:UIViewController) {
        self.init(frame: UIScreen.main.bounds)
        self.tblVw.register(UINib.init(nibName: "DrawerCell", bundle: nil), forCellReuseIdentifier: "DrawerCell")
        self.initialise(controllers: aryControllers, isBlurEffect: isBlurEffect, isHeaderInTop: isHeaderInTop, controller:controller)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        UIApplication.shared.statusBarStyle = .lightContent

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // To change the profile picture of account
//    func changeProfilePic(img:UIImage) {
//        imgProPic.image = img
//        imgBG.image = img
//        imgBg = img
//    }
    
    // To change the user name of account
//    func changeUserName(name:String) {
//        lblUserName.text = name
//    }
    
    // To change the background color of background view
    func changeGradientColor(colorTop:UIColor, colorBottom:UIColor) {
        gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        self.drawerView.layer.insertSublayer(gradientLayer, at: 0)
       // self.drawerView.backgroundColor=UIColor.white

    }
    
    // To change the tableview cell text color
    func changeCellTextColor(txtColor:UIColor) {
        self.cellTextColor = txtColor
       // btnChangeCountry.setTitleColor(txtColor, for: .normal)
        lblunderLine.backgroundColor = txtColor.withAlphaComponent(0.6)
        self.tblVw.reloadData()
    }
    
    // To change the user name label text color
//    func changeUserNameTextColor(txtColor:UIColor) {
//        lblUserName.textColor = txtColor
//    }
    
    // To change the font for table view cell label text
    func changeFont(font:UIFont) {
        fontNew = font
        self.tblVw.reloadData()
    }

    func initialise(controllers:NSArray, isBlurEffect:Bool, isHeaderInTop:Bool, controller:UIViewController) {
        currentViewController = controller
        currentViewController.tabBarController?.tabBar.isHidden = true
        
        backgroundView.frame = frame
        drawerView.backgroundColor = UIColor.clear
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0.2

        // Initialize the tap gesture to hide the drawer.
        let tap = UITapGestureRecognizer(target: self, action: #selector(DrawerView.actDissmiss))
        backgroundView.addGestureRecognizer(tap)
        addSubview(backgroundView)
        
        drawerView.frame = CGRect(x:0, y:0, width:screenSize.width/2+110, height:screenSize.height)
        drawerView.clipsToBounds = true

        // Initialize the gradient color for background view
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = drawerView.bounds
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.darkGray.cgColor]

        imgBG.frame = drawerView.frame
        imgBG.image = imgBg ?? #imageLiteral(resourceName: "MyAccount")
        
        // Initialize the blur effect upon the image view for background view
        let darkBlur = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = drawerView.bounds
        imgBG.addSubview(blurView)
        
        // Check wether need the blur effect or not
        if isBlurEffect == true {
            self.drawerView.addSubview(imgBG)
        }else{
           // self.drawerView.layer.insertSublayer(gradientLayer, at: 0)
           // self.drawerView.backgroundColor=UIColor.white
        }
        
        // This is for adjusting the header frame to set header either top (isHeaderInTop:true) or bottom (isHeaderInTop:false)
        self.allocateLayout(controllers:controllers, isHeaderInTop: isHeaderInTop)
    }
    
    func allocateLayout(controllers:NSArray, isHeaderInTop:Bool) {
        
        if isHeaderInTop {
//            vwForHeader = UIView(frame:CGRect(x:0, y:20, width:drawerView.frame.size.width, height:150))
//            self.lblunderLine = UILabel(frame:CGRect(x:vwForHeader.frame.origin.x+10, y:vwForHeader.frame.size.height - 1 , width:vwForHeader.frame.size.width-20, height:1.0))
            
            var nibViews = Bundle.main.loadNibNamed("tableHeader", owner: self, options: nil)
            let myView = nibViews?[1] as? UIView
            myView?.frame = CGRect(x:0, y:0, width:drawerView.frame.size.width, height:180)
            vwForHeader = myView!
            
         //   tblVw.frame = CGRect(x:0, y:vwForHeader.frame.origin.y+vwForHeader.frame.size.height, width:screenSize.width/2+75, height:screenSize.height-100)
            
            tblVw.frame=CGRect(x:0,y:vwForHeader.frame.height,width:screenSize.width/2+110, height:screenSize.height)
            
            


        }else{
            tblVw.frame = CGRect(x:0, y:20, width:screenSize.width/2+75, height:screenSize.height-100)
            vwForHeader = UIView(frame:CGRect(x:0, y:tblVw.frame.origin.y+tblVw.frame.size.height, width:drawerView.frame.size.width, height:screenSize.height - tblVw.frame.size.height))
            lblunderLine.frame = CGRect(x:10, y:0, width:vwForHeader.frame.size.width-20, height:1)
        }
        
        tblVw.separatorStyle = UITableViewCellSeparatorStyle.none
        aryViewControllers = controllers
        tblVw.delegate = self
        tblVw.dataSource = self
        tblVw.backgroundColor = UIColor.white
        drawerView.addSubview(tblVw)
        tblVw.reloadData()

        lblunderLine.backgroundColor = UIColor.groupTableViewBackground
        vwForHeader.addSubview(lblunderLine)
        
//        btnChangeCountry = UIButton(frame:CGRect(x:20, y:14, width:vwForHeader.frame.size.width/2+30, height:25))
//        btnChangeCountry.setTitle("Change", for: .normal)
//        btnChangeCountry.contentHorizontalAlignment = .left
//        btnChangeCountry.addTarget(self, action: #selector(changeCountry), for: .touchUpInside)
//        btnChangeCountry.titleLabel?.font = fontNew ?? UIFont(name: "Euphemia UCAS", size: 15)
//        btnChangeCountry.setTitleColor(UIColor.white, for: .normal)
//        vwForHeader.addSubview(btnChangeCountry)
        
//        imgProPic = UIImageView(frame:CGRect(x:vwForHeader.frame.size.width-70, y:btnChangeCountry.frame.origin.y-5, width:60, height:60))
//        imgProPic.image = imgBg ?? #imageLiteral(resourceName: "tabTwo")
//        imgProPic.layer.cornerRadius = imgProPic.frame.size.height/2
//        imgProPic.layer.masksToBounds = true
//        imgProPic.contentMode = .scaleAspectFit
//        vwForHeader.addSubview(imgProPic)
        
//        lblUserName = UILabel(frame:CGRect(x:btnChangeCountry.frame.origin.x, y:btnChangeCountry.frame.origin.y+btnChangeCountry.frame.size.height-5, width:btnChangeCountry.frame.size.width, height:25))
//        lblUserName.text = "No Name"
//        lblUserName.font = UIFont(name: "Euphemia UCAS", size: 11)
//        lblUserName.textAlignment = .left
//        lblUserName.textColor = UIColor.lightText
//        vwForHeader.addSubview(lblUserName)

        drawerView.addSubview(vwForHeader)
        addSubview(drawerView)
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "HELP AND SUPPORT"
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//       return 50.0
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //let head=HeaderFooterView()
        var nibViews = Bundle.main.loadNibNamed("View", owner: self, options: nil)
        let myView = nibViews?[0] as? HeaderFooterView
        myView?.frame = CGRect(x:0, y:0, width:tblVw.frame.width, height:80)
        myView?.hearderLbl.text="HELP AND SUPPORT"
        //myView?.hearderLbl.textColor=UIColor.black
        myView?.backgroundColor = UIColor.white
        
        return myView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aryViewControllers.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 63
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DrawerCell") as! DrawerCell
        cell.backgroundColor = UIColor.clear
        cell.lblController?.text = aryViewControllers[indexPath.row] as? String
        cell.imgController?.image = UIImage(named: "Language")
        cell.lblController.textColor = self.cellTextColor ?? UIColor.black
        cell.lblController.font = fontNew ?? UIFont(name: "Euphemia UCAS", size: 18)
        cell.selectionStyle = UITableViewCellSelectionStyle.none

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        actDissmiss()
        let storyBoard = UIStoryboard(name:"Main", bundle:nil)
        let controllerName = (storyBoard.instantiateViewController(withIdentifier: aryViewControllers[indexPath.row] as! String))
        controllerName.hidesBottomBarWhenPushed = true
        self.delegate?.pushTo(viewController: controllerName)
    }

    // To dissmiss the current view controller tab bar along with navigation drawer
    @objc func actDissmiss() {
        currentViewController.tabBarController?.tabBar.isHidden = true
        self.dissmiss()
    }
    
    // Action for logout to quit the application.
    @objc func changeCountry() {
        exit(0)
    }
    
    @IBAction func goToLogin(_ sender: Any) {
        actDissmiss()
        let login = LoginViewController()
        login.modalPresentationStyle = .overCurrentContext
        login.modalTransitionStyle = .coverVertical
       // present(login, animated: true, completion: nil)

        login.hidesBottomBarWhenPushed = true

        self.delegate?.pushModalTo(viewController: login)
        
        
        
        

    }
    
    
}


