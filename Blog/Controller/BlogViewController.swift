//
//  BlogViewController.swift
//  WXT_Teachers
//
//  Created by 李春波 on 16/2/25.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import YYWebImage
import MBProgressHUD
import XWSwiftRefresh

class BlogViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,SYKeyboardTextFieldDelegate {

    let blogTableView = UITableView()
    var blogSource = MyBlogList()
   
    var remoteThumbImage = [NSIndexPath:[String]]()
    var remoteImage :[String] = []
    var sectionInt = Int()
    var peopleArray:String?
    var scrollView = UIScrollView()
    private let numOfPages=4
    var num=0
    var headerview = UIView()
    var bview = UIView()
    let contentTextView = UITextField()
    var idtag = Int()
    var keyboardShowState = false
    var keyboardTextField : SYKeyboardTextField!
    
    
    override func viewDidLoad() {
        self.title = "动态"
        super.viewDidLoad()
        XKeyBoard.registerKeyBoardHide(self)
        XKeyBoard.registerKeyBoardShow(self)
        //MARK: - 滚动式图
        self.scroll()
        
        headerview.frame = CGRectMake(0,0,frame.width,frame.width*0.55)
        //发布按钮
        let rightItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(BlogViewController.NewBlog))
        self.navigationItem.rightBarButtonItem = rightItem
        blogTableView.delegate = self
        blogTableView.dataSource = self
        blogTableView.frame = CGRectMake(0, 0, frame.width, frame.height-64-44)
        blogTableView.registerClass(BlogTableViewCell.self, forCellReuseIdentifier: "blogCell")
        self.automaticallyAdjustsScrollViewInsets = false
        self.tabBarController?.tabBar.hidden = false
        blogTableView.tableHeaderView=headerview
        blogTableView.separatorStyle = .None
        self.view.addSubview(blogTableView)
        let footerview = XWRefreshAutoNormalFooter(target: self, action: #selector(BlogViewController.GetDate))
        self.blogTableView.footerView = footerview
         print(footerview)
        self.DropDownUpdate()
        loadCommentKeyBoardView()
    }
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
        self.GetDate()
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
//        keyboardTextField.hide()
//        keyboardTextField.hidden = true
    }

    
    func scroll(){
        //滚动式图
        let scrollview_h = frame.width*0.55
        
        scrollView.frame = CGRectMake(0, 0, frame.width, scrollview_h)
        
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        scrollView.contentOffset = CGPointZero
        
        // 将 scrollView 的 contentSize 设为屏幕宽度的3倍(根据实际情况改变)
        scrollView.contentSize = CGSize(width: frame.width * CGFloat(numOfPages), height: scrollview_h)
        scrollView.delegate = self
        for index  in 0..<numOfPages {
            let imageView = UIImageView(image: UIImage(named: "无网络的背景"))
            imageView.frame = CGRect(x: frame.width * CGFloat(index), y: 0, width: frame.width, height: scrollview_h)
            scrollView.addSubview(imageView)
        }
        //滚动视图添加小白点
        let pageC = UIPageControl()
        pageC.frame=CGRectMake(frame.width/2-20, 200, 40, 20)
        
        pageC.tag=102
        pageC.numberOfPages=4
        pageC.addTarget(self, action: #selector(dopageC), forControlEvents: UIControlEvents.ValueChanged )
        //将小白点添加到滚动视图
        scrollView.addSubview(pageC)
        //将滚动式图添加到view上
        headerview.addSubview(scrollView)
        
        //定时器
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector (doTime), userInfo: nil, repeats: true)


    }
    //执行定时器方法
    func doTime(){
        
        
        let pageC = self.view.viewWithTag(102) as! UIPageControl
        pageC.currentPage=num
        self.dopageC(pageC)
        num += 1
        if num==4 {
            num=0
        }
    }
    //点击小白点，图片移动
    func dopageC(sender:UIPageControl){
        var x = CGFloat()
        x=CGFloat(sender.currentPage)*self.view.bounds.width
        var rect = CGRect()
        rect=CGRectMake(x,64 , self.view.bounds.width, self.view.bounds.height-400)
        scrollView.scrollRectToVisible(rect, animated: true)
    }
    //小白点移动
    func scrollViewDidEndDecelerating(scrollView: UIScrollView){
        
        let frame = self.view.bounds
        
        let pageC = self.view.viewWithTag(102) as! UIPageControl
        
        pageC.currentPage = Int(scrollView.contentOffset.x/frame.width)
    }

    //MARK: - 刷新列表
    func DropDownUpdate(){
        self.blogTableView.headerView = XWRefreshNormalHeader(target: self, action: #selector(BlogViewController.GetDate))
        self.blogTableView.reloadData()
        self.blogTableView.headerView?.beginRefreshing()
    }
    //MARK: - 获取动态列表数据
    func GetDate(){
        print("刷新")
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=index&a=GetMicroblog"
        let schoolid = NSUserDefaults.standardUserDefaults()
        let scid = schoolid.stringForKey("schoolid")
        let classid = NSUserDefaults.standardUserDefaults()
        let clid = classid.stringForKey("classid")
        let ui = NSUserDefaults.standardUserDefaults()
        let uid = ui.stringForKey("userid")
        let scidd = scid
        let clidd = clid
        
        let param = [
            "schoolid":scidd,
            "classid":clidd,
            "type":"1",
            "beginid":"",
            "userid":uid
        ]
        Alamofire.request(.GET, url, parameters: param as? [String:String]).response { request, response, json, error in
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
                    hud.mode = MBProgressHUDMode.Text;
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 1)
                }
                if(status.status == "success"){
                    self.blogSource = MyBlogList(status.data!)
//                    self.blogTableView.reloadSections(NSIndexSet (index: 0), withRowAnimation: UITableViewRowAnimation.Automatic)
                    self.blogTableView.reloadData()
                    self.blogTableView.headerView?.endRefreshing()
                }
            }
        }
    }

 
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  blogSource.count
    }
    
 
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let photoinfo = blogSource.objectlist[indexPath.row]
        
        let cell = UITableViewCell(style: .Default, reuseIdentifier: String(indexPath.row))
        let senderIV = UIImageView(frame: CGRectMake(5, 10, 40, 40))
        let photo = photoinfo.photo
        let url = imageUrl+photo!
        senderIV.yy_setImageWithURL(NSURL(string: url), placeholder: UIImage(named: "Logo"))
        senderIV.layer.masksToBounds=true
        senderIV.layer.cornerRadius=20
        cell.contentView.addSubview(senderIV)
        
        //发送人
        let senderL = UILabel(frame: CGRectMake(50,10,120,20))
        if photoinfo.name != nil {
            senderL.text=photoinfo.name!
        }
        senderL.font=UIFont.systemFontOfSize(15)
        cell.contentView.addSubview(senderL)
       
        //发送时间
        let timeL = UILabel(frame: CGRectMake(50,senderL.frame.maxY+5,140,20))
        timeL.textAlignment = .Left
        timeL.textColor=timeColor
        timeL.font=timefont
        timeL.text=changeTime(photoinfo.write_time!)
        cell.contentView.addSubview(timeL)
        
        let titleL = UILabel()
        cell.addSubview(titleL)
        titleL.text=photoinfo.content!
        titleL.textColor=neirongColor
        titleL.font=neirongfont
        //计算lable的高度
        let titleL_h = calculateHeight(titleL.text!, size: 17, width: frame.width-60)
        titleL.numberOfLines=0
        titleL.frame=CGRectMake(50,addDividerLine(cell.contentView, y: timeL.frame.maxY+5, height: 1).frame.maxY+5,frame.width-60,titleL_h)
        cell.selectionStyle = .None
        
       
       
        
        //判断图片张数显示
         var image_h = CGFloat()
        var pics = Array<String>()
        for item in photoinfo.pic {
            pics.append(item.pictureurl!)
        }
        let picView = NinePicView(frame:CGRectMake(42, titleL.frame.maxY + 10, frame.width-50,0),pic:pics,vc:self)
        cell.contentView.addSubview(picView)
        image_h = picView.image_h
        
        addDividerLine(cell.contentView, y: titleL_h+image_h+25+30+35, height: 1)
        
        //MARK: - 点赞按钮
        let zanBT = UIButton(frame: CGRectMake(frame.width-100, titleL_h+image_h+25+30+40, 20, 20))
        zanBT.setImage(UIImage(named: "点赞"), forState: .Normal)
        zanBT.tag=Int(photoinfo.mid!)!
        let userid = NSUserDefaults.standardUserDefaults()
        let uid = userid.stringForKey("userid")
        if photoinfo.like.count != 0 {
            for item in 0...photoinfo.like.count-1 {
                if photoinfo.like[item].userid==uid {
                    zanBT.setImage(UIImage(named: "已点赞"), forState: .Normal)
                    break
                }
            }
        }
        if zanBT.imageView?.image==UIImage(named:"点赞") {
            zanBT.addTarget(self, action: #selector(GetDianZanDate(_:)), forControlEvents: .TouchUpInside)
        }else{
            zanBT.addTarget(self, action: #selector(QuXiaoDianZan(_:)), forControlEvents: .TouchUpInside)
        }
        
        
        cell.contentView.addSubview(zanBT)
        let plBT = UIButton(frame: CGRectMake(frame.width-50, titleL_h+image_h+25+30+40, 20, 20))
        plBT.setImage(UIImage(named: "发消息"), forState: .Normal)
        plBT.tag=Int(photoinfo.mid!)!+100
        plBT.addTarget(self, action: #selector(pinglun(_:)), forControlEvents: .TouchUpInside)
        cell.contentView.addSubview(plBT)
  
        
        //下面的评论视图
        if photoinfo.comment.count != 0 {
            var commentHeight = CGFloat()
            for item in 0...photoinfo.comment.count-1 {
                let oldCommentHeight = commentHeight
                let y = titleL_h+image_h+25+30+40+25+oldCommentHeight
                let pinglunView = UIView()
                pinglunView.backgroundColor = bkColor
                cell.contentView.addSubview(pinglunView)
                
                let icon=UIImageView(frame: CGRectMake(5, 5, 50, 50))
                icon.layer.masksToBounds=true
                icon.layer.cornerRadius=25
                icon.image=UIImage(named: "4")
                pinglunView.addSubview(icon)
                let nameL = UILabel(frame: CGRectMake(60,5,frame.width-70,20))
                nameL.text=photoinfo.comment[item].name
                nameL.font=UIFont.systemFontOfSize(14)
                pinglunView.addSubview(nameL)
                
                let timec = UILabel(frame: CGRectMake(frame.width-60-140,5,135,20))
                timec.textAlignment = .Right
                timec.textColor=timeColor
                timec.font=UIFont.systemFontOfSize(12)
                timec.text=changeTime(photoinfo.comment[item].comment_time)
                pinglunView.addSubview(timec)
                
                let contentL = UILabel(frame: CGRectMake(60,30,frame.width-70,20))
                contentL.textColor=pinglunColor
                contentL.numberOfLines=0
                contentL.text=photoinfo.comment[item].content
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
                pinglunView.frame = CGRectMake(50,y,frame.width-60,commentHeight-oldCommentHeight)
                pinglunView.addSubview(contentL)

            }
             tableView.rowHeight=titleL_h+image_h+20+40+commentHeight+40+20+27
//            tableView.rowHeight=30+titleL_h+image_h+20+40+60*CGFloat(photoinfo.comment.count)+30+40+20
        }else{
//            tableView.rowHeight=30+titleL_h+image_h+20+40+30+40
            tableView.rowHeight=titleL_h+image_h+20+40+40+20+27
        }
        
        let view = UIView(frame: CGRectMake(0,tableView.rowHeight-20,frame.width,20))
        view.backgroundColor=bkColor
        cell.contentView.addSubview(view)
        
        
        return cell
    }
    func pinglun(sender:UIButton){
//        self.tabBarController?.tabBar.hidden = true
        keyboardTextField.hidden = false
        keyboardTextField.show()
        keyboardTextField.rightButton.tag = sender.tag
        self.idtag = sender.tag
//        bview.frame = CGRectMake(0, frame.height - 185 , frame.width, 80)
//        bview.backgroundColor = UIColor.lightGrayColor()
//        self.view.addSubview(bview)
//        contentTextView.frame = CGRectMake(20 , 20, frame.width - 40, 40)
//        contentTextView.borderStyle = UITextBorderStyle.RoundedRect
//        contentTextView.placeholder = "评论"
//        contentTextView.returnKeyType = UIReturnKeyType.Send
//        contentTextView.delegate = self
//        bview.addSubview(contentTextView)
//        self.idtag = sender.tag
//        print(self.idtag)
        

    }

    //     键盘出现的通知方法
    func keyboardWillShowNotification(notification:NSNotification){
        UIView.animateWithDuration(0.3) { () -> Void in
        // 获取键盘信息
        let keyboardinfo = notification.userInfo![UIKeyboardFrameEndUserInfoKey]
        
        let keyboardheight:CGFloat = (keyboardinfo?.CGRectValue.size.height)!
     
        self.bview.frame = CGRectMake(0, frame.height - keyboardheight - self.keyboardTextField.size.height, frame.width, 80)
        self.blogTableView.frame = CGRectMake(0, 0, frame.width, frame.height - keyboardheight - self.keyboardTextField.size.height)
 
        }
    }
    //         键盘消失的通知方法
    func keyboardWillHideNotification(notification:NSNotification){
        UIView.animateWithDuration(0.3) { () -> Void in
     
            self.bview.removeFromSuperview()
            self.contentTextView.removeFromSuperview()
            self.blogTableView.frame = CGRectMake(0, 0, frame.width, frame.height)
            
        }
        print("键盘落下")
    }
//
//
    func keyboardTextFieldPressReturnButton(keyboardTextField :SYKeyboardTextField) {
        

        
        let content = keyboardTextField.text
        print(content)
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=school&a="+"SetComment"
        let userid = NSUserDefaults.standardUserDefaults()
        let uid = userid.stringForKey("userid")
        let id = String(idtag-100)
        
        let param = [
            
            "userid":uid,
            "id":id,
            "content":content,
            "type":"1"
            
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
                    self.GetDate()
                    self.blogTableView.reloadData()
                    keyboardTextField.hide()
                }
            }
        }
//            keyboardTextField.resignFirstResponder()
        
        
    }


    func QuXiaoDianZan(sender:UIButton){
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=school&a=ResetLike"
        let userid = NSUserDefaults.standardUserDefaults()
        let uid = userid.stringForKey("userid")
        let id = String(sender.tag)
        
        let param = [
            
            "userid":uid,
            "id":id,
            "type":"1"
            
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
                    
                    self.GetDate()
//                    self.blogTableView.reloadData()
                    
                }
            }
        }
        
    }
    func GetDianZanDate(sender:UIButton){
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=school&a=SetLike"
        let userid = NSUserDefaults.standardUserDefaults()
        let uid = userid.stringForKey("userid")
        let id = String(sender.tag)
        
        let param = [
            
            "userid":uid,
            "id":id,
            "type":"1"
            
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
                    
                    self.GetDate()
//                    self.blogTableView.reloadData()
                    
                }
            }
        }
    }
    func clickBtn(sender:UIButton){
        
    }
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {

            self.view.endEditing(true)

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
            "type":"1"
            
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
                    self.GetDate()
                }
            }
        }
    }


    func NewBlog(){
        let newBlog = NewBlogViewController()
        self.navigationController?.pushViewController(newBlog, animated: true)
        newBlog.tabBarController?.tabBar.hidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
}
