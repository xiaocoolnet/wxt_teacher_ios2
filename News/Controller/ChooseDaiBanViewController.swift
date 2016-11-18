//
//  ChooseDaiBanViewController.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/9/4.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class ChooseDaiBanViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    let tableView = UITableView()
    var dataSource = ChooseTeacherModel()
    var selectAllBtnArray = NSMutableArray()
    var nameLabel = UILabel()
    var nameAry = NSMutableArray()
    var idAry = NSMutableArray()
    var delegate : sendteachernameidArray?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=bkColor
        self.title="接收人"
        // 初始化视图
        initView()
        //刷新数据
        DropDownUpdate()
        
    }
    
    
    func initView() -> Void {
        tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT-64)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None

        self.view.addSubview(tableView)

        
        
    }
    
    //    开始刷新
    func DropDownUpdate(){

    }
    
    
    func loadStudentData(){
        
        //http://wxt.xiaocool.net/index.php?g=apps&m=teacher&a=getteacherclasslistandstudentlist&teacherid=507
        
        let defalutid = NSUserDefaults.standardUserDefaults()
        let chid = defalutid.stringForKey("schoolid")
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=school&a=getteacherinfo"
        let param = [
            "schoolid":chid!,
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
                    //  self.messageSource = sendMessageList(status.data!)
                    
                    self.dataSource = ChooseTeacherModel(status.data!)
                    
                    self.tableView.reloadData()
    
                }
            }
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataSource.objectlist.count;
        
        
    }
    
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("chooseDaibanCell")
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "chooseDaibanCell")
        }
        let model = self.dataSource.objectlist[indexPath.row]
        
        cell?.accessoryType = .DisclosureIndicator
        

        cell!.textLabel?.text = model.name
        
        
        return cell!
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let model = self.dataSource.objectlist[indexPath.row]
        nameAry.addObject(model.name!)
        idAry.addObject(model.id!)
        self.delegate?.sendteachernameid(nameAry, id: idAry)
        self.navigationController?.popViewControllerAnimated(true)
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
