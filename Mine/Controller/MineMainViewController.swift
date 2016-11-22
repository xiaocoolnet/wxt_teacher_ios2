//
//  MineMainViewController.swift
//  WXT_Teachers
//
//  Created by 李春波 on 16/2/25.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class MineMainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let mineTableView = UITableView()
    let exitBtn = UIButton()
    let avatorImage = UIImageView()
    let nameLabel = UILabel()
    let infoLabel = UILabel()
    let editBtn = UIButton()
    let jifenLabel = UILabel()
    let duiHuanBtn = UIButton()
    let qingchuHuancun = UIButton()
    let footview = UIView()
    let phoneBtn = UIButton()
    var ServiceBtn = UIButton()
    var servicePhone = ""
    
    let vip = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的"
        GetService()
        mineTableView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height - 44 - 64)
        mineTableView.delegate = self
        mineTableView.dataSource = self
        mineTableView.registerClass(MineTableViewCell.self, forCellReuseIdentifier: "MineCell")
        let button1 = UIButton(frame:CGRectMake(0, 0, 40, 20))
        button1.setTitle("设置", forState: .Normal)
       button1.addTarget(self,action:#selector(setup),forControlEvents:.TouchUpInside)
        let barButton1 = UIBarButtonItem(customView: button1)
        self.navigationItem.rightBarButtonItem=barButton1
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(mineTableView)
        //获取在线客服电话
        getOnlinePhone()
    }
    func getOnlinePhone(){
        let defalutid = NSUserDefaults.standardUserDefaults()
        let chid = defalutid.stringForKey("schoolid")
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=index&a=service_phone"
        let param = [
            "schoolid":chid!,
            ]
        Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in
            if(error != nil){
            }
            else{
                print("request是")
                print(request!)
                print("====================")
                let status = Http(JSONDecoder(json!))
                print("状态是")
                print(status.status)
                if(status.status == "error"){
                    let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    hud.mode = MBProgressHUDMode.Text
                    hud.labelText = status.errorData
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 1)
                }
                if(status.status == "success"){
                    //  self.messageSource = sendMessageList(status.data!)
                   self.servicePhone = ChooseTeacherInfo(status.data!).phone!
                    self.mineTableView.reloadData()
                }
            }
        }

    }
    //MARK: - 跳转设置
    func setup(){
        let vc = SetUpViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
    }
    //MARK: - 返回多少组
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    //MARK: - 返回多少行
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 1
        }else{
            return 5
        }
        
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    //行高
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.section == 0){
            
                return 166
            
            
        }else{
            return 44
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let useDefaults = NSUserDefaults.standardUserDefaults()
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "userInfoCell")
        cell.selectionStyle = .None
        cell.accessoryType = .DisclosureIndicator
        let lable = UILabel(frame: CGRectMake(frame.width-200,10,170,20))
        lable.textAlignment = .Right
        lable.textColor=UIColor.grayColor()
        lable.font=UIFont.systemFontOfSize(14)
        
        
        if(indexPath.section == 0){
            if(indexPath.row == 0){
              
                cell.backgroundColor=UIColor(red: 155.0 / 255.0, green: 229.0 / 255.0, blue: 180.0 / 255.0, alpha: 1.0)
                self.avatorImage.frame = CGRectMake(10, 62, 80, 80)
                self.avatorImage.layer.cornerRadius = 40
                self.avatorImage.layer.masksToBounds = true
                let photo = useDefaults.stringForKey("photo")
                let url = imageUrl+photo!
                avatorImage.yy_setImageWithURL(NSURL(string: url), placeholder: UIImage(named: "Logo"))
                let bt = UIButton(frame: CGRectMake(10, 62, 80, 80))
                bt.addTarget(self, action: #selector(changeInfo), forControlEvents: .TouchUpInside)
                
                self.nameLabel.frame = CGRectMake(104, 80, frame.width-120, 16)
                self.nameLabel.font = UIFont.systemFontOfSize(16)
                self.nameLabel.textColor = UIColor.whiteColor()
                
                let username = useDefaults.valueForKey("username") as! String
                
                self.nameLabel.text = username
                self.infoLabel.frame = CGRectMake(105, 115, 110, 11)
                self.infoLabel.font = UIFont.systemFontOfSize(11)
                self.infoLabel.textColor = UIColor.whiteColor()
                self.infoLabel.text = String(vip)
                
                cell.contentView.addSubview(self.avatorImage)
                cell.contentView.addSubview(self.nameLabel)
                cell.contentView.addSubview(self.infoLabel)
                cell.contentView.addSubview(bt)

                
            }}else {
                 if indexPath.row==0{
                    cell.textLabel?.text="扫一扫打卡"
                }else if indexPath.row==1{
                    cell.textLabel?.text="维护人员"
                    ServiceBtn.frame=CGRectMake(frame.width-200,10,170,20)
                    cell.contentView.addSubview(ServiceBtn)
                    let phoneLabl = UILabel(frame: CGRectMake(100,0,WIDTH-150,cell.frame.height))
                    phoneLabl.textColor = timeColor
                    phoneLabl.font = neirongfont
                    phoneLabl.text = self.servicePhone
                    phoneLabl.textAlignment = .Right
                    cell.contentView.addSubview(phoneLabl)
                    
                }else if indexPath.row==2{
                    cell.textLabel?.text="在线留言"
                }else if indexPath.row==3{
                    cell.textLabel?.text="系统通知"
                }else if indexPath.row==4{
                    cell.textLabel?.text="客户端二维码名片"
                }
                
            }

        return cell
    }
    func changeInfo(){
        let vc = PersonInformation()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section==0 {
            self.changeInfo()
        }else{
        if indexPath.row==0{
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "暂无功能"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)

        }else if indexPath.row==1{
            let url = NSURL(string: "tel://"+self.servicePhone)
            if self.servicePhone != "" {
                UIApplication.sharedApplication().openURL(url!)
            }

        }else if indexPath.row==2{
            let vc = QOnlineHelpVC()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else if indexPath.row==3{
            let vc = QCSystemInformsVC()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else if indexPath.row==4{
            let vc = ErWeiMaViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }

        }}
    
    
    func ExitLogin(){
        let alertController = UIAlertController(title: NSLocalizedString("", comment: "Warn"), message: NSLocalizedString("确认注销？", comment: "empty message"), preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        let doneAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            let userid = NSUserDefaults.standardUserDefaults()
            userid.setValue("", forKey: "userid")
            let defalutid = NSUserDefaults.standardUserDefaults()
            defalutid.setValue("", forKey: "cid")
            let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("LoginView") as! UINavigationController
            self.presentViewController(vc, animated: true, completion: nil)
        }
        alertController.addAction(doneAction)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    func GetService(){
    let defalutid = NSUserDefaults.standardUserDefaults()
    let cid = defalutid.stringForKey("schoolid")
    let url = "http://wxt.xiaocool.net/index.php?g=apps&m=index&a=service_phone"
    let param = [
    "schoolid":cid!
    ]
    Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in
    if(error != nil){
    }
    else{
    print("request是")
    print(request!)
    print("====================")
    let status = ServiceModel(JSONDecoder(json!))
    print("状态是")
    print(status.status)
    if(status.status == "error"){
    let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
    hud.mode = MBProgressHUDMode.Text;
    hud.labelText = status.errorData
    hud.margin = 10.0
    hud.removeFromSuperViewOnHide = true
    hud.hide(true, afterDelay: 1)
    }
    
    if(status.status == "success"){
    //                    self.ServiceBtn.titleLabel?.text = status.data?.phone!
    self.ServiceBtn.setTitle(status.data?.phone!, forState: .Normal)
        self.ServiceBtn.setTitleColor(greenColor, forState: .Normal)
        self.ServiceBtn.tag=Int((status.data?.phone)!)!
        self.ServiceBtn.addTarget(self, action: #selector(self.callphone(_:)), forControlEvents: .TouchUpInside)
    }
    }
    
    }
    
    }
    func callphone(sender:UIButton){
        if sender.tag == 0 {
            
        }else{
            let alertController=UIAlertController(title: "", message: "呼叫\(sender.tag)", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "确定", style: .Default,
                                         handler: {
                                            action in
                                            UIApplication.sharedApplication().openURL(NSURL(string :"tel://\(sender.tag)")!)
                                            
                                            
            })
            let cancelAction = UIAlertAction(title: "取消", style: .Default, handler: nil)
            alertController.addAction(cancelAction)
            
            alertController.addAction(okAction)
            
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
  
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
