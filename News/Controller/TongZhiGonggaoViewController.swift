//
//  TongZhiGonggaoViewController.swift
//  WXT_Teacher
//
//  Created by 李春波 on 16/3/23.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import MJRefresh
class TongZhiGonggaoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let TongZhiTableView = UITableView()
    var newsInfo = NewsInfo()
    
    var activitySource = ClassNoticeList()
    var commentSource = ACommentList()
    let arrayPeople = NSMutableArray()
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.GetDate()
    }
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
 
    }
    //    开始刷新
    func DropDownUpdate(){
        self.TongZhiTableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.GetDate()
            self.TongZhiTableView.mj_header.endRefreshing()
        })
        self.TongZhiTableView.mj_header.beginRefreshing()
    }
//MARK: -    获取活动列表
    func GetDate(){
        //http://wxt.xiaocool.net/index.php?g=apps&m=school&a=getnoticelist&userid=597&classid=1&schoolid=1
        //下面两句代码是从缓存中取出userid（入参）值
        let defalutid = NSUserDefaults.standardUserDefaults()
        let userid = defalutid.stringForKey("userid")
        let classid = defalutid.stringForKey("classid")
        let schoolid = defalutid.stringForKey("schoolid")
        
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=school&a=getnoticelist"
        let param = [
            "userid":userid!,
            "classid":classid!,
            "schoolid":schoolid!
        ]
        Alamofire.request(.GET, url, parameters: param as? [String : String]).response { request, response, json, error in
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
                   self.activitySource = ClassNoticeList(status.data!)
                    self.TongZhiTableView.reloadData()
              
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
        titleLbl.frame = CGRectMake(10, 10, WIDTH - 20, calculateHeight(model.title!, size: 17, width: WIDTH - 20))
        titleLbl.text = model.title
        titleLbl.textColor=biaotiColor
        titleLbl.font=biaotifont
        titleLbl.numberOfLines = 0
        cell.contentView.addSubview(titleLbl)
        
        //        自适应行高
        let option : NSStringDrawingOptions = NSStringDrawingOptions.UsesLineFragmentOrigin
        let screenBound:CGRect = UIScreen.mainScreen().bounds
        let boundingRects = String(titleLbl.text).boundingRectWithSize(CGSizeMake(screenBound.width, 0), options: option, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(17)], context: nil)
        
        let contentH = boundingRects.size.height + 20
        //  活动内容
        let contentLbl = UILabel()
        contentLbl.frame = CGRectMake(10, contentH, WIDTH - 20, 60)
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
        let contentHeight = calculateHeight(model.content!, size: 15, width: WIDTH-20)
        let height = contentHeight + titleLbl.frame.height + 30
        contentLbl.frame = CGRectMake(10, titleLbl.frame.maxY+10, WIDTH - 20, contentHeight)
        //  活动图片
        let pic = model.pic
        //  图片
        var image_h = CGFloat()
        //判断图片张数显示
        var pics = Array<String>()
        for item in pic {
            pics.append(item.pictureurl)
        }
        let picView = NinePicView(frame:CGRectMake(0, height, WIDTH,0),pic:pics,vc:self)
        cell.contentView.addSubview(picView)
        image_h = picView.image_h
        
        
        
        
        let imageView = UIImageView()
        imageView.frame = CGRectMake(10, height + image_h + 10, 18, 18)
        imageView.image = UIImage.init(named: "ic_fasong")
        cell.contentView.addSubview(imageView)
        
        let senderLbl = UILabel()
        senderLbl.frame = CGRectMake(35, height + image_h + 10, 60, 20)
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
        line.backgroundColor = bkColor
        cell.addSubview(line)
        
        //已读 未读
        let array = NSMutableArray()
        for i in 0..<model.receive_list.count {
            let strr = model.receive_list[i].receivertype
            if strr == "0" {
                array.addObject(strr)
            }
        }
        let all = UILabel()
        all.frame = CGRectMake(10, height + image_h + 50, WIDTH-20, 20)
        all.text = "总发 \(model.receive_list.count) 已阅读 \(model.receive_list.count - array.count) 未读 \(array.count)"
        all.textColor = UIColor.orangeColor()
        all.font = timefont
        cell.contentView.addSubview(all)
        
        let wei = UILabel()
        wei.frame = CGRectMake(110, height + image_h + 45, 60, 20)
        wei.text = "未读\(array.count)"
        wei.textColor = UIColor.orangeColor()
        wei.font = timefont
        cell.contentView.addSubview(wei)
        
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
        vc.arrayInfo = model.pic
        vc.nu = model.pic.count
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = NoticeDetailViewController()
        print("---------------")
        vc.dateSource = self.activitySource.objectlist[indexPath.row]
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
