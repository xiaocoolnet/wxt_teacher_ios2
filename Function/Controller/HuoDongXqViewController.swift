//
//  HuoDongXqViewController.swift
//  WXT_Teacher
//
//  Created by 李春波 on 16/3/21.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire
import TZImagePickerController
class HuoDongXqViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,sendnameidArray,UICollectionViewDelegate,UICollectionViewDataSource,TZImagePickerControllerDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,sendTimeDelegate {
    
    var tableview = UITableView()
    var titleTF = BRPlaceholderTextView()
    var contentTV = BRPlaceholderTextView()
    var startBT = UIButton()
    var endBT = UIButton()
    var peopleTF = UITextField()
    var phoneTF = UITextField()
    var nameL = UILabel()
    var idstr = String()
    var timetag = String()
    var collectV:UICollectionView?
    var flowLayout = UICollectionViewFlowLayout()
    var pictureArray = NSMutableArray()
    var imageUrl:String?
    var imagePath = NSMutableArray()

    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        self.title = "发布活动"
        let rightItem = UIBarButtonItem(title:"发布",style: .Done,target: self,action: #selector(HuoDongXqViewController.EditKejian))
        self.navigationItem.rightBarButtonItem = rightItem
        tableview.frame=CGRectMake(0, 0, frame.width, frame.height)
        tableview.delegate=self
        tableview.dataSource=self
        self.view.addSubview(tableview)

    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==3 || section==4 {
            return 2
        }else{
            return 1
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        cell.selectionStyle = .None
        if indexPath.section == 0{
            cell.textLabel?.text="选择班级"
            cell.accessoryType = .DisclosureIndicator
            nameL.frame=CGRectMake(frame.width-150, 10, 120, 20)
            nameL.textAlignment = .Right
            nameL.textColor=wenziColor
            nameL.text="请选择"
            cell.contentView.addSubview(nameL)
            tableview.rowHeight=44
        }else if indexPath.section==1{
            titleTF.frame=CGRectMake(10, 10, frame.width-110, 30)
            titleTF.placeholder = "活动标题"
            titleTF.textColor=wenziColor
            cell.contentView.addSubview(titleTF)
            tableview.rowHeight=54
        }else if indexPath.section==2{
            contentTV.frame=CGRectMake(10, 10, frame.width-10, 100)
            contentTV.textColor=wenziColor
            contentTV.placeholder = "活动内容"
            cell.contentView.addSubview(contentTV)
            tableview.rowHeight=140
        }else if indexPath.section==3{
            tableview.rowHeight=44
            cell.accessoryType = .DisclosureIndicator
            if indexPath.row==0 {
                cell.textLabel?.text="活动开始日期"
                startBT.frame=CGRectMake(100, 10, frame.width-110, 20)
                startBT.setTitle("请选择", forState: .Normal)
                startBT.setTitleColor(wenziColor, forState: .Normal)
                startBT.addTarget(self, action: #selector(startTime), forControlEvents: .TouchUpInside)
                cell.contentView.addSubview(startBT)
            }else{
                cell.textLabel?.text="活动结束日期"
                endBT.frame=CGRectMake(100, 10, frame.width-110, 20)
                endBT.setTitleColor(wenziColor, forState: .Normal)
                endBT.setTitle("请选择", forState: .Normal)
                endBT.addTarget(self, action: #selector(endTime), forControlEvents: .TouchUpInside)
                cell.contentView.addSubview(endBT)
            }
        }else if indexPath.section==4{
            tableview.rowHeight=44
            if indexPath.row==0 {
                cell.textLabel?.text="联系人"
                peopleTF.frame=CGRectMake(100, 10, frame.width-110, 20)
                peopleTF.textColor=wenziColor
                peopleTF.placeholder = "请输入"
                cell.contentView.addSubview(peopleTF)
            }else{
                cell.textLabel?.text="联系方式"
                phoneTF.frame=CGRectMake(100, 10, frame.width-110, 20)
                phoneTF.textColor=wenziColor
                phoneTF.placeholder = "请输入"
                cell.contentView.addSubview(phoneTF)
            }
        }else if indexPath.section==5{
            
            flowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
            flowLayout.itemSize = CGSizeMake(80,80)
            self.collectV = UICollectionView(frame: CGRectMake(8, 10, UIScreen.mainScreen().bounds.width-30, 359), collectionViewLayout: flowLayout)
            self.collectV?.registerClass(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
            self.collectV?.delegate = self
            self.collectV?.dataSource = self
            self.collectV?.backgroundColor = UIColor.clearColor()
            cell.contentView.addSubview(self.collectV!)
            tableView.rowHeight = 400
        }
        return cell
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section==0 {
            let vc = ChooseReciveViewController()
            vc.delegate=self
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    func sendnameid(name: NSMutableArray, id: NSMutableArray) {
        let arrayStr = name.componentsJoinedByString(",")
        nameL.text="共\(name.count)人"
        self.tableview.cellForRowAtIndexPath(NSIndexPath.init(forRow: 0, inSection: 0))?.textLabel?.text = arrayStr
        self.idstr=id.componentsJoinedByString(",")
    }
    func startTime(){
        
        let timevc = BirthdayViewController()
        timetag="start"
        timevc.delegate=self
        self.navigationController?.pushViewController(timevc, animated: true)
        
    }
    func endTime(){
       
        let timevc = BirthdayViewController()
        timetag="end"
        timevc.delegate=self
        self.navigationController?.pushViewController(timevc, animated: true)

    }
    func sendTime(time: String) {
        if timetag=="start" {
            startBT.setTitle(time, forState: .Normal)
        }else{
            endBT.setTitle(time, forState: .Normal)
        }
    }
    func imagePickerController(picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [AnyObject]!, isSelectOriginalPhoto: Bool, infos: [[NSObject : AnyObject]]!) {
        //        self.photoArray.removeAllObjects()
        for imagess in photos {
            pictureArray.addObject(imagess)
        }
        print(self.pictureArray.count)
        self.collectV?.reloadData()
        
        
    }

    
    func UpdatePic(){
        if self.idstr.isEmpty {
            messageHUD(self.view, messageData: "请选择接收人")
            return
        }
        if titleTF.text!.isEmpty {
            messageHUD(self.view, messageData: "请输入标题")
            return
        }
        if contentTV.text!.isEmpty {
            messageHUD(self.view, messageData: "请输入内容")
            return
        }
        if peopleTF.text!.isEmpty ||  phoneTF.text!.isEmpty{
            messageHUD(self.view, messageData: "请输入联系人信息")
            return
        }
        if (startBT.titleLabel?.text)!.isEmpty ||  (endBT.titleLabel?.text)!.isEmpty{
            messageHUD(self.view, messageData: "请输入活动时间")
            return
        }
        for ima in pictureArray{
            
            let dataPhoto:NSData = UIImageJPEGRepresentation(ima as! UIImage, 1.0)!
            var myImagess = UIImage()
            myImagess = UIImage.init(data: dataPhoto)!
            
            let data = UIImageJPEGRepresentation(myImagess, 0.1)!
            let chid = NSUserDefaults.standardUserDefaults()
            let studentid = chid.stringForKey("userid")
            let date = NSDate()
            let dateformate = NSDateFormatter()
            dateformate.dateFormat = "yyyy-MM-dd HH:mm"//获得日期
            let time:NSTimeInterval = (date.timeIntervalSince1970)
            let RanNumber = String(arc4random_uniform(1000) + 1000)
            let name = "\(studentid!)baby\(time)\(RanNumber)"
            
            //上传图片
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
                ConnectModel.uploadWithImageName(name, imageData:data, URL: "WriteMicroblog_upload", finish: { (data) -> Void in
                    print("返回值")
                    print(data)
                    
                })
            }
            self.imagePath.addObject(name + ".png")
        }
        self.imageUrl = self.imagePath.componentsJoinedByString(",")
        print(self.imageUrl!)
        EditKejian()
    }

    func AddPictrures(){
        let imagePickerVc = TZImagePickerController.init(maxImagesCount: 9, delegate:self)
        
        print(pictureArray.count)
        print("上传图片")
        let imagePicker = UIImagePickerController();
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePickerVc, animated: true, completion: nil)
    }

    //发布
    func EditKejian(){
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=teacher&a=addactivity"
        
        let classid = NSUserDefaults.standardUserDefaults()
        let clid = classid.stringForKey("classid")
        let userid = NSUserDefaults.standardUserDefaults()
        let uid = userid.stringForKey("userid")
        let starttime = changeTimeThree((startBT.titleLabel?.text)!)
        let endtime = changeTimeThree((endBT.titleLabel?.text)!)
        
        let param = [
            "teacherid":uid!,
            "title":titleTF.text!,
            "content":contentTV.text!,
            "classid":clid,
            "begintime":starttime,
            "endtime":endtime,
            "contactman":peopleTF.text,
            "contactphone":phoneTF.text,
            "isapply":"",
            "receiverid":self.idstr,
            "picture_url":self.imageUrl
        ]
        Alamofire.request(.GET, url, parameters: param as? [String:String]).response { request, response, json, error in
            if(error != nil){
            }
            else{
                print("request是")
                print(request!)
                print("====================")
                let result = Httpresult(JSONDecoder(json!))
                print("状态是")
                print(result.status)
                if(result.status == "error"){
                    let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    hud.mode = MBProgressHUDMode.Text
                    hud.labelText = result.errorData
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 1)
                }
                
                if(result.status == "success"){
                    print("班级活动发表成功")
                    print("Success")
                    self.navigationController?.popViewControllerAnimated(true)
                }
                
            }
            
        }
        
  
    }
    
 
   
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pictureArray.count+1
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        print("显示")
        
        let cell:ImageCollectionViewCell  = collectV!.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath) as! ImageCollectionViewCell
        if indexPath.row==self.pictureArray.count {
            cell.imageView.frame = CGRectMake(0, 0, 80, 80)
            cell.imageView.image = UIImage(named: "add2")
            cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.AddPictrures)))
            cell.contentView.addSubview(cell.imageView)
            return cell
        }
        if(self.pictureArray.count != 0){
            cell.imageView.frame = CGRectMake(0, 0, 80, 80)
            cell.imageView.image = self.pictureArray[indexPath.row] as? UIImage
            cell.contentView.addSubview(cell.imageView)
            return cell
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return CGFloat(0)
    }
    
    //    上下间距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return CGFloat(6)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   }
