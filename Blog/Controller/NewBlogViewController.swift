//
//  NewBlogViewController.swift
//  WXT_Teacher
//
//  Created by 李春波 on 16/2/29.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos
import Alamofire
import MBProgressHUD
import TZImagePickerController

class NewBlogViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate,TZImagePickerControllerDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
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
     var tableview = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "发表动态"
        let rightItem = UIBarButtonItem(title: "发表", style: .Done, target: self, action: #selector(NewBlogViewController.UpdateBlog))
        self.navigationItem.rightBarButtonItem = rightItem
        
        tableview.frame=CGRectMake(0, 0, frame.width, frame.height)
        tableview.delegate=self
        tableview.dataSource=self
        tableview.separatorStyle = .None
        self.view.addSubview(tableview)
        
        
//        addPictureBtn.frame = CGRectMake(8, 215, 80, 80)
//        addPictureBtn.setBackgroundImage(UIImage(named: "add2"), forState: UIControlState.Normal)
//        addPictureBtn.layer.borderWidth = 1.0
//        addPictureBtn.layer.borderColor = UIColor.grayColor().CGColor
//        addPictureBtn.addTarget(self, action: #selector(NewBlogViewController.AddPictrures), forControlEvents: UIControlEvents.TouchUpInside)
//        flowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
//        flowLayout.itemSize = CGSizeMake(80,80)
//        self.collectV = UICollectionView(frame: CGRectMake(8, 215, UIScreen.mainScreen().bounds.width-30, 359), collectionViewLayout: flowLayout)
//        self.collectV?.registerClass(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
//        self.collectV?.delegate = self
//        self.collectV?.dataSource = self
//        self.collectV?.backgroundColor = UIColor.clearColor()
//        self.view.addSubview(self.contentTextView)
//        self.view.addSubview(self.collectV!)
//        self.view.addSubview(addPictureBtn)
        // Do any additional setup after loading the view.
    }
    
    //返回行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 4
    }
    //cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        cell.selectionStyle = .None
        
        if indexPath.row==0 {
            addDividerLine(cell.contentView, y: 0, height: 10)
            self.contentTextView.frame = CGRectMake(10, 10, WIDTH - 20, 200)
            self.contentTextView.font = UIFont.systemFontOfSize(15)
            self.contentTextView.placeholder = "请输入内容～不能超过300字啦"
            self.contentTextView.addMaxTextLengthWithMaxLength(300) { (contentTextView) -> Void in
                let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                hud.mode = MBProgressHUDMode.Text
                hud.labelText = "超过300字啦"
                hud.margin = 10.0
                hud.removeFromSuperViewOnHide = true
                hud.hide(true, afterDelay: 3)
            }
            addDividerLine(cell.contentView, y: 210, height: 10)
            cell.contentView.addSubview(self.contentTextView)
            tableView.rowHeight = 220
        }else if indexPath.row==1{
//            addPictureBtn.frame = CGRectMake(8, 10, 80, 80)
//            addPictureBtn.setBackgroundImage(UIImage(named: "add2"), forState: UIControlState.Normal)
//            addPictureBtn.layer.borderWidth = 1.0
//            addPictureBtn.layer.borderColor = UIColor.grayColor().CGColor
//            addPictureBtn.addTarget(self, action: #selector(NewBlogViewController.AddPictrures), forControlEvents: UIControlEvents.TouchUpInside)
            flowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
            flowLayout.itemSize = CGSizeMake(80,80)
            self.collectV = UICollectionView(frame: CGRectMake(8, 10, UIScreen.mainScreen().bounds.width-30, 359), collectionViewLayout: flowLayout)
            self.collectV?.registerClass(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
            self.collectV?.delegate = self
            self.collectV?.dataSource = self
            self.collectV?.backgroundColor = UIColor.clearColor()
            cell.contentView.addSubview(self.collectV!)
            cell.contentView.addSubview(addPictureBtn)
            tableView.rowHeight = 400
        }else if indexPath.row==3{
            
        }
        
        return cell
        
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
            let image = self.pictureArray[indexPath.item]
            let data:NSData = UIImageJPEGRepresentation(image as! UIImage, 1.0)!

            cell.imageView.image = UIImage.init(data: data)!
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
    
//    func getAssetThumbnail(asset: [PHAsset]) -> UIImage {
//        var thumbnail = UIImage()
//        i+=asset.count
//        if(i>9){
//        }
//        else{
//            print("选择的图片有\(i)张")
//            if(itemCount == 0){
//                itemCount = asset.count + 1
//                self.pictureArray.insertObject("", atIndex: 0)
//            }
//            else{
//                itemCount += asset.count
//            }
//            let manager = PHImageManager.defaultManager()
//            let option = PHImageRequestOptions()
//            option.synchronous = true
//            for j in 0..<asset.count{
//                manager.requestImageForAsset(asset[j], targetSize: CGSize(width: 80.0, height: 80.0), contentMode: .AspectFit, options: option, resultHandler: {(result, info)->Void in
//                    thumbnail = result!
//                    print("图片是")
//                    var temImage:CGImageRef = thumbnail.CGImage!
//                    temImage = CGImageCreateWithImageInRect(temImage, CGRectMake(0, 0, 80, 80))!
//                    let newImage = UIImage(CGImage: temImage)
//                    self.imageData.append(UIImageJPEGRepresentation(newImage, 1)!)
//                    self.pictureArray.addObject(newImage)
//                })
//            }
//        }
//        return thumbnail
//    }
    
    
    
    func UpdateBlog(){
    
        self.UpdatePic()
            
    }
    
    func PutBlog(){
      
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=index&a=WriteMicroblog"
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
            "content":self.contentTextView.text!,
            "picurl":imageUrl!,
            "type":"1"
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
                    self.navigationController?.popViewControllerAnimated(true)
                }
                
            }
            
        }
        
    }
    func UpdatePic(){
        if self.contentTextView.text.isEmpty {
            messageHUD(self.view, messageData: "请输入动态内容")
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
        PutBlog()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   }
