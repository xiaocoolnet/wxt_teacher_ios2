//
//  HomeworkViewController.swift
//  WXT_Parents
//
//  Created by zhang on 16/4/27.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import YYWebImage
import MBProgressHUD
import MJRefresh
class HomeworkViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    let table = UITableView()
    var homeworkSource = HomeworkList()
    
    var commentSource = HCommentList()
    let arrayPeople = NSMutableArray()
    var heightrow = CGFloat()
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData()
        let user = NSUserDefaults.standardUserDefaults()
        user.removeObjectForKey("homeworkArr")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的作业"
        self.createTable()
        self.DropDownUpdate()

    }
//MARK: -   开始刷新
    func DropDownUpdate(){
       self.table.mj_header = MJRefreshNormalHeader(refreshingBlock: { 
            self.loadData()
            self.table.mj_header.endRefreshing()
       })
        self.table.mj_header.beginRefreshing()
    }
//MARK: -    创建表
    func createTable(){
        table.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .None
        heightrow = 100
        self.view.addSubview(table)
         let rightItem=UIBarButtonItem(image: UIImage(named: "add3"), landscapeImagePhone: UIImage(named: "add3"), style: .Done, target: self, action: #selector(addHomework))
        self.navigationItem.rightBarButtonItem = rightItem

    }
//MARK: -   获取作业列表
    func loadData(){
//        http://wxt.xiaocool.net/index.php?g=apps&m=teacher&a=gethomeworklist&userid=597&classid=1
       
        //下面两句代码是从缓存中取出userid（入参）值
        let defalutid = NSUserDefaults.standardUserDefaults()
        let uid = defalutid.stringForKey("userid")
        let classid = defalutid.stringForKey("classid")
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=teacher&a=gethomeworklist"
        let param = [
            "userid":uid!,
            "classid":classid!
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
                    self.homeworkSource = HomeworkList(status.data!)
                    self.table.reloadData()
                 
                }
            }
        }
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return heightrow
    }
//MARK: -  分区数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
//MARK: -   行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeworkSource.count
    }
//MARK: -     单元格
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier:String(indexPath.row))
        cell.selectionStyle = .None
        tableView.separatorStyle = .None
        let model = self.homeworkSource.homeworkList[indexPath.row]
        
        //  活动标题
        let titleLbl = UILabel()
        titleLbl.text = model.title
        titleLbl.textColor=biaotiColor
        titleLbl.font=biaotifont
        titleLbl.numberOfLines = 0
        titleLbl.sizeToFit()
        //自适应行高
        let toptions : NSStringDrawingOptions = NSStringDrawingOptions.UsesLineFragmentOrigin
        let tscreenBounds:CGRect = UIScreen.mainScreen().bounds
        let tboundingRect = String(model.title).boundingRectWithSize(CGSizeMake(tscreenBounds.width-20, 0), options: toptions, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(17)], context: nil)
        let theight = tboundingRect.size.height
        titleLbl.frame = CGRectMake(10, 10, WIDTH - 20, theight)
        cell.contentView.addSubview(titleLbl)
        print(titleLbl.frame)
        
        
        
        //  活动内容
        let contentLbl = UILabel()
        contentLbl.font = neirongfont
        contentLbl.textColor = neirongColor
        contentLbl.text = model.content
        contentLbl.numberOfLines = 0
        contentLbl.sizeToFit()
        // 自适应行高
        let options : NSStringDrawingOptions = NSStringDrawingOptions.UsesLineFragmentOrigin
        let screenBounds:CGRect = UIScreen.mainScreen().bounds
        let boundingRect = String(model.content).boundingRectWithSize(CGSizeMake(screenBounds.width-20, 0), options: options, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(15)], context: nil)
        contentLbl.frame = CGRectMake(10, theight+10+10, WIDTH - 20, boundingRect.size.height)
        let height = theight+10+10+boundingRect.size.height+10
         cell.contentView.addSubview(contentLbl)
        
        
        //  图片
        var image_h = CGFloat()
         //展示图片的view
        let pic = model.pic
        var pics = Array<String>()
        for item in pic {
            pics.append(item.pictureurl)
        }
        let picView = NinePicView(frame:CGRectMake(0, height, WIDTH,0),pic:pics,vc:self)
        cell.contentView.addSubview(picView)
        image_h = picView.image_h
        
        //发送人图标
        let imageView = UIImageView()
        imageView.frame = CGRectMake(10, height + image_h + 12, 18, 18)
        imageView.image = UIImage.init(named: "ic_fasong")
        cell.contentView.addSubview(imageView)
        //发送人姓名
        let senderLbl = UILabel()
        senderLbl.frame = CGRectMake(30, height + image_h + 10, 60, 20)
        senderLbl.font = timefont
        senderLbl.textColor = timeColor
        senderLbl.text = model.username
        cell.contentView.addSubview(senderLbl)
        
        
        //  活动时间
        let dateformate = NSDateFormatter()
        dateformate.dateFormat = "yyyy-MM-dd HH:mm"
        let date = NSDate(timeIntervalSince1970: NSTimeInterval(model.create_time!)!)
        let str:String = dateformate.stringFromDate(date)
        let timeLbl = UILabel()
        timeLbl.frame = CGRectMake(110, height + image_h + 10, WIDTH - 120, 20)
        timeLbl.textAlignment = NSTextAlignment.Right
        timeLbl.font = timefont
        timeLbl.textColor = timeColor
        timeLbl.text = str
        cell.contentView.addSubview(timeLbl)
        
        let line = UILabel()
        line.frame = CGRectMake(1, height + image_h + 40, WIDTH - 2, 0.5)
        line.backgroundColor = dividerColor
        cell.addSubview(line)
        
        let all = UILabel()
        all.frame = CGRectMake(10, height + image_h + 50, WIDTH - 60 - 10 - 10, 20)
        all.textColor = UIColor.orangeColor()
        all.font = timefont
        cell.contentView.addSubview(all)
        let array = NSMutableArray()
        for item in model.receiverlist {
            if item.read_time == "null" {
                array.addObject(item)
            }
        }
        all.text = "总发 \(model.receiverlist.count)  已阅读 \(array.count)  未读 \(model.receiverlist.count - array.count)"
        
        let wei = UILabel()
        wei.frame = CGRectMake(WIDTH - 60 - 10, height + image_h + 50, 60, 20)
        wei.text = model.subject
        wei.textAlignment = .Right
        wei.textColor = timeColor
        wei.font = UIFont.systemFontOfSize(15)
        cell.contentView.addSubview(wei)
        
        let view = UIView()
        view.frame = CGRectMake(0, height + image_h + 75, WIDTH, 10)
        view.backgroundColor = RGBA(242.0, g: 242.0, b: 242.0, a: 1)
        cell.addSubview(view)
        
        heightrow =  height + image_h + 80 + 5
      
        return cell
    }
    func clickBtn(sender:UIButton){
        
    }

    func addHomework(){
        let vc = AddHomeworkViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
//MARK: -    阅读
    func readBtn(sender:UIButton){
//        let btn:UIButton = sender
//        let vc = ReadViewController()
//        let newsInfo = self.homeworkSource.homeworkList[btn.tag]
//        vc.num1 = String(newsInfo.readcount!)
//        vc.num2 = String(newsInfo.allreader!-newsInfo.readcount!)
//        vc.id = String(btn.tag)
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewWillDisappear(animated: Bool) {
        let user = NSUserDefaults.standardUserDefaults()
        user.removeObjectForKey("homeworkArr")
    }
    
}
