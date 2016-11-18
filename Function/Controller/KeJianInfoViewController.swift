//
//  KeJianInfoViewController.swift
//  WXT_Teacher
//
//  Created by 李春波 on 16/3/31.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire

class KeJianInfoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    let TongZhiTableView = UITableView()
    var newsInfo = NewsInfo()
    var activitySource = KeMuInfo()
    let arrayPeople = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
//        DropDownUpdate()
        self.title = "班级课件"
        TongZhiTableView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height - 64 )
        TongZhiTableView.delegate = self
        TongZhiTableView.dataSource = self
        TongZhiTableView.rowHeight=415
        TongZhiTableView.separatorStyle = .None
        TongZhiTableView.tableFooterView = UIView(frame: CGRectZero)
        TongZhiTableView.registerNib((UINib(nibName: "HomeworkTableViewCell",bundle: nil)) ,forCellReuseIdentifier: "cell")
//        GetDate()
//        let rightItem = UIBarButtonItem(title: "新增", style: UIBarButtonItemStyle.Done, target: self, action: #selector(addDaijie))
//        self.navigationItem.rightBarButtonItem = rightItem
        
        self.view.addSubview(TongZhiTableView)
        // Do any additional setup after loading the view.
    }
    //    开始刷新
//    func DropDownUpdate(){
//        self.TongZhiTableView.headerView = XWRefreshNormalHeader(target: self, action: #selector(TongZhiGonggaoViewController.GetDate))
//        self.TongZhiTableView.reloadData()
//        self.TongZhiTableView.headerView?.beginRefreshing()
//    }
//    //MARK: -    获取活动列表
//    func GetDate(){
//        //http://wxt.xiaocool.net/index.php?g=apps&m=school&a=getnoticelist&userid=597&classid=1&schoolid=1
//        //下面两句代码是从缓存中取出userid（入参）值
//        let defalutid = NSUserDefaults.standardUserDefaults()
//        let userid = defalutid.stringForKey("userid")
//        let classid = defalutid.stringForKey("classid")
//        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=school&a=getnoticelist"
//        let param = [
//            "userid":userid!,
//            "classid":classid!,
//            "schoolid":1
//        ]
//        Alamofire.request(.GET, url, parameters: param as? [String : AnyObject]).response { request, response, json, error in
//            if(error != nil){
//            }
//            else{
//                print("request是")
//                print(request!)
//                print("====================")
//                let status = Http(JSONDecoder(json!))
//                print("状态是")
//                print(status.status)
//                if(status.status == "error"){
//                    let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
//                    hud.mode = MBProgressHUDMode.Text
//                    hud.labelText = status.errorData
//                    hud.margin = 10.0
//                    hud.removeFromSuperViewOnHide = true
//                    hud.hide(true, afterDelay: 1)
//                }
//                if(status.status == "success"){
//                    self.activitySource = ClassNoticeList(status.data!)
//                    self.TongZhiTableView.reloadData()
//                    self.TongZhiTableView.headerView?.endRefreshing()
//                }
//            }
//        }
//        
//    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activitySource.courseware_info.count
    }
    
    //MARK: -   单元格
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier:String(indexPath.row))
        cell.selectionStyle = .None
        tableView.separatorStyle = .None
        let model = self.activitySource.courseware_info[indexPath.row]
        
        //  活动标题
        let titleLbl = UILabel()
        titleLbl.frame = CGRectMake(10, 10, WIDTH - 20, 30)
        titleLbl.textAlignment = NSTextAlignment.Center
        titleLbl.text = model.courseware_title
        cell.contentView.addSubview(titleLbl)
        //  活动内容
        let contentLbl = UILabel()
        contentLbl.frame = CGRectMake(10, 50, WIDTH - 20, 60)
        contentLbl.font = neirongfont
        contentLbl.textColor = neirongColor
        contentLbl.text = model.courseware_content
        contentLbl.numberOfLines = 0
       
        cell.contentView.addSubview(contentLbl)
        
        //        自适应行高
        let options : NSStringDrawingOptions = NSStringDrawingOptions.UsesLineFragmentOrigin
        let screenBounds:CGRect = UIScreen.mainScreen().bounds
        let boundingRect = String(contentLbl.text).boundingRectWithSize(CGSizeMake(screenBounds.width, 0), options: options, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(17)], context: nil)
        let height = boundingRect.size.height + 50
        //  活动图片
        let pic = model.pic
        var image_h = CGFloat()
        var pics = Array<String>()
        for item in pic {
            pics.append(item.picture_url!)
        }
        let picView = NinePicView(frame:CGRectMake(0, height, frame.width-50,0),pic:pics,vc:self)
        cell.contentView.addSubview(picView)
        image_h = picView.image_h
        
        
        
        let imageView = UIImageView()
        imageView.frame = CGRectMake(10, height + image_h + 10, 21, 21)
        imageView.image = UIImage.init(named: "ic_fasong")
        cell.contentView.addSubview(imageView)
        
        let senderLbl = UILabel()
        senderLbl.frame = CGRectMake(40, height + image_h + 10, 100, 20)
        senderLbl.font = timefont
        senderLbl.textColor=timeColor
        senderLbl.text = model.teacher_name
        cell.contentView.addSubview(senderLbl)
        
        
        //  活动时间
        let dateformate = NSDateFormatter()
        dateformate.dateFormat = "yyyy-MM-dd HH:mm"
        let date = NSDate(timeIntervalSince1970: NSTimeInterval(model.courseware_time!)!)
        var str:String = dateformate.stringFromDate(date)
        let timeLbl = UILabel()
        timeLbl.frame = CGRectMake(110, height + image_h + 10, WIDTH - 120, 20)
        timeLbl.textAlignment = NSTextAlignment.Right
        timeLbl.font = timefont
        timeLbl.textColor = timeColor
        timeLbl.text = str
        cell.contentView.addSubview(timeLbl)
        
        let line = UILabel()
        line.frame = CGRectMake(1, height + image_h + 40, WIDTH - 2, 0.5)
        line.backgroundColor = UIColor.lightGrayColor()
        cell.addSubview(line)
        
//        let all = UILabel()
//        all.frame = CGRectMake(10, height + image_h + 50, 60, 20)
//        all.text = "总发 \(model.receive_list.count)"
//        all.textColor = UIColor.orangeColor()
//        all.font = UIFont.systemFontOfSize(15)
//        cell.contentView.addSubview(all)
//        
//        let already = UILabel()
//        already.frame = CGRectMake(80, height + image_h + 50, 80, 20)
//        let array = NSMutableArray()
//        for i in 0..<model.receive_list.count {
//            let strr = model.receive_list[i].receivertype
//            if strr == "0" {
//                array.addObject(strr)
//            }
//        }
//        already.text = "已阅读 \(model.receive_list.count - array.count)"
//        already.textColor = UIColor.orangeColor()
//        already.font = UIFont.systemFontOfSize(15)
//        cell.contentView.addSubview(already)
//        
//        let wei = UILabel()
//        wei.frame = CGRectMake(170, height + image_h + 50, 60, 20)
//        wei.text = "未读 \(array.count)"
//        wei.textColor = UIColor.orangeColor()
//        wei.font = UIFont.systemFontOfSize(15)
//        cell.contentView.addSubview(wei)
        
        let view = UIView()
        view.frame = CGRectMake(0, height + image_h + 70, WIDTH, 20)
        view.backgroundColor = RGBA(242.0, g: 242.0, b: 242.0, a: 1)
        cell.addSubview(view)
        
        tableView.rowHeight = height + image_h + 90
        
        return cell
    }
    
    func clickBtn(sender:UIButton) {
        let vc = NoticePicViewController()
        let model = self.activitySource.courseware_info[sender.tag]
//        vc.arrayInfo = model.pic
        vc.nu = model.pic.count
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = NoticeDetailViewController()
        print("---------------")
//        vc.dateSource = self.activitySource.courseware_info[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    func addDaijie(){
        let vc = AddJZGongGaoViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
