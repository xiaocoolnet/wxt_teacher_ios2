//
//  QingJiaViewController.swift
//  WXT_Teacher
//
//  Created by 李春波 on 16/3/10.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import IQKeyboardManagerSwift
import MJRefresh
class QingJiaViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var tableview = UITableView()
    var QingJiaSource = QingjiaModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "在线请假"
        self.view.backgroundColor = UIColor.whiteColor()
        tableview.frame=CGRectMake(0, 0, frame.width, frame.height-64)
        tableview.delegate=self
        tableview.dataSource=self
        tableview.separatorStyle = .None
        self.view.addSubview(tableview)
        self.tableview.mj_header = MJRefreshNormalHeader(refreshingBlock: { 
            self.loadData()
            self.tableview.mj_header.endRefreshing()
        })
        self.tableview.mj_header.beginRefreshing()
    }
    //MARK: -    获取数据
    func loadData(){
        
        //http://wxt.xiaocool.net/index.php?g=apps&m=teacher&a=getleavelist&teacherid=599
        
        //下面两句代码是从缓存中取出userid（入参）值
        let defalutid = NSUserDefaults.standardUserDefaults()
        
        let userid = defalutid.stringForKey("userid")
        
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=teacher&a=getleavelist"
        let param = [
            "teacherid":userid,
          
        ]
        Alamofire.request(.GET, url, parameters: param as?[String:String]).response { request, response, json, error in
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
                    self.QingJiaSource=QingjiaModel(status.data!)
                    self.tableview.reloadData()
                 
                }
            }
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return QingJiaSource.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let qingjiainfo = QingJiaSource.parentsExhortList[indexPath.row]
        
        let cell = UITableViewCell(style: .Default, reuseIdentifier: String(indexPath.row))
        let icon = UIImageView(frame: CGRectMake(10, 5, 50, 50))
        
        icon.image=UIImage(named: "4")
        icon.layer.masksToBounds=true
        icon.layer.cornerRadius=25
        cell.contentView.addSubview(icon)
        let nameL = UILabel(frame: CGRectMake(70,10,frame.width-100,20))
        nameL.text=qingjiainfo.studentname
        nameL.textColor=biaotiColor
        nameL.font=biaotifont
        cell.contentView.addSubview(nameL)
        let banjiL = UILabel(frame: CGRectMake(70,35,frame.width-100,20))
        banjiL.textColor=timeColor
        banjiL.text=qingjiainfo.classname
        banjiL.font=timefont
        cell.contentView.addSubview(banjiL)
        let contentL = UILabel(frame: CGRectMake(10,80,frame.width-20,20))
        contentL.text=qingjiainfo.reason
        contentL.textColor=neirongColor
        contentL.font=neirongfont
        let content_h = calculateHeight(contentL.text!, size: 17, width: frame.width-20)
        contentL.frame.size.height=content_h
        cell.contentView.addSubview(contentL)
        
    
       
        
        //判断图片张数显示
        var image_h = CGFloat()
        var pics = Array<String>()
        for item in qingjiainfo.pic {
            pics.append(item.pictureurl!)
        }
        let picView = NinePicView(frame:CGRectMake(0, contentL.frame.maxY + 10, frame.width,0),pic:pics,vc:self)
        cell.contentView.addSubview(picView)
        image_h = picView.image_h
  

        
       //MARK: -  下面的评论视图
        
        let senderL = UILabel(frame: CGRectMake(10,80+image_h+15+content_h,frame.width-50,20))
        if qingjiainfo.teachername != nil {
            senderL.text="受理人："+qingjiainfo.teachername!
        }
        senderL.font=timefont
        senderL.textColor=timeColor
        cell.contentView.addSubview(senderL)
        let timeL = UILabel(frame: CGRectMake(frame.width-150,80+image_h+15+content_h,140,20))
        timeL.textAlignment = .Right
        timeL.textColor=timeColor
        timeL.font=timefont
        timeL.text=changeTimeTwo(qingjiainfo.begintime!)+"到"+changeTimeTwo(qingjiainfo.endtime!)
        cell.contentView.addSubview(timeL)
        let textField = UITextField(frame: CGRectMake(10,90+image_h+40+content_h,frame.width-20,30))
        textField.placeholder="回复一下家长吧～"
        textField.layer.masksToBounds=true
        textField.layer.cornerRadius=4
        textField.tag=Int(qingjiainfo.id!)!
        textField.backgroundColor=UIColor.init(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        cell.contentView.addSubview(textField)
       
        
        
        var ht = CGFloat()
        
        
        if qingjiainfo.feedback != ""  {
            textField.hidden=true
            let pinglunView = UIView(frame: CGRectMake(5,90+image_h+40+content_h,frame.width-10,60))
            pinglunView.backgroundColor=UIColor.init(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
            pinglunView.layer.cornerRadius=5
            cell.contentView.addSubview(pinglunView)
            
            let icon=UIImageView(frame: CGRectMake(5, 5, 50, 50))
            icon.layer.masksToBounds=true
            icon.layer.cornerRadius=25
            
            icon.image=UIImage(named: "4")
            pinglunView.addSubview(icon)
            let nameL = UILabel(frame: CGRectMake(60,5,frame.width-70,20))
            let user = NSUserDefaults.standardUserDefaults()
            let username = user.stringForKey("username")
            nameL.text=username
            nameL.font=UIFont.systemFontOfSize(14)
            pinglunView.addSubview(nameL)
            let contentL = UILabel(frame: CGRectMake(60,30,frame.width-70,20))
            contentL.textColor=neirongColor
            contentL.lineBreakMode  = NSLineBreakMode.ByWordWrapping
            contentL.numberOfLines=0
            contentL.text=qingjiainfo.feedback
            contentL.font=UIFont.systemFontOfSize(14)
            let content_h = calculateHeight(contentL.text!, size: 14, width: frame.width-70)
            pinglunView.frame.size.height=40+content_h
            contentL.frame.size.height=content_h
            pinglunView.addSubview(contentL)
            
            ht=60
            tableview.rowHeight=90+image_h+40+content_h+90+30
            
        }else{
            ht=30
            tableview.rowHeight=90+image_h+40+content_h+90
        }
        let line = UIView(frame:CGRectMake(0,tableView.rowHeight-4,frame.width,4))
        line.backgroundColor=UIColor.init(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        cell.addSubview(line)

        
        let yesBT = UIButton(frame: CGRectMake(80,90+image_h+40+content_h+10+ht,60,30))
        yesBT.backgroundColor=UIColor.init(red: 253/255, green: 166/255, blue: 57/255, alpha: 1)
        yesBT.setTitle("不通过", forState: .Normal)
        yesBT.titleLabel?.font=UIFont.systemFontOfSize(15)
        yesBT.layer.cornerRadius=5
        
        yesBT.tag=Int(qingjiainfo.id!)!
        yesBT.addTarget(self, action: #selector(nopass(_:)), forControlEvents: .TouchUpInside)
        cell.contentView.addSubview(yesBT)
        let noBT = UIButton(frame: CGRectMake(frame.width-140,90+image_h+40+content_h+40,60,30))
        noBT.backgroundColor=UIColor.init(red: 157/255, green: 203/255, blue: 107/255, alpha: 1)
        noBT.setTitle("批准", forState: .Normal)
        noBT.titleLabel?.font=UIFont.systemFontOfSize(15)
        noBT.layer.cornerRadius=5
        noBT.tag=Int(qingjiainfo.id!)!
        noBT.addTarget(self, action: #selector(pass(_:)), forControlEvents: .TouchUpInside)
        cell.contentView.addSubview(noBT)
        switch qingjiainfo.status! {
        case "1":
            yesBT.userInteractionEnabled=false
            yesBT.backgroundColor=UIColor.grayColor()
            noBT.hidden=true
            yesBT.setTitle("已批准", forState: .Normal)
        case "2":
            yesBT.userInteractionEnabled=false
            noBT.hidden=true
            yesBT.backgroundColor=UIColor.grayColor()
            yesBT.setTitle("已拒绝", forState: .Normal)
        default:
            break
        }
        
        cell.selectionStyle = .None
        return cell
    }
    //MARK: - 不通过的方法
    func nopass(sender:UIButton){
        let textfield = self.view.viewWithTag(sender.tag) as? UITextField
        let content = textfield?.text
        Getdata(String(sender.tag), status: "2", content: content!)
        textfield?.text=""
        sender.setTitle("已拒绝", forState: .Normal)
        sender.userInteractionEnabled=false
 
    }
    //MARK: - 通过的方法
    func pass(sender:UIButton){
        let textfield = self.view.viewWithTag(sender.tag) as? UITextField
        let content = textfield?.text
        Getdata(String(sender.tag), status: "1", content: content!)
        textfield?.text=""
        sender.setTitle("已批准", forState: .Normal)
        sender.userInteractionEnabled=false

    }
    //MARK: - 回复接口
    func Getdata(id:String,status:String,content:String){
    
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=teacher&a=replyleave"
        let userid = NSUserDefaults.standardUserDefaults()
        let uid = userid.stringForKey("userid")
        
        let param = [
            
            "leaveid":id,
            "teacherid":uid,
            "feedback":content,
            "status":status
            
        ]
        print(url)
        Alamofire.request(.GET, url, parameters: param as? [String : String]).response { request, response, json, error in
            if(error != nil){
            }
            else{
                print("request是")
                print(request!)
                print("====================")
                let status = Httpresult(JSONDecoder(json!))
                print(JSONDecoder(json!))
                print("状态是")
                print(status.status)
                if(status.status == "error"){
                    let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    hud.mode = MBProgressHUDMode.Text;
                    hud.labelText = status.errorData
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 3)
                }
                if(status.status == "success"){
                    print("成功")
                    self.tableview.reloadData()
                }
            }
        }

    }
    //MARK: - 视图将要出现／消失
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=true
    }
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=false
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
