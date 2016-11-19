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

class AddDaiBanViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,sendnameidArray,UICollectionViewDataSource,UICollectionViewDelegate,sendteacherArray{
    
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
            nameL.frame=CGRectMake(10, 10, 90, 20)
            nameL.textAlignment = .Left
            nameL.text="选择待办人"
            nameL.font = neirongfont
            nameL.textColor=wenziColor
            cell.contentView.addSubview(nameL)
            cell.accessoryType = .DisclosureIndicator
            addDividerLine(cell.contentView, y: 40-5, height: 5)
            tableView.rowHeight=40
        }else if indexPath.row==1{
            titleTF.frame=CGRectMake(10, 10, frame.width-120, 30)
            titleTF.placeholder = "待办标题"
            titleTF.textColor=wenziColor
            titleTF.font = neirongfont
            cell.contentView.addSubview(titleTF)
            addDividerLine(cell.contentView, y: 39, height: 1)
            tableView.rowHeight=40
            
        }else if indexPath.row==2{
            contentTV.frame=CGRectMake(10, 40, frame.width-10, 100)
            contentTV.layer.borderColor=UIColor.grayColor().CGColor
            contentTV.placeholder = "待办内容"
            contentTV.textColor = neirongColor
            contentTV.font = neirongfont
            cell.contentView.addSubview(contentTV)
            addDividerLine(cell.contentView, y: 140, height: 10)
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
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                let vc = TeacherListViewController()
                vc.delegate=self
                vc.type="1"
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else if indexPath.row==3{
            
        }
    }
    func sendnameid(name: NSMutableArray, id: NSMutableArray) {
        nameL.text=name.componentsJoinedByString(",")
        idStr=id.componentsJoinedByString(",")
    }
    func sendteachernameid(name: String, id: String) {
        nameL.text=name
        idStr=id
    }
    func PandKong()->Bool{
        if(nameL.text=="选择待办人"){
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请选择接收人"
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
            let deleteBT = UIButton()
            
            deleteBT.frame=CGRectMake(80-20, 0, 20, 20)
            cell.imageView.addSubview(deleteBT)
            deleteBT.setImage(UIImage(named: "wrong"), forState: .Normal)
            deleteBT.addTarget(self, action: #selector(deletephoto(_:)), forControlEvents: .TouchUpInside)
            deleteBT.tag=indexPath.item
            cell.contentView.addSubview(cell.imageView)
            
        }
        return cell
    }
    func deletephoto(sender:UIButton){
        print(sender.tag)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return CGFloat(0)
    }
    
    //    上下间距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return CGFloat(6)
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
                //  这里的参数应该喝照片的大小一致（需要进行判断）
                manager.requestImageForAsset(asset[j], targetSize: PHImageManagerMaximumSize, contentMode: .AspectFit, options: option, resultHandler: {(result, info)->Void in
                    //  设置像素
                    option.resizeMode = PHImageRequestOptionsResizeMode.Exact
                    let downloadFinined = !((info!["PHImageResultIsDegradedKey"]?.boolValue)!)
                    
                    //                let downloadFinined:Bool = !((info!["PHImageCancelledKey"]?.boolValue)! ?? false) && !((info!["PHImageErrorKey"]?.boolValue)! ?? false) && !((info!["PHImageResultIsDegradedKey"]?.boolValue)! ?? false)
                    if downloadFinined == true {
                        thumbnail = result!
                        print(" print(result?.images)")
                        //  改变frame
                        print(result)
                        print("图片是")
                        var temImage:CGImageRef = thumbnail.CGImage!
                        //                    temImage = CGImageCreateWithImageInRect(temImage, CGRectMake(0, 0, 1000, 1000))!
                        let newImage = UIImage(CGImage: temImage)
                        //  压缩最多1  最少0
                        self.imageData.append(UIImageJPEGRepresentation(newImage, 0)!)
                        self.pictureArray.addObject(newImage)
                        
                    }
                    //                thumbnail = result!
                    
                    //
                    
                })
            }
        }
        return thumbnail
    }
    func byScalingToSize(image:UIImage,targetSize:CGSize) ->(UIImage){
        let sourceImage = image
        var newImage = UIImage()
        UIGraphicsBeginImageContext(targetSize)
        var thumbnailRect = CGRectZero;
        thumbnailRect.origin = CGPointZero;
        thumbnailRect.size.width  = targetSize.width;
        thumbnailRect.size.height = targetSize.height;
        sourceImage.drawInRect(thumbnailRect)
        newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
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
        self.isuploading = false    }
    //http://wxt.xiaocool.net/index.php?g=apps&m=school&a=publishnotice&userid=597&type=1&title=标题&content=内容&photo=11.jpg&reciveid=12
    //MARK: - 发布待办事项
    func GETDate(id:String){
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=school&a=addschedule"
        let defalutid = NSUserDefaults.standardUserDefaults()
        let userid = defalutid.stringForKey("userid")
        let scid = defalutid.stringForKey("schoolid")
        let param = [
            "userid" : userid,
            "reciveid" : id,
            "photolist" : imageUrl,
            "content" : contentTV.text!,
            "title":titleTF.text!,
            "schoolid":scid
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
