//
//  PhotoViewController.swift
//  WXT_Teacher
//
//  Created by 李春波 on 16/3/9.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import XWSwiftRefresh
class PhotoViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,SYKeyboardTextFieldDelegate{
    
    var tableview = UITableView()
    var frame = UIScreen.mainScreen().bounds.size
    var keyboardTextField : SYKeyboardTextField!
    var PhotoSource = PhotoModel()
    var beginid = "0"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "班级相册"
        loadData()
        self.view.backgroundColor = UIColor.whiteColor()
        self.tabBarController?.tabBar.hidden = true
        tableview.frame=CGRectMake(0, 0, WIDTH , HEIGHT)
        tableview.delegate=self
        tableview.dataSource=self
        tableview.separatorStyle = .None
        let rightItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(PhotoViewController.NewPhoto))
        self.navigationItem.rightBarButtonItem = rightItem
        self.view.addSubview(tableview)
        //评论弹出view
        loadCommentKeyBoardView()
        
        self.tableview.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableview.headerView = XWRefreshNormalHeader(target: self, action: #selector(self.DropDownUpdate))
        let footer = XWRefreshAutoNormalFooter(target: self, action: #selector(PhotoViewController.footerReresh))
        self.tableview.footerView = footer
        print(footer)
        self.tableview.headerView?.beginRefreshing()
    }
    
    func loadCommentKeyBoardView(){
        keyboardTextField = SYKeyboardTextField(point: CGPointMake(0, 0), width: self.view.width)
        keyboardTextField.keyboardView.backgroundColor = RGBA(237.0, g: 237.0, b: 237.0, a: 1.0)
        keyboardTextField.textView.backgroundColor = UIColor.whiteColor()
        keyboardTextField.textView.cornerRadius = 18
        keyboardTextField.textView.layer.masksToBounds = true
        keyboardTextField.placeholderLabel.text = "评论:"
        keyboardTextField.delegate = self
        keyboardTextField.leftButtonHidden = true
        keyboardTextField.rightButtonHidden = false
        keyboardTextField.rightButton.setTitle("发送", forState: UIControlState.Normal)
        keyboardTextField.rightButton.backgroundColor = UIColor.whiteColor()
        keyboardTextField.rightButton.setTitleColor(themeColor, forState: UIControlState.Normal)
        keyboardTextField.rightButton.cornerRadius = 8
        keyboardTextField.rightButton.layer.masksToBounds = true
        keyboardTextField.rightButton.addTarget(self, action: #selector(self.send(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        keyboardTextField.autoresizingMask = [UIViewAutoresizing.FlexibleWidth , UIViewAutoresizing.FlexibleTopMargin]
        self.view.addSubview(keyboardTextField)
        keyboardTextField.toFullyBottom()
        keyboardTextField.hidden = true
    }
    //    开始刷新
    func DropDownUpdate(){
        self.beginid = "0"
        self.loadData()
       
    }

    func footerReresh(){
        self.beginid = "\(self.PhotoSource.count)"
        self.loadData()
  
    }
    //MARK: -    获取数据
    func loadData(){
        
        //http://wxt.xiaocool.net/index.php?g=apps&m=index&a=GetMicroblog&schoolid=1&classid=1

        //下面两句代码是从缓存中取出userid（入参）值
        let defalutid = NSUserDefaults.standardUserDefaults()
        let classid = defalutid.stringForKey("classid")
        let schoolid = defalutid.stringForKey("schoolid")
        let userid = defalutid.stringForKey("userid")
        
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=index&a=GetMicroblog"
        let param = [
            "userid":userid,
            "classid":classid,
            "schoolid":schoolid,
            "type":"2",
            "beginid":beginid
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
                    self.PhotoSource=PhotoModel(status.data!)
                    self.tableview.reloadSections(NSIndexSet (index: 0), withRowAnimation: UITableViewRowAnimation.None)
//                    self.keyboardTextField.hide()
                    self.tableview.headerView?.endRefreshing()
                    self.tableview.footerView?.endRefreshing()
                }
            }
        }
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return PhotoSource.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let photoinfo = PhotoSource.parentsExhortList[indexPath.row]
        
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        let titleL = UILabel()
        titleL.frame=CGRectMake(10,5,frame.width-20,20)
        cell.addSubview(titleL)
        titleL.text=photoinfo.content!
        
        titleL.textColor=neirongColor
        titleL.font=neirongfont
        //计算lable的高度
        let titleL_h = calculateHeight(titleL.text!, size: 17, width: frame.width-20)
        titleL.numberOfLines=0
        titleL.frame.size.height=titleL_h
        cell.selectionStyle = .None
        var image_h = CGFloat()
        let pic = photoinfo.pic
        var pics = Array<String>()
        for item in pic {
            pics.append(item.pictureurl!)
        }
        let picView = NinePicView(frame:CGRectMake(0, titleL_h + 10, WIDTH,0),pic:pics,vc:self)
        cell.contentView.addSubview(picView)
        image_h = picView.image_h
        
        
        //下面的评论视图
        let senderIV = UIImageView(frame: CGRectMake(10, titleL_h+image_h+25, 20, 20))
        senderIV.image=UIImage(named: "ic_fasong")
        cell.contentView.addSubview(senderIV)
        let senderL = UILabel(frame: CGRectMake(35,titleL_h+image_h+25,120,20))
        if photoinfo.name != nil {
            senderL.text=photoinfo.name!
        }
        senderL.font=timefont
        senderL.textColor=timeColor
        cell.contentView.addSubview(senderL)
        let timeL = UILabel(frame: CGRectMake(frame.width-150,titleL_h+image_h+25,140,20))
        timeL.textAlignment = .Right
        timeL.textColor=timeColor
        timeL.font=timefont
        timeL.text=changeTime(photoinfo.write_time!)
        cell.contentView.addSubview(timeL)
        //MARK: - 点赞按钮
        let zanBT = UIButton(frame: CGRectMake(frame.width-100, titleL_h+image_h+25+30, 20, 20))
        zanBT.setImage(UIImage(named: "点赞"), forState: .Normal)
        zanBT.tag=Int(photoinfo.mid!)!
        let userid = NSUserDefaults.standardUserDefaults()
        let uid = userid.stringForKey("userid")
        if photoinfo.photolikelist.count != 0 {
            for item in 0...photoinfo.photolikelist.count-1 {
                if photoinfo.photolikelist[item].userid==uid {
                    zanBT.setImage(UIImage(named: "已点赞"), forState: .Normal)
                    break
                }
            }
        }
        if zanBT.imageView?.image==UIImage(named:"点赞") {
             zanBT.addTarget(self, action: #selector(dianzan(_:)), forControlEvents: .TouchUpInside)
        }else{
            zanBT.addTarget(self, action: #selector(quxiaodianzan(_:)), forControlEvents: .TouchUpInside)
        }
        
       
        cell.contentView.addSubview(zanBT)
        let plBT = UIButton(frame: CGRectMake(frame.width-50, titleL_h+image_h+25+30, 20, 20))
        plBT.setImage(UIImage(named: "发消息"), forState: .Normal)
        plBT.tag = Int(photoinfo.mid!)!+100
        plBT.addTarget(self, action: #selector(self.Pinglun(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.contentView.addSubview(plBT) 
        
        if photoinfo.PhotoComment.count != 0 {
            var commentHeight = CGFloat()
            for item in 0...photoinfo.PhotoComment.count-1 {
                let oldCommentHeight = commentHeight
                let y = titleL_h+image_h+90+oldCommentHeight
                let pinglunView = UIView()
                pinglunView.backgroundColor = bkColor
                cell.contentView.addSubview(pinglunView)
                
                let icon=UIImageView(frame: CGRectMake(5, 5, 50, 50))
                icon.layer.masksToBounds=true
                icon.layer.cornerRadius=25
                icon.image=UIImage(named: "4")
                pinglunView.addSubview(icon)
                let nameL = UILabel(frame: CGRectMake(60,5,frame.width-70,20))
                nameL.text=photoinfo.PhotoComment[item].name
                nameL.font=UIFont.systemFontOfSize(14)
                pinglunView.addSubview(nameL)
                let contentL = UILabel(frame: CGRectMake(60,30,frame.width-70,20))
                contentL.textColor=pinglunColor
                contentL.numberOfLines=0
                contentL.text=photoinfo.PhotoComment[item].content
                contentL.font=UIFont.systemFontOfSize(14)
                let content_h = calculateHeight(contentL.text!, size: 14, width: frame.width-70)
                
                pinglunView.frame.size.height=40+content_h
                contentL.frame.size.height=content_h
                if 40+content_h>60 {
                    commentHeight = commentHeight + 40+content_h
                }else{
                    commentHeight = commentHeight + 60
                }
                
                
                commentHeight = commentHeight + addCommentDividerOneLine(pinglunView, y: pinglunView.frame.size.height-1)
                pinglunView.frame = CGRectMake(5,y,frame.width-10,commentHeight-oldCommentHeight)
                pinglunView.addSubview(contentL)
            }
            tableview.rowHeight=titleL_h+image_h+20+40+commentHeight+40+20
            
            
        }else{
        
            tableview.rowHeight=titleL_h+image_h+20+40+40+20
            
        }
        let view = UIView(frame: CGRectMake(0,tableView.rowHeight-20,frame.width,20))
        view.backgroundColor=dividerColor
        cell.addSubview(view)
        

        
        return cell
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if keyboardTextField.hidden==false {
            keyboardTextField.hidden = true
        }
    }
    
    
    //MARK: 点击事件
    func clickBtn(sender:UIButton) {
        let vc = PhotoBigViewController()
        let model = self.PhotoSource.parentsExhortList[sender.tag]
        vc.arrayInfo = model.pic
        vc.nu = model.pic.count
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    

    func Pinglun(sender:UIButton){
        print(sender.tag)
        keyboardTextField.hidden = false
        keyboardTextField.show()
        keyboardTextField.rightButton.tag = sender.tag
    }
    
    func send(sender:UIButton) {
        let content = keyboardTextField.text
        print(content)
        if content==nil||content=="" {
            messageHUD(self.view, messageData: "请输入评论内容！")
            return
        }
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=school&a="+"SetComment"
        let userid = NSUserDefaults.standardUserDefaults()
        let uid = userid.stringForKey("userid")
        let id = String(sender.tag-100)
        
        let param = [
            
            "userid":uid,
            "id":id,
            "content":content,
            "type":"2"
            
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
                    print("评论成功")
                    self.keyboardTextField.text=""
                    self.loadData()
                }
            }
        }
    }
    func dianzan(sender:UIButton){
        
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=school&a=SetLike"
        let userid = NSUserDefaults.standardUserDefaults()
        let uid = userid.stringForKey("userid")
        let id = String(sender.tag)
        
        let param = [
            
            "userid":uid,
            "id":id,
            "type":"2"
            
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
                    sender.setImage(UIImage(named: "已点赞"), forState: .Normal)

                     self.loadData()
                    self.self.tableview.reloadData()
                    
                }
            }
        }

    }
    func quxiaodianzan(sender:UIButton){
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=school&a=ResetLike"
        let userid = NSUserDefaults.standardUserDefaults()
        let uid = userid.stringForKey("userid")
        let id = String(sender.tag)
        
        let param = [
            
            "userid":uid,
            "id":id,
            "type":"2"
            
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
                    sender.setImage(UIImage(named: "点赞"), forState: .Normal)

                    self.loadData()
                    self.self.tableview.reloadData()
                    
                }
            }
        }

    }
    func NewPhoto(){
        let newPhoto = NewPhotoViewController()
        self.navigationController?.pushViewController(newPhoto, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
