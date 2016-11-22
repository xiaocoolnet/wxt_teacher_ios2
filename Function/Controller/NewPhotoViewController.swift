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
import TZImagePickerController
class NewPhotoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,TZImagePickerControllerDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var tableview = UITableView()
    let nameView = UIView()
    let nameContent = BRPlaceholderTextView()
    let miaoshuView = UIView()
    let miaoshuContent = BRPlaceholderTextView()
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
        // Do any additional setup after loading the view.
        tableview.frame=CGRectMake(0, 0, frame.width, frame.height)
        tableview.delegate=self
        tableview.dataSource=self
        tableview.separatorStyle = .None
        self.view.addSubview(tableview)
        
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
            nameContent.frame = CGRectMake(10, 10, WIDTH-20, 30)
            nameContent.textColor = neirongColor
            nameContent.font = neirongfont
            nameContent.placeholder = "相册标题"
            cell.addSubview(nameContent)
            addDividerLine(cell.contentView, y: 49, height: 1)
            tableView.rowHeight = 50
        
        }else if indexPath.row==1{
            miaoshuContent.frame = CGRectMake(10, 10, WIDTH - 20, 150)
            miaoshuContent.textColor = neirongColor
            miaoshuContent.font = neirongfont
            miaoshuContent.placeholder = "相册内容"
            cell.addSubview(miaoshuContent)
            addDividerLine(cell.contentView, y: 160, height: 10)
            tableView.rowHeight = 170
        }else if indexPath.row==2{
//            addPictureBtn.frame = CGRectMake(8, 10, 80, 80)
//            addPictureBtn.setBackgroundImage(UIImage(named: "add2"), forState: UIControlState.Normal)
//            addPictureBtn.layer.borderWidth = 1.0
//            addPictureBtn.layer.borderColor = UIColor.grayColor().CGColor
//            addPictureBtn.addTarget(self, action: #selector(self.AddPictrures), forControlEvents: UIControlEvents.TouchUpInside)
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
    func UpdateBlog(){
  
            self.UpdatePic()
        
    }
    
    func UpdatePic(){
        if self.nameContent.text.isEmpty {
            messageHUD(self.view, messageData: "请输入相册标题")
            return
        }
        if self.miaoshuContent.text.isEmpty {
            messageHUD(self.view, messageData: "请输入相册内容")
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
                    self.navigationController?.popViewControllerAnimated(true)
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
