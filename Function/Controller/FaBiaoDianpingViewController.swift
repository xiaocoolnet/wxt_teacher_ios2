//
//  FaBiaoDianpingViewController.swift
//  WXT_Teacher
//
//  Created by 李春波 on 16/3/30.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class FaBiaoDianpingViewController: UIViewController,sendnameidArray,sendteachernameidArray {

    let ed = UITextField()
    var array = NSMutableArray()
     let lbl1 = UILabel()
    let lbl2 = UILabel()
    var type = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "点评"
        self.view.backgroundColor = UIColor.whiteColor()
        
        let scrol = UIScrollView()
        scrol.frame = CGRectMake(0, 0, WIDTH, HEIGHT)
        self.view.addSubview(scrol)
        
        
        
       
        let v = UIView()
        v.frame = CGRectMake(0, 0, self.view.frame.size.width, 60)
        v.backgroundColor = UIColor.whiteColor()
        scrol.addSubview(v)
        if type==2 {
          v.hidden = true
        }
    
        lbl1.frame = CGRectMake(10, 20, 100, 20)
        lbl1.text = "选择接收人"
        lbl1.font = UIFont.systemFontOfSize(15)
        lbl1.textColor = wenziColor
        v.addSubview(lbl1)
        
        
        
        lbl2.frame = CGRectMake(WIDTH-30-60, 20, 60, 20)
        lbl2.text = ""
        lbl2.font = UIFont.systemFontOfSize(15)
        lbl2.textColor = wenziColor
        v.addSubview(lbl2)
        
        let btn1 = UIButton(type: .Custom)
        btn1.frame = CGRectMake(WIDTH-30, 20, 20, 20)
        btn1.setImage(UIImage(named: "箭头"), forState: .Normal)
        btn1.addTarget(self, action: #selector(self.choosePeople), forControlEvents: .TouchUpInside)
        v.addSubview(btn1)
        if type==2 {
            btn1.hidden = true
        }

//        let rightItem = UIBarButtonItem(title: "发表", style: .Done, target: self, action: #selector(TiXingJiaZhangViewController.FaSong))
//        self.navigationItem.rightBarButtonItem = rightItem
//        self.contentTextView.frame = CGRectMake(8, 5, self.view.bounds.width - 16, 200)
//        self.contentTextView.font = UIFont.systemFontOfSize(15)
//        self.contentTextView.placeholder = "请输入点评内容～不能超过200字啦"
//        self.contentTextView.addMaxTextLengthWithMaxLength(200) { (contentTextView) -> Void in
//            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
//            hud.mode = MBProgressHUDMode.Text
//            hud.labelText = "超过200字啦"
//            hud.margin = 10.0
//            hud.removeFromSuperViewOnHide = true
//            hud.hide(true, afterDelay: 3)
//        }
//        self.view.addSubview(self.contentTextView)
        let xuanView = UIView()
        xuanView.frame = CGRectMake(0, v.frame.maxY+5, WIDTH, 250)
        scrol.addSubview(xuanView)
        
        let diview = UIView()
        diview.frame = CGRectMake(0, xuanView.frame.minY, WIDTH, 10)
        diview.alpha = 0.2
        diview.backgroundColor = UIColor.grayColor()
        scrol.addSubview(diview)
        
        
        let v1 = DianPingView(frame: CGRectMake(0, 0, WIDTH, 50), name: "学习",type:1)
        let v2 = DianPingView(frame: CGRectMake(0, 50, WIDTH, 50), name: "动手能力",type:1)
        let v3 = DianPingView(frame: CGRectMake(0, 50*2, WIDTH, 50), name: "唱歌",type:1)
        let v4 = DianPingView(frame: CGRectMake(0, 50*3, WIDTH, 50), name: "劳动",type:1)
        let v5 = DianPingView(frame: CGRectMake(0, 50*4, WIDTH, 50), name: "应变能力",type:1)
        
        array.addObject(v1)
        array.addObject(v2)
        array.addObject(v3)
        array.addObject(v4)
        array.addObject(v5)
        xuanView.addSubview(v1)
        xuanView.addSubview(v2)
        xuanView.addSubview(v3)
        xuanView.addSubview(v4)
        xuanView.addSubview(v5)

        ed.frame = CGRectMake(10, xuanView.frame.maxY, WIDTH-20, 150)
        ed.placeholder = "孩子在校表现..."
        scrol.addSubview(ed)
        
        let diview2 = UIView()
        diview2.frame = CGRectMake(0, ed.frame.minY, WIDTH, 10)
        diview2.alpha = 0.2
        diview2.backgroundColor = UIColor.grayColor()
        scrol.addSubview(diview2)
        
        let btnView = UIView()
        btnView.frame = CGRectMake(20, ed.frame.maxY+10, WIDTH-40, 50)
        scrol.addSubview(btnView)

        let btnleft = UIButton()
        btnleft.frame = CGRectMake(0, 0, btnView.frame.width/2-10, btnView.frame.height)
        btnleft.setTitle("继续点评", forState: UIControlState.Normal)
        btnleft.backgroundColor = UIColor.orangeColor()
        btnleft.cornerRadius = 10
        btnView.addSubview(btnleft)
        
        let btnright = UIButton()
        btnright.frame = CGRectMake(btnleft.frame.maxX+20, 0, btnView.frame.width/2-10, btnView.frame.height)
        btnright.setTitle("点评", forState: UIControlState.Normal)
        btnright.addTarget(self, action: #selector(self.FaSong), forControlEvents: UIControlEvents.TouchUpInside)
        btnright.backgroundColor = UIColor(red: 155/255.0, green: 229 / 255.0, blue: 180 / 255.0, alpha: 1.0)
        btnright.cornerRadius = 10
        btnView.addSubview(btnright)

        
        
        
        scrol.contentSize = CGSizeMake(WIDTH, v.frame.height+xuanView.frame.height+ed.frame.height+btnView.frame.height+10)
        
    }
    
    func FaSong(){
        print("发送消息")
        if idStr == "" {
            messageHUD(self.view, messageData: "请选择接受人！")
            return
        }
        if ed.text == nil {
            messageHUD(self.view, messageData: "请填写点评信息！")
            return
        }
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=teacher&a=AddTeacherComment"
        let teacherid = NSUserDefaults.standardUserDefaults().stringForKey("userid")
        let studentid = idStr

        let learn  = array.objectAtIndex(0) as! DianPingView
        let work  = array.objectAtIndex(1) as! DianPingView
        let sing  = array.objectAtIndex(2) as! DianPingView
        let labour  = array.objectAtIndex(3) as! DianPingView
        let strain  = array.objectAtIndex(4) as! DianPingView
        let param = [
            "teacherid":teacherid,
            "studentid":studentid,
            "content":ed.text,
            "learn":String(learn.tag),
            "work":String(work.tag),
            "sing":String(sing.tag),
            "labour":String(labour.tag),
            "strain":String(strain.tag),
            ]
       
        Alamofire.request(.POST, url, parameters: param as? [String : String]).response{request , response , json , error in
            if(error != nil){
            
            }
            else{
                print("request是")
                print(request!)
                print("====================")
                let status = MineModel(JSONDecoder(json!))
                print("状态是")
                print(status.status)
                if(status.status == "error"){
                    let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    hud.mode = MBProgressHUDMode.Text
                    hud.labelText = status.errorData
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true,afterDelay: 1)
                }
                if(status.status == "success"){
                    print("success成功")
                    self.navigationController?.popViewControllerAnimated(true)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func choosePeople(){
        let vc = ChooseReciveViewController()
        vc.delegate=self
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    var idStr = ""
    var genre = String()
    func sendnameid(name: NSMutableArray, id: NSMutableArray) {
        lbl1.text="\(name.componentsJoinedByString(","))"
        lbl2.text = "共\(name.count)人"
        idStr=id.componentsJoinedByString(",")
    }
    func sendteachernameid(name: NSMutableArray, id: NSMutableArray) {
        lbl1.text="\(name.componentsJoinedByString(","))+共\(name.count)人"
        lbl2.text = "共\(name.count)人"
        idStr=id.componentsJoinedByString(",")
    }

}




    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


