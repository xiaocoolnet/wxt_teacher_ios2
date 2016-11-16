//
//  ReciveAnnounceViewController.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/8/14.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import XWSwiftRefresh
class ReciveAnnounceViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {

    let TongZhiTableView = UITableView()
    var newsInfo = NewsInfo()
    
    var activitySource = ReciveNoticeList()
    var commentSource = ACommentList()
    let arrayPeople = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        DropDownUpdate()
        self.title = "通知公告"
        TongZhiTableView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height - 64 - 40)
        TongZhiTableView.delegate = self
        TongZhiTableView.dataSource = self
        TongZhiTableView.rowHeight=415
        TongZhiTableView.separatorStyle = .None
        TongZhiTableView.tableFooterView = UIView(frame: CGRectZero)
        TongZhiTableView.registerNib((UINib(nibName: "HomeworkTableViewCell",bundle: nil)) ,forCellReuseIdentifier: "cell")
        GetDate()
        let rightItem = UIBarButtonItem(title: "新增", style: UIBarButtonItemStyle.Done, target: self, action: #selector(addDaijie))
        self.navigationItem.rightBarButtonItem = rightItem
        
        self.view.addSubview(TongZhiTableView)
        // Do any additional setup after loading the view.
    }
    //    开始刷新
    func DropDownUpdate(){
        self.TongZhiTableView.headerView = XWRefreshNormalHeader(target: self, action: #selector(TongZhiGonggaoViewController.GetDate))
        self.TongZhiTableView.reloadData()
        self.TongZhiTableView.headerView?.beginRefreshing()
    }
    //MARK: -    获取活动列表
    func GetDate(){
        //http://wxt.xiaocool.net/index.php?g=apps&m=school&a=getnoticelist&userid=597&classid=1&schoolid=1
        //下面两句代码是从缓存中取出userid（入参）值
        let defalutid = NSUserDefaults.standardUserDefaults()
        let userid = defalutid.stringForKey("userid")
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=school&a=get_receive_notice"
        let param = [
            "receiverid":userid!
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
                    self.activitySource = ReciveNoticeList(status.data!)
                    self.TongZhiTableView.reloadData()
                    self.TongZhiTableView.headerView?.endRefreshing()
                }
            }
        }
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activitySource.count
    }
    
    //MARK: -   单元格
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier:String(indexPath.row))
        cell.selectionStyle = .None
        tableView.separatorStyle = .None
        let model = self.activitySource.objectlist[indexPath.row]
        
        //  活动标题
        let titleLbl = UILabel()
        titleLbl.frame = CGRectMake(10, 10, WIDTH - 20, 30)
        
        titleLbl.text = model.title
        titleLbl.textColor=biaotiColor
        titleLbl.font=biaotifont
        cell.contentView.addSubview(titleLbl)
        //  活动内容
        let contentLbl = UILabel()
        contentLbl.frame = CGRectMake(10, 50, WIDTH - 20, 60)
        contentLbl.font = neirongfont
        contentLbl.textColor = neirongColor
        contentLbl.text = model.content
        if indexPath.row==0{
            let user = NSUserDefaults.standardUserDefaults()
            user.setValue(model.content, forKey: "gonggao")
        }
        contentLbl.numberOfLines = 0
        contentLbl.sizeToFit()
        cell.contentView.addSubview(contentLbl)
        
        //        自适应行高
        let options : NSStringDrawingOptions = NSStringDrawingOptions.UsesLineFragmentOrigin
        let screenBounds:CGRect = UIScreen.mainScreen().bounds
        let boundingRect = String(contentLbl.text).boundingRectWithSize(CGSizeMake(screenBounds.width, 0), options: options, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(17)], context: nil)
        let height = boundingRect.size.height + 50
        //  活动图片
        let pic = model.pic
        //  图片
        var image_h = CGFloat()
        //获取的图片数组
        var pics = Array<String>()
        for item in pic {
            pics.append(item.pictureurl!)
        }
        let picView = NinePicView(frame:CGRectMake(0, boundingRect.size.height + 60, WIDTH,0),pic:pics,vc:self)
        cell.contentView.addSubview(picView)
        image_h = picView.image_h

        
        
        
        let imageView = UIImageView()
        imageView.frame = CGRectMake(10, height + image_h + 10, 18, 18)
        imageView.image = UIImage.init(named: "ic_fasong")
        cell.contentView.addSubview(imageView)
        
        let senderLbl = UILabel()
        senderLbl.frame = CGRectMake(35, height + image_h + 10, 100, 20)
        senderLbl.font = timefont
        senderLbl.textColor=timeColor
        senderLbl.text = model.username
        cell.contentView.addSubview(senderLbl)
        
        
        //  活动时间
        let timeLbl = UILabel()
        timeLbl.frame = CGRectMake(110, height + image_h + 10, WIDTH - 120, 20)
        timeLbl.textAlignment = NSTextAlignment.Right
        timeLbl.font = timefont
        timeLbl.textColor = timeColor
        timeLbl.text = changeTime(model.create_time!)
        cell.contentView.addSubview(timeLbl)
        
        let line = UILabel()
        line.frame = CGRectMake(1, height + image_h + 40, WIDTH - 2, 0.5)
        line.backgroundColor = UIColor.lightGrayColor()
        cell.addSubview(line)
        
        //已读未读
        var a = 0
        for i in 0..<model.reciver_list.count {
            let strr = model.reciver_list[i].create_time
            if strr == "0" {
                a+=1
            }
        }
        let all = UILabel()
        all.frame = CGRectMake(10, height + image_h + 50, 200, 20)
        all.text = "总发 \(model.reciver_list.count) 已阅读 \(model.reciver_list.count-a) 未读 \(a)"
        all.textColor = UIColor.orangeColor()
        all.font = neirongfont
        cell.contentView.addSubview(all)
        
        let view = UIView()
        view.frame = CGRectMake(0, height + image_h + 75, WIDTH, 20)
        view.backgroundColor = RGBA(242.0, g: 242.0, b: 242.0, a: 1)
        cell.addSubview(view)
        
        tableView.rowHeight = height + image_h + 95
        
        return cell
    }
    
    func clickBtn(sender:UIButton) {
        let vc = NoticePicViewController()
        let model = self.activitySource.objectlist[sender.tag]
//        vc.arrayInfo = model.pic
        vc.nu = model.pic.count
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = NoticeDetailViewController()
        print("---------------")
        vc.rdateSource = self.activitySource.objectlist[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    func addDaijie(){
        let vc = AddJZGongGaoViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
