//
//  XiaoXiQunFaViewController.swift
//  WXT_Teacher
//
//  Created by apple on 16/4/7.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import YYWebImage
import MBProgressHUD
import MJRefresh

class XiaoXiQunFaViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let table = UITableView()
 
    let arrayPeople = NSMutableArray()
    
    var dataSource = FSendList()
    
    var heightrow = CGFloat()
    
    
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = true
//                self.DropDownUpdate()
        self.loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heightrow = 100
        self.title = "消息群发"
        self.createTable()
//        self.loadData()

        DropDownUpdate()
    }
    //    开始刷新
    func DropDownUpdate(){
        self.table.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.loadData()
            self.table.mj_header.endRefreshing()
        })
         self.table.mj_header.beginRefreshing()
    }
    //    创建表
    func createTable(){
        table.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-40)
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .None
        table.backgroundColor = RGBA(242.0, g: 242.0, b: 242.0, a: 1)
        self.view.addSubview(table)

        let rightItem=UIBarButtonItem(image: UIImage(named: "add3"), landscapeImagePhone: UIImage(named: "add3"), style: .Done, target: self, action: #selector(addQunfa))
        
        self.navigationItem.rightBarButtonItem = rightItem
        table.registerNib(UINib.init(nibName: "GroupNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "GroupNewsCellID")
    }
    //    加载数据
    func loadData(){
        
        //  http://wxt.xiaocool.net/index.php?g=Apps&m=Message&a=user_reception_message&receiver_user_id=682
        //
        //下面两hid句代码是从缓存中取出userid（入参）值
        let defalutid = NSUserDefaults.standardUserDefaults()
        let chid = defalutid.stringForKey("userid")
        let url = "http://wxt.xiaocool.net/index.php?g=Apps&m=Message&a=user_reception_message"
        let param = [
            "receiver_user_id":chid!,
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

                    
                    self.dataSource = FSendList(status.data!)
                    
                    self.table.reloadData()
                    
                }
            }

        }
    }

    //    分区数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    //    行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.objectlist.count
    }
    //    行高
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return heightrow
    }
    //    单元格
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: String(indexPath.row))
        
        cell.selectionStyle = .None
        // 修改之后
        let model = self.dataSource.objectlist[indexPath.row]
        let user = NSUserDefaults.standardUserDefaults()
        
        
        let messageModel = model.send_message
        let receiveModel = model.receiver
        
        
        //群发内容
        let contentLabel = UILabel()
        contentLabel.textColor = neirongColor
        contentLabel.font = neirongfont
        contentLabel.text = messageModel.first?.message_content
        if indexPath.row==0 {
            user.setValue(messageModel.first?.message_content, forKey: "qunfa")
        }
        
        cell.contentView.addSubview(contentLabel)
        //发送人前面的小图标
        let fromimageView = UIImageView()
        fromimageView.image = UIImage.init(named: "ic_fasong")
        cell.contentView.addSubview(fromimageView)
        //发送人
        let teacherLabel = UILabel()
        teacherLabel.font = timefont
        teacherLabel.text=messageModel.first?.send_user_name
        teacherLabel.textColor = timeColor
        cell.contentView.addSubview(teacherLabel)
        // 时间
        let timeLabel = UILabel()
        timeLabel.text = changeTime((model.send_message.first?.message_time)!)
        timeLabel.textColor = timeColor
        timeLabel.font = timefont
        cell.contentView.addSubview(timeLabel)
        
        //已读未读
        let readStatusLabel = UILabel()
        readStatusLabel.textColor = UIColor.orangeColor()
        readStatusLabel.font = neirongfont
        cell.contentView.addSubview(readStatusLabel)
        
        //计算已读未读人数
        let allReader = receiveModel.count
        let array = NSMutableArray()
        for i in 1...receiveModel.count {
            let str = receiveModel[i - 1].read_time
            if str == "" {
                array.addObject(str)
                print(receiveModel[i - 1].receiver_user_name)
            }
        }
        readStatusLabel.text = "总发\(allReader) 已读 \(allReader-array.count) 未读 \(array.count)"
        
        // 计算群发内容高度
        let options : NSStringDrawingOptions = NSStringDrawingOptions.UsesLineFragmentOrigin
        let screenBounds:CGRect = UIScreen.mainScreen().bounds
        let boundingRect = String(contentLabel.text).boundingRectWithSize(CGSizeMake(screenBounds.width, 0), options: options, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(17)], context: nil)
        let contentheight = boundingRect.size.height
   

        
        //  图片高度
        var image_h = CGFloat()
        //获取的图片数组
        let pic = model.picture
        var pics = Array<String>()
        for item in pic {
            pics.append(item.picture_url)
        }
        let picView = NinePicView(frame:CGRectMake(0, boundingRect.size.height + 10, WIDTH,0),pic:pics,vc:self)
        cell.contentView.addSubview(picView)
        image_h = picView.image_h

            
       
        //设置各个控件的位置及其宽高
        contentLabel.frame = CGRectMake(10, 10, WIDTH - 20, contentheight)
        fromimageView.frame = CGRectMake(10, contentLabel.frame.height + 10 + image_h + 10, 18, 18)
        teacherLabel.frame = CGRectMake(fromimageView.frame.maxX+5, contentLabel.frame.height + 10 + image_h + 10 , 100, 20)
        timeLabel.frame = CGRectMake(WIDTH - 150, contentLabel.frame.height + 10 + image_h + 10, 140, 20)
        timeLabel.textAlignment = NSTextAlignment.Right
        

        //分割线
        let line = UILabel()
        line.frame = CGRectMake(1,contentLabel.frame.height + 10 + image_h + 10 + 20 + 3, WIDTH - 2, 0.5)
        line.backgroundColor = dividerColor
        cell.addSubview(line)
        readStatusLabel.frame = CGRectMake(10, line.frame.maxY+3, WIDTH-20, 20)
        

        //tableview的分割线
        let grayView = UIView()
        grayView.frame = CGRectMake(0, readStatusLabel.frame.maxY, WIDTH, 20)
        grayView.backgroundColor = RGBA(242.0, g: 242.0, b: 242.0, a: 1)
        cell.contentView.addSubview(grayView)
     
        self.heightrow = 10 + contentLabel.frame.height + 10 + image_h + 10 + 20 + 3 + 20 + 6 + 5
        debugPrint(self.heightrow)
        
        return cell
    }
    func clickBtn(sender:UIButton){
        let vc = GroupPicViewController()
        vc.arrayInfo = self.dataSource.objectlist[(sender.tag)].picture
        vc.nu = vc.arrayInfo.count
        self.navigationController?.pushViewController(vc, animated: true)
        
    }


    
    //    单元格点击事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let vc = GroupNewsDetailViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    //    点赞
    func dianZan(sender:UIButton){
        let btn:UIButton = sender
        
        //        let homeworkInfo = self.homeworkSource.homeworkList[btn.tag]
        if btn.selected {
            btn.selected = false
            //            self.xuXiaoDianZan(homeworkInfo.id!)
        }else{
            btn.selected = true
            //            self.getDianZan(homeworkInfo.id!)
        }
    }
//添加群发消息
    func addQunfa(){
        let vc = AddQunFaViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    }
