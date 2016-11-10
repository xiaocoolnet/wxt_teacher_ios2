//
//  AddHomeworkViewController.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/6/30.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire
import BSImagePicker
import Photos

class AddHomeworkViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate,sendnameidArray,sendSubiectDelegate{

    var  HWtableview = UITableView()
    var addPictureBtn = UIButton()
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
            cell.textLabel?.text="选择接收人"
            cell.accessoryType = .DisclosureIndicator
            nameL.frame=CGRectMake(frame.width-120, 10, 90, 20)
            nameL.textAlignment = .Right
            nameL.text="接收人"
            nameL.textColor=wenziColor
            cell.contentView.addSubview(nameL)
            tableView.rowHeight=40
        }else if indexPath.row==2{
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
         
            addPictureBtn.frame = CGRectMake(10,160, 80, 80)
            addPictureBtn.setBackgroundImage(UIImage(named: "add2"), forState: UIControlState.Normal)
            addPictureBtn.layer.borderWidth = 1.0
            addPictureBtn.layer.borderColor = UIColor.grayColor().CGColor
            addPictureBtn.addTarget(self, action: #selector(self.AddPictrures), forControlEvents: UIControlEvents.TouchUpInside)
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
            
        }else if indexPath.row==3{
            cell.textLabel?.text="定时发送"
            HWtableview.rowHeight=44
        }else if indexPath.row==4{
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
            let vc = ChooseReciveViewController()
            vc.delegate=self
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    func sendSubject(name: String) {
        kechengL.text=name
    }
    func sendSubjectWithId(name: String, id: String) {
        
    }
    func sendnameid(name: NSMutableArray, id: NSMutableArray) {
        nameL.text=name.componentsJoinedByString(",")
        self.id=id.componentsJoinedByString(",")
    }
    override func viewWillAppear(animated: Bool) {
//        HWtableview.reloadData()
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
        self.imageUrll = self.imagePath.componentsJoinedByString(",")
        print(self.imageUrll!)
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.mode = MBProgressHUDMode.Text
        hud.margin = 10
        hud.removeFromSuperViewOnHide = true
        hud.labelText = "上传完成"
        hud.hide(true, afterDelay: 1)
        self.isuploading = false    }
    func addHomework(){
        UpdatePic()
        GETDate(self.id)
    }
    //http://wxt.xiaocool.net/index.php?g=apps&m=teacher&a=addhomework&teacherid=597&title=周四作业&content=作业内容，快来看&subject=语文&receiverid=597&picture_url=1.png,2.png
    //MARK: - 发布作业
    func GETDate(id:String){
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=teacher&a=addhomework"
        let defalutid = NSUserDefaults.standardUserDefaults()
        let userid = defalutid.stringForKey("userid")
        let param = [
            "teacherid" : userid,
            "receiverid" : id,
            "picture_url" : self.imageUrll,
            "content" : contentTextView.text!,
            "title":"作业",
            "subject":kechengL.text!

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
        return itemCount
    }
    //    分区数
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    //    单元格
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
