//
//  AddJZGongGaoViewController.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/8/11.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos
import Alamofire
import MBProgressHUD
import TZImagePickerController
class AddJZGongGaoViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,sendnameidArray,UICollectionViewDataSource,UICollectionViewDelegate,sendteachernameidArray,TZImagePickerControllerDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    var tableview = UITableView()
    var nameL = UILabel()
    var titleTF = BRPlaceholderTextView()
    var contentTV = BRPlaceholderTextView()
    var idStr = String()
    var addPictureBtn = UIButton()
    var collectV:UICollectionView?
    var flowLayout = UICollectionViewFlowLayout()
    let contentTextView = BRPlaceholderTextView()
    var itemCount = 0
    var imagePath = NSMutableArray()
    var pictureArray = NSMutableArray()
    var i = 0
    var imageData:[NSData] = []
    var isuploading = false
    var imageUrl:String?
    var photoContent = String()
    var type = String()
    var genre = String()
    var numL = UILabel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.frame=CGRectMake(0, 0, frame.width, frame.height)
        tableview.delegate=self
        tableview.dataSource=self
        tableview.separatorStyle = .None
        self.view.addSubview(tableview)
        let rightItem = UIBarButtonItem(title: "发送", style: UIBarButtonItemStyle.Done, target: self, action: #selector(addDaijie))
        self.navigationItem.rightBarButtonItem = rightItem
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 4
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = UITableViewCell()
        cell.selectionStyle = .None
        if indexPath.row==0 {
            cell.accessoryType = .DisclosureIndicator
            nameL.frame=CGRectMake(10, 10, 90, 20)
            nameL.textAlignment = .Left
            nameL.font = neirongfont
            nameL.text="选择接收人"
            nameL.textColor=wenziColor
            numL.frame=CGRectMake(frame.width-110, 10, 70, 20)
            numL.textColor=wenziColor
            cell.contentView.addSubview(numL)
            cell.contentView.addSubview(nameL)
            addDividerLine(cell.contentView, y: 35, height: 10)
            tableView.rowHeight=40
        }else if indexPath.row==1{
            titleTF.frame=CGRectMake(10, 10, frame.width-120, 30)
            titleTF.textColor=wenziColor
            titleTF.font = neirongfont
            titleTF.textAlignment = .Left
            titleTF.placeholder = "公告标题"
            cell.contentView.addSubview(titleTF)
            addDividerLine(cell.contentView, y: 49, height: 1)
            tableView.rowHeight=50
            
        }else if indexPath.row==2{
            contentTV.frame=CGRectMake(10, 10, frame.width-10, 140)
            contentTV.layer.borderColor=UIColor.grayColor().CGColor
            contentTV.placeholder = "公告内容"
            contentTV.font = neirongfont
            cell.contentView.addSubview(contentTV)
            addDividerLine(cell.contentView, y: 150-10, height: 10)
            tableView.rowHeight=150
        }else{
//            addPictureBtn.frame = CGRectMake(8, 15, 80, 80)
//            addPictureBtn.setBackgroundImage(UIImage(named: "add2"), forState: UIControlState.Normal)
//            addPictureBtn.layer.borderWidth = 1.0
//            addPictureBtn.layer.borderColor = UIColor.grayColor().CGColor
//            addPictureBtn.addTarget(self, action: #selector(NewBlogViewController.AddPictrures), forControlEvents: UIControlEvents.TouchUpInside)
            flowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
            flowLayout.itemSize = CGSizeMake(80,80)
            self.collectV = UICollectionView(frame: CGRectMake(8, 15, UIScreen.mainScreen().bounds.width-30, 359), collectionViewLayout: flowLayout)
            self.collectV?.registerClass(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
            self.collectV?.delegate = self
            self.collectV?.dataSource = self
            self.collectV?.backgroundColor = UIColor.clearColor()
            cell.addSubview(self.contentTextView)
            cell.addSubview(self.collectV!)
            cell.addSubview(addPictureBtn)
            tableView.rowHeight=359
        }
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row==0 {
            if type=="1"{
            let vc = ChooseReciveViewController()
            vc.delegate=self
                genre="1"
            self.navigationController?.pushViewController(vc, animated: true)
            }else{
                let vc = ChooseTeacherViewController()
                vc.delegate=self
                genre="2"
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else if indexPath.row==3{
           
        }
    }
    func sendnameid(name: NSMutableArray, id: NSMutableArray) {
        nameL.text=name.componentsJoinedByString(",")
        numL.text="共\(name.count)人"
        idStr=id.componentsJoinedByString(",")
    }
    func sendteachernameid(name: NSMutableArray, id: NSMutableArray) {
        nameL.text=name.componentsJoinedByString(",")
        numL.text="共\(name.count)人"
        idStr=id.componentsJoinedByString(",")
    }
    func PandKong()->Bool{
        if(nameL.text=="选择家长"){
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请选择家长"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return false
        }
        if(titleTF.text!.isEmpty){
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请输入标题"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return false
        }
        if (contentTV.text!.isEmpty) {
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请输入内容"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return false
            
        }

        
        return true
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
    
    
    func imagePickerController(picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [AnyObject]!, isSelectOriginalPhoto: Bool, infos: [[NSObject : AnyObject]]!) {
        //        self.photoArray.removeAllObjects()
        for imagess in photos {
            pictureArray.addObject(imagess)
        }
        print(self.pictureArray.count)
        self.collectV?.reloadData()
        
        
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
    
    func addDaijie(){
       
            self.UpdatePic()
       
    }
    func UpdatePic(){
        if self.idStr.isEmpty {
            messageHUD(self.view, messageData: "请选择接收人！")
            return
        }
        if contentTV.text.isEmpty||titleTF.text.isEmpty {
            messageHUD(self.view, messageData: "请输入标题或内容！")
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
        GETDate()

    }
    
    //http://wxt.xiaocool.net/index.php?g=apps&m=school&a=publishnotice&userid=597&type=1&title=标题&content=内容&photo=11.jpg&reciveid=12
    //MARK: - 发布通知公告
    func GETDate(){
       
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=school&a=publishnotice"
        let defalutid = NSUserDefaults.standardUserDefaults()
        let userid = defalutid.stringForKey("userid")
        let param = [
            "userid" : userid,
            "reciveid" : self.idStr,
            "photo" : imageUrl,
            "content" : contentTV.text!,
            "type":"1",
            "title":titleTF.text!,
            "genre":genre
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
