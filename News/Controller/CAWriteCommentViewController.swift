//
//  CAWriteCommentViewController.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/6/2.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos
import MBProgressHUD
import Alamofire

class CAWriteCommentViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate{
    
    var id:String?
    
    var imageData:[NSData] = []
    var isuploading = false
    var imageUrl:String?
    var i = 0
    var imagePath = NSMutableArray()
    var pictureArray = NSMutableArray()
    var addPictureBtn = UIButton()
    var picture = UIImageView()
    let contentTextView = BRPlaceholderTextView()
    var itemCount = 0
    var collectV:UICollectionView?
    var flowLayout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "写评论"
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: .Plain, target: self, action: #selector(CAWriteCommentViewController.sendDone))
        
        //        创建UI
        self.createUI()
    }
    //    创建输入框
    func createUI(){
        self.contentTextView.frame = CGRectMake(8, 5, self.view.bounds.width - 16, 200)
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
        //        添加图片按钮
        addPictureBtn.frame = CGRectMake(8, 215, 80, 80)
        addPictureBtn.setBackgroundImage(UIImage(named: "add2"), forState: UIControlState.Normal)
        addPictureBtn.layer.borderWidth = 1.0
        addPictureBtn.layer.borderColor = UIColor.grayColor().CGColor
        addPictureBtn.addTarget(self, action: #selector(CAWriteCommentViewController.AddPictrures), forControlEvents: UIControlEvents.TouchUpInside)
        //        创建流视图
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
        flowLayout.itemSize = CGSizeMake(80,80)
        self.collectV = UICollectionView(frame: CGRectMake(8, 215, UIScreen.mainScreen().bounds.width-30, 359), collectionViewLayout: flowLayout)
        //        注册
        self.collectV?.registerClass(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
        
        self.collectV?.delegate = self
        self.collectV?.dataSource = self
        self.collectV?.backgroundColor = UIColor.clearColor()
        self.view.addSubview(self.contentTextView)
        self.view.addSubview(self.collectV!)
        self.view.addSubview(addPictureBtn)
    }
    //    图片的个数
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    //    每行几个
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    //    单元格
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell:ImageCollectionViewCell  = collectV!.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath) as! ImageCollectionViewCell
        if(self.pictureArray.count != 0){
            cell.imageView.frame = CGRectMake(0, 0, 80, 80)
            cell.imageView.image = self.pictureArray[indexPath.row] as? UIImage
            cell.contentView.addSubview(cell.imageView)
            return cell
        }
        return cell
    }
    //    最小高度
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return CGFloat(0)
    }
    
    //    上下间距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return CGFloat(6)
    }
    
    override func viewWillAppear(animated: Bool) {
        if(self.i>1){
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "最多选择1张图片哦"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 2)
        }
    }
//MARK: -   添加图片
    func AddPictrures(){
        let vc = BSImagePickerViewController()
        vc.maxNumberOfSelections = 1
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
    //    选择图片
    func getAssetThumbnail(asset: [PHAsset]) -> UIImage {
        var thumbnail = UIImage()
        i+=asset.count
        if(i>1){
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
    //   发表评论
    func sendDone(){
        if(i != 0){
            self.UpdatePic()
        }
        self.PutBlog()
    }
    //    更新图片
    func UpdatePic(){
        for i in 0..<self.imageData.count{
            let chid = NSUserDefaults.standardUserDefaults()
            let userid = chid.stringForKey("userid")
            let RanNumber = String(arc4random_uniform(1000) + 1000)
            let name = "\(userid!)\(RanNumber)"
            isuploading = true
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
                ConnectModel.uploadWithImageName(name, imageData:self.imageData[i], URL: "WriteMicroblog_upload", finish: { (data) -> Void in
                    print("返回值")
                    print(data)
                    
                })
            }
            self.imagePath.addObject(name + ".png")
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
    //    发表日记
    func PutBlog(){

        let chid = NSUserDefaults.standardUserDefaults()
        let userid = chid.stringForKey("userid")
        
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=school&a=SetComment"
        if(self.imagePath.count == 0){
            imageUrl = ""
        }
        let param = [
            "userid":userid!,
            "id":self.id!,
            "type":5,
            "content":self.contentTextView.text!,
            "photo":imageUrl!
        ]
        
        Alamofire.request(.POST, url, parameters: param as? [String : AnyObject]).response { request, response, json, error in
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
                    print("Success")
                    self.navigationController?.popViewControllerAnimated(true)
                }
                
            }
            
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
