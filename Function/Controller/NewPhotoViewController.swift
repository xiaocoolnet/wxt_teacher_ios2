//
//  NewPhotoViewController.swift
//  WXT_Teacher
//
//  Created by 李春波 on 16/3/17.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import MBProgressHUD
import BSImagePicker
import Photos
import Alamofire

class NewPhotoViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource{

    let nameView = UIView()
    let nameLabel = UILabel()
    let nameContent = UITextField()
    let miaoshuView = UIView()
    let miaoshiLabel = UILabel()
    let miaoshuContent = UITextField()
    let finishBtn = UIButton()
    var addPictureBtn = UIButton()
    var collectV:UICollectionView?
    var flowLayout = UICollectionViewFlowLayout()
    var pictureArray = NSMutableArray()
    var itemCount = 0
    var i = 0
    var imageData:[NSData] = []
    var isuploading = false
    var imageUrl:String?
    var imagePath = NSMutableArray()
    var photoContent = String()
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        self.title = "新建相册"
        super.viewDidLoad()
        let rightItem = UIBarButtonItem(title: "上传", style: .Done, target: self, action: #selector(NewBlogViewController.UpdateBlog))
        self.navigationItem.rightBarButtonItem = rightItem
        nameView.frame = CGRectMake(5, 10, self.view.bounds.width - 10, 46)
        nameView.backgroundColor = UIColor.whiteColor()
        nameView.layer.cornerRadius = 5
        nameView.layer.masksToBounds = true
        nameView.layer.borderWidth = 1
        nameView.layer.borderColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1).CGColor
        miaoshuView.frame = CGRectMake(5, 55, self.view.bounds.width - 10, 46)
        miaoshuView.backgroundColor = UIColor.whiteColor()
        miaoshuView.layer.cornerRadius = 5
        miaoshuView.layer.masksToBounds = true
        miaoshuView.layer.borderWidth = 1
        miaoshuView.layer.borderColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1).CGColor
        nameLabel.frame = CGRectMake(10, 25, 70, 15)
        nameLabel.font = UIFont.systemFontOfSize(16)
        nameLabel.text = "相册名称"
        nameContent.frame = CGRectMake(82, 25, 140, 17)
        nameContent.borderStyle = .None
        miaoshiLabel.frame = CGRectMake(10, 71, 70, 15)
        miaoshiLabel.font = UIFont.systemFontOfSize(16)
        miaoshiLabel.text = "相册描述"
        miaoshuContent.frame = CGRectMake(82, 71, 140, 17)
        miaoshuContent.borderStyle = .None
        addPictureBtn.frame = CGRectMake(8, 150, 80, 80)
        addPictureBtn.setBackgroundImage(UIImage(named: "add2"), forState: UIControlState.Normal)
        addPictureBtn.layer.borderWidth = 1.0
        addPictureBtn.layer.borderColor = UIColor.grayColor().CGColor
        addPictureBtn.addTarget(self, action: #selector(NewBlogViewController.AddPictrures), forControlEvents: UIControlEvents.TouchUpInside)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
        flowLayout.itemSize = CGSizeMake(80,80)
        self.collectV = UICollectionView(frame: CGRectMake(8, 150, UIScreen.mainScreen().bounds.width-30, 359), collectionViewLayout: flowLayout)
        self.collectV?.registerClass(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
        self.collectV?.delegate = self
        self.collectV?.dataSource = self
        self.collectV?.backgroundColor = UIColor.clearColor()
        self.view.addSubview(self.collectV!)
        self.view.addSubview(addPictureBtn)

        self.view.addSubview(nameView)
        self.view.addSubview(miaoshuView)
        self.view.addSubview(nameLabel)
        self.view.addSubview(miaoshiLabel)
        self.view.addSubview(finishBtn)
        self.view.addSubview(nameContent)
        self.view.addSubview(miaoshuContent)
        // Do any additional setup after loading the view.
    }
    
    func UpLoadPicView(){
        if nameContent.text!.isEmpty{
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请输入相册名称"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return
        }
        if miaoshuContent.text!.isEmpty{
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请输入相册描述"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return
        }
        let uploadPic = UpLoadeViewController()
        uploadPic.photoName=nameContent.text!
        uploadPic.photoContent=miaoshuContent.text!
        self.navigationController?.pushViewController(uploadPic, animated: true)
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
    
    func UpdateBlog(){
        if(i != 0){
            self.UpdatePic()
        }
        self.PutBlog()
        self.navigationController?.popViewControllerAnimated(true)
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
    
    func PutBlog(){
        let url = apiUrl+"WriteMicroblog"
        let schoolid = NSUserDefaults.standardUserDefaults()
        let scid = schoolid.stringForKey("schoolid")
        let classid = NSUserDefaults.standardUserDefaults()
        let clid = classid.stringForKey("classid")
        let userid = NSUserDefaults.standardUserDefaults()
        let uid = userid.stringForKey("userid")
        if(self.imagePath.count == 0){
            imageUrl = ""
        }
        let param = [
            "schoolid":scid!,
            "classid":clid!,
            "userid":uid!,
            "type":"2",
            "content":miaoshuContent.text!,
            "picurl":imageUrl!
        ]
        Alamofire.request(.POST, url, parameters: param).response { request, response, json, error in
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
                }
                
            }
            
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
