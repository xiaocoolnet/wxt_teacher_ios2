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

class AddJZGongGaoViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,sendnameidArray,UICollectionViewDataSource,UICollectionViewDelegate,sendteachernameidArray{

    var tableview = UITableView()
    var nameL = UILabel()
    var titleTF = UITextField()
    var contentTV = UITextView()
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
            cell.textLabel?.text="选择接收人"
            cell.accessoryType = .DisclosureIndicator
            nameL.frame=CGRectMake(frame.width-200, 10, 90, 20)
            nameL.textAlignment = .Left
            nameL.text="选择接收人"
            nameL.textColor=wenziColor
            numL.frame=CGRectMake(frame.width-110, 10, 70, 20)
            numL.textColor=wenziColor
            cell.contentView.addSubview(numL)
            cell.contentView.addSubview(nameL)
            tableView.rowHeight=40
        }else if indexPath.row==1{
            cell.textLabel?.text="公告标题"
            titleTF.frame=CGRectMake(100, 10, frame.width-120, 20)
            titleTF.textColor=wenziColor
            cell.contentView.addSubview(titleTF)
            tableView.rowHeight=40
            
        }else if indexPath.row==2{
            let lable = UILabel(frame: CGRectMake(15,10,100,20))
            lable.text="公告内容"
            cell.contentView.addSubview(lable)
            contentTV.frame=CGRectMake(5, 40, frame.width-10, 100)
            contentTV.layer.borderWidth=1
            contentTV.layer.cornerRadius=5
            contentTV.layer.borderColor=UIColor.grayColor().CGColor
            cell.contentView.addSubview(contentTV)
            tableView.rowHeight=150
        }else{
            addPictureBtn.frame = CGRectMake(8, 15, 80, 80)
            addPictureBtn.setBackgroundImage(UIImage(named: "add2"), forState: UIControlState.Normal)
            addPictureBtn.layer.borderWidth = 1.0
            addPictureBtn.layer.borderColor = UIColor.grayColor().CGColor
            addPictureBtn.addTarget(self, action: #selector(NewBlogViewController.AddPictrures), forControlEvents: UIControlEvents.TouchUpInside)
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
        return itemCount
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        print("显示")
        print(self.pictureArray[indexPath.row])
        let cell:ImageCollectionViewCell  = collectV!.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath) as! ImageCollectionViewCell
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
    
    override func viewWillAppear(animated: Bool) {
        if(self.i>9){
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "最多选择9张图片哦"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 2)
        }
    }
    
    func AddPictrures(){
        let vc = BSImagePickerViewController()
        vc.maxNumberOfSelections = 9
        bs_presentImagePickerController(vc, animated: true,
                                        select: { (asset: PHAsset) -> Void in
            }, deselect: { (asset: PHAsset) -> Void in
            }, cancel: { (assets: [PHAsset]) -> Void in
            }, finish: { (assets: [PHAsset]) -> Void in
                self.getAssetThumbnail(assets)
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    self.collectV!.reloadData()
                }
            }, completion: nil)
    }
    
    func getAssetThumbnail(asset: [PHAsset]) -> UIImage {
        var thumbnail = UIImage()
        i+=asset.count
        if(i>9){
        }
        else{
            print("选择的图片有\(i)张")
            if(itemCount == 0){
                itemCount = asset.count + 1
                self.pictureArray.insertObject("", atIndex: 0)
            }
            else{
                itemCount += asset.count
            }
            let manager = PHImageManager.defaultManager()
            let option = PHImageRequestOptions()
            option.synchronous = true
            for j in 0..<asset.count{
                manager.requestImageForAsset(asset[j], targetSize: CGSize(width: 80.0, height: 80.0), contentMode: .AspectFit, options: option, resultHandler: {(result, info)->Void in
                    thumbnail = result!
                    print("图片是")
                    var temImage:CGImageRef = thumbnail.CGImage!
                    temImage = CGImageCreateWithImageInRect(temImage, CGRectMake(0, 0, 80, 80))!
                    let newImage = UIImage(CGImage: temImage)
                    self.imageData.append(UIImageJPEGRepresentation(newImage, 1)!)
                    self.pictureArray.addObject(newImage)
                })
            }
        }
        return thumbnail
    }
    
    func addDaijie(){
        if(i != 0){
            self.UpdatePic()
        }
        if PandKong() {
            GETDate(self.idStr)
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    func UpdatePic(){
        for i in 0..<self.imageData.count{
            let userid = NSUserDefaults.standardUserDefaults()
            let uid = userid.stringForKey("userid")
            let RanNumber = String(arc4random_uniform(1000) + 1000)
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyyMMddHHmmss"
            let dateStr = dateFormatter.stringFromDate(NSDate())
            let imageName = uid! + RanNumber + dateStr
            
            isuploading = true
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
                ConnectModel.uploadWithImageName(imageName, imageData:self.imageData[i], URL: "WriteMicroblog_upload", finish: { (data) -> Void in
                    print("返回值")
                    print(data)
                })}
            //self.imagePath.addObject("uploads/microblog/" + RanNumber + ".png")
            
            self.imagePath.addObject(imageName + ".png")
        }
        self.imageUrl = self.imagePath.componentsJoinedByString(",")
        print(self.imageUrl!)
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.mode = MBProgressHUDMode.Text
        hud.margin = 10
        hud.removeFromSuperViewOnHide = true
        hud.labelText = "上传完成"
        hud.hide(true, afterDelay: 1)
        self.isuploading = false
    }
    
    //http://wxt.xiaocool.net/index.php?g=apps&m=school&a=publishnotice&userid=597&type=1&title=标题&content=内容&photo=11.jpg&reciveid=12
    //MARK: - 发布通知公告
    func GETDate(id:String){
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=school&a=publishnotice"
        let defalutid = NSUserDefaults.standardUserDefaults()
        let userid = defalutid.stringForKey("userid")
        let param = [
            "userid" : userid,
            "reciveid" : id,
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
                    
                }
            }
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
