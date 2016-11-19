//
//  HappySchoolVC.swift
//  WXT_Parents
//
//  Created by JQ on 16/6/27.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import ImageSlideshow
import MBProgressHUD
class HappySchoolVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //  滚动视图的设置
    let imageScrollView = ImageSlideshow()
    let myTableView = UITableView()
    
    let titLabArr:[String] = ["麻辣学堂","营养食谱","睡前故事","经典儿歌","育儿百科","儿歌学堂","亲子乐园"]
    let titImgArr:[String] = ["ic_malaxuetang.png","ic_yingyangshipu.png","ic_shuiqiangushi.png","ic_jingdianerge.png","ic_yuerbaike.png","ic_ergexuetang.png","ic_qinzileyuan"]

    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "乐园"
        self.view.backgroundColor = UIColor.whiteColor()
        
        //  类似清华幼儿园界面设计
        //  1.滚动视图
        createImageScrollView()
        //  2.tableView
        createTableView()
       
        //  4.刷新
        //  5.点击事件
    }
    func createImageScrollView(){
        //  1.设置大小
        print(WIDTH * 444.0 / 650 - 64)
        //  需要设置滚动视图的大小
        imageScrollView.frame = CGRectMake(0, 0, WIDTH, 250)
//        self.view.addSubview(imageScrollView)
        myTableView.tableHeaderView = imageScrollView
        //  2.设置图片
        //  3.展示图片
        setImageForScrollView()
    }
    //  设置图片
    func setImageForScrollView(){
        //  设置轮播时间
        imageScrollView.slideshowInterval = 0.2
        //  设置轮播图片
        imageScrollView.setImageInputs([AFURLSource(urlString: "http://pic2.ooopic.com/01/03/51/25b1OOOPIC19.jpg")!, AFURLSource(urlString: "http://ppt360.com/background/UploadFiles_6733/201012/2010122016291897.jpg")!, AFURLSource(urlString: "http://img.taopic.com/uploads/allimg/130501/240451-13050106450911.jpg")!])
    }
    func createTableView(){
        myTableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT - 64)
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.backgroundColor = RGBA(242.0, g: 242.0, b: 242.0, a: 1)
        myTableView.separatorStyle = .None
        self.view.addSubview(myTableView)
        
        myTableView.registerClass(HappySchoolTableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
   
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
            return self.titLabArr.count
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)as!HappySchoolTableViewCell
        cell.selectionStyle = .None
        
        let model = self.titLabArr[indexPath.row]
        if indexPath.section == 0 {
            cell.imgView.image = UIImage(named: "ic_huodong")
            cell.titleLab.text = "活动"
        }else if indexPath.section == 1 {
            cell.imgView.image = UIImage(named: self.titImgArr[indexPath.row])
            cell.titleLab.text = model
            let line = UILabel()
            line.backgroundColor = UIColor.lightGrayColor()
            line.frame = CGRectMake(0, 59.0, WIDTH, 0.5)
            cell.contentView.addSubview(line)
            if indexPath.row == 6 {
                line.removeFromSuperview()
            }
        }
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "功能暂未实现，敬请期待"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
//            let vc = ActivityViewController()
//            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.section == 1{
            if indexPath.row == 0 {
                let vc = SpicyClassViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                let vc = HTMLViewController()
                if indexPath.row==1{
                    vc.tit="营养食谱"
                }else if indexPath.row==2{
                    vc.tit="睡前故事"
                }else if indexPath.row==3{
                    vc.tit="经典儿歌"
                }else if indexPath.row==4{
                    vc.tit="育儿百科"
                }else if indexPath.row==6{
                    vc.tit="亲子乐园"
                }
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    



}
