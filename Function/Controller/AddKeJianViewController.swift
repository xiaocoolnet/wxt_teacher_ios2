//
//  AddKeJianViewController.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/9/4.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire
import BSImagePicker
import Photos
import TZImagePickerController
class AddKeJianViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate,sendnameidArray,sendSubiectDelegate,TZImagePickerControllerDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    var  HWtableview = UITableView()
    var addPictureBtn = UIButton()
    let titleTextView = BRPlaceholderTextView()
    let contentTextView = BRPlaceholderTextView()
    var flowLayout = UICollectionViewFlowLayout()
    var collectV:UICollectionView?
    var i = 0
    var pictureArray = NSMutableArray()
    var itemCount = 0
    var kechengL = UILabel()
    var nameL = UILabel()
    var id = String()
    var imageData:[NSData] = []
    var imageUrll:String?
    var imagePath = NSMutableArray()
    var isuploading = false
    var subjectid : String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "发布课件"
        HWtableview.frame=CGRectMake(0, 0, frame.width, frame.height)
        HWtableview.delegate=self
        HWtableview.dataSource=self
        //去掉中间线条
        HWtableview.separatorStyle = .None
        self.view.addSubview(HWtableview)
        let rightItem=UIBarButtonItem(image: UIImage(named: "add3"), landscapeImagePhone: UIImage(named: "add3"), style: .Done, target: self, action: #selector(addHomework))
        self.navigationItem.rightBarButtonItem = rightItem
    }
    //MARK: -  tableview代理方法
    //返回行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 4
    }
    //cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        cell.selectionStyle = .None
        
        if indexPath.row==0 {
            cell.accessoryType = .DisclosureIndicator
            cell.textLabel?.text="选择课程"
            cell.accessoryType = .DisclosureIndicator
            kechengL.frame=CGRectMake(frame.width-120, 10, 90, 20)
            kechengL.textAlignment = .Right
            kechengL.text="选择课程"
            kechengL.textColor=wenziColor
            cell.contentView.addSubview(kechengL)
            tableView.rowHeight=40
            
        }else if indexPath.row==1{
            cell.accessoryType = .DisclosureIndicator
            cell.textLabel?.text="选择班级"
            cell.accessoryType = .DisclosureIndicator
            nameL.frame=CGRectMake(frame.width-120, 10, 90, 20)
            nameL.textAlignment = .Right
            nameL.text="班级"
            nameL.textColor=wenziColor
            cell.contentView.addSubview(nameL)
            tableView.rowHeight=40
        } else if indexPath.row==2{
        
            self.titleTextView.frame = CGRectMake(0, 0, frame.width , 50)
            self.titleTextView.font = UIFont.systemFontOfSize(15)
            self.titleTextView.placeholder = "请输入标题"
            self.titleTextView.addMaxTextLengthWithMaxLength(200) { (contentTextView) -> Void in
                let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                hud.mode = MBProgressHUDMode.Text
                hud.labelText = "超过100字啦"
                hud.margin = 10.0
                hud.removeFromSuperViewOnHide = true
                hud.hide(true, afterDelay: 3)
            }
           cell.addSubview(self.titleTextView)
           tableView.rowHeight=50
        }else if indexPath.row==3{
            self.contentTextView.frame = CGRectMake(0, 0, frame.width , 150)
            self.contentTextView.font = UIFont.systemFontOfSize(15)
            self.contentTextView.placeholder = "请输入内容～不能超过200字啦"
            self.contentTextView.addMaxTextLengthWithMaxLength(200) { (contentTextView) -> Void in
                let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                hud.mode = MBProgressHUDMode.Text
                hud.labelText = "超过200字啦"
                hud.margin = 10.0
                hud.removeFromSuperViewOnHide = true
                hud.hide(true, afterDelay: 3)
            }
            
            flowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
            flowLayout.itemSize = CGSizeMake(80,80)
            self.collectV = UICollectionView(frame: CGRectMake(10, 160, UIScreen.mainScreen().bounds.width-20, 359), collectionViewLayout: flowLayout)
            self.collectV?.registerClass(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
            self.collectV?.delegate = self
            self.collectV?.dataSource = self
            self.collectV?.backgroundColor = UIColor.clearColor()
            cell.addSubview(self.contentTextView)
            cell.addSubview(self.collectV!)
            cell.addSubview(addPictureBtn)
            
            if i<4 {
                HWtableview.rowHeight=240
            }else if i>3 && i<8{
                HWtableview.rowHeight=330
            }else{
                HWtableview.rowHeight=420
            }
            
        }else if indexPath.row==4{
            cell.textLabel?.text="定时发送"
            HWtableview.rowHeight=44
        }else if indexPath.row==5{
            cell.textLabel?.text="是否短信通知"
            HWtableview.rowHeight=44
        }
        return cell
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row==0 {
            let vc = SubjectListViewController()
            vc.delegate=self
            self.navigationController?.pushViewController(vc, animated: true)
            
            
            
        }else if indexPath.row==1{
            let vc = ChooseClassViewController()
            vc.delegate=self
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    func sendSubject(name: String) {
        kechengL.text=name
    }
    
    func sendSubjectWithId(name: String, id: String) {
        self.subjectid = id
    }
    
    func sendnameid(name: NSMutableArray, id: NSMutableArray) {
        nameL.text=name.componentsJoinedByString(",")
        self.id=id.componentsJoinedByString(",")
    }
    override func viewWillAppear(animated: Bool) {
        //        HWtableview.reloadData()
       
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
    func imagePickerController(picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [AnyObject]!, isSelectOriginalPhoto: Bool, infos: [[NSObject : AnyObject]]!) {
        //        self.photoArray.removeAllObjects()
        for imagess in photos {
            pictureArray.addObject(imagess)
        }
        print(self.pictureArray.count)
        self.collectV?.reloadData()
        
        
    }
    
    func UpdatePic(){
        if titleTextView.text!.isEmpty {
            messageHUD(self.view, messageData: "请输入标题")
            return
        }
        if contentTextView.text!.isEmpty {
            messageHUD(self.view, messageData: "请输入内容")
            return
        }
        if self.id.isEmpty {
            messageHUD(self.view, messageData: "请选择班级")
            return
        }
        if self.subjectid!.isEmpty {
            messageHUD(self.view, messageData: "请选择课程")
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
        self.imageUrll = self.imagePath.componentsJoinedByString(",")
        print(self.imageUrll!)
        GETDate()
    }
    
    
    func addHomework(){
        UpdatePic()
        
    }
    //http://wxt.xiaocool.net/index.php?g=apps&m=teacher&a=addhomework&teacherid=597&title=周四作业&content=作业内容，快来看&subject=语文&receiverid=597&picture_url=1.png,2.png
    //MARK: - 发布作业
    func GETDate(){
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=index&a=AddSchoolCourseware"
        let defalutid = NSUserDefaults.standardUserDefaults()
        let schoolid = defalutid.stringForKey("schoolid")
        let userid = defalutid.stringForKey("userid")
        
        let param = [
            "schoolid" : schoolid,
            "classid" : self.id,
            "user_id":userid,
            "picture_url" : self.imageUrll,
            "courseware_content" : contentTextView.text!,
            "courseware_title":titleTextView.text!,
            "subjectid":self.subjectid
            
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
                    hud.labelText = status.errorData
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 1)
                }
                if(status.status == "success"){
                    print("Success")
                    self.navigationController?.popViewControllerAnimated(true)
                }
            }
        }
        
        
    }
    //MARK: - 瀑布流代理方法
    
    //    行数
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pictureArray.count+1
    }
    //    分区数
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    //    单元格
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
    //    每组之间的最小高度
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
