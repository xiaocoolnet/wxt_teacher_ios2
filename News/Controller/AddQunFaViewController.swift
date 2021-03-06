//
//  AddQunFaViewController.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/6/29.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire
import BSImagePicker
import Photos
import TZImagePickerController
class AddQunFaViewController: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate,sendnameidArray,sendteachernameidArray,TZImagePickerControllerDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var pushflag = 0
    
    var imageUrl:String?
    var imagePath = NSMutableArray()
    var type=String()
    var imageData:[NSData] = []
    var isuploading = false
    let lbl2 = UILabel()
    let lbl4 = UILabel()
    var addPictureBtn = UIButton()
    let contentTextView = BRPlaceholderTextView()
    var flowLayout = UICollectionViewFlowLayout()
    var collectV:UICollectionView?
    var i = 0
    var pictureArray = NSMutableArray()
    var itemCount = 0
    let nameLable = UILabel()
    var idStr = String()
    var genre = String()
    var numL = UILabel()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.hidden = true
        self.view.backgroundColor=bkColor
        self.title="消息群发"
        createUI()
        let rightItem = UIBarButtonItem(title: "确认", style: UIBarButtonItemStyle.Done, target: self, action: #selector(UpdateBlog))
        self.navigationItem.rightBarButtonItem = rightItem
    }
    //    创建UI
    func createUI(){
        
        let v1 = UIView()
        v1.frame = CGRectMake(0, 0, self.view.frame.size.width, 60)
        v1.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(v1)
        
        let lbl1 = UILabel()
        lbl1.frame = CGRectMake(10, 20, 100, 20)
        lbl1.text = "选择接收人"
        lbl1.font = UIFont.systemFontOfSize(15)
        lbl1.textColor = wenziColor
        v1.addSubview(lbl1)
        nameLable.frame=CGRectMake(frame.width-200, 20, 100, 20)
        nameLable.font=UIFont.systemFontOfSize(15)
        nameLable.textColor=wenziColor
        numL.frame=CGRectMake(frame.width-100, 20, 70, 20)
        numL.font=UIFont.systemFontOfSize(15)
        numL.textColor=wenziColor
        v1.addSubview(numL)
        v1.addSubview(nameLable)
        
        let btn1 = UIButton(type: .Custom)
        btn1.frame = CGRectMake(WIDTH-30, 20, 20, 20)
        btn1.setImage(UIImage(named: "箭头"), forState: .Normal)
//        btn1.addTarget(self, action: #selector(AddQunFaViewController.choosePeople), forControlEvents: .TouchUpInside)
        v1.addSubview(btn1)
        v1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(AddQunFaViewController.choosePeople)))
        
        
        
        
        self.contentTextView.frame = CGRectMake(0, 70, self.view.bounds.width , 120)
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
        let backGroudView = UIView(frame: CGRectMake(0,192,WIDTH,100))
        backGroudView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(backGroudView)
//        addPictureBtn.frame = CGRectMake(10,10, 80, 80)
//        addPictureBtn.setBackgroundImage(UIImage(named: "add2"), forState: UIControlState.Normal)
//        addPictureBtn.layer.borderWidth = 1.0
//        addPictureBtn.layer.borderColor = UIColor.grayColor().CGColor
//        addPictureBtn.addTarget(self, action: #selector(AddQunFaViewController.AddPictrures), forControlEvents: UIControlEvents.TouchUpInside)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
        flowLayout.itemSize = CGSizeMake(80,80)
        self.collectV = UICollectionView(frame: CGRectMake(10, 10, UIScreen.mainScreen().bounds.width-20, 359), collectionViewLayout: flowLayout)
        self.collectV?.registerClass(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
        self.collectV?.delegate = self
        self.collectV?.dataSource = self
        self.collectV?.backgroundColor = UIColor.clearColor()
        self.view.addSubview(self.contentTextView)
        backGroudView.addSubview(self.collectV!)
        backGroudView.addSubview(addPictureBtn)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func choosePeople(){
        if type=="1" {
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
    
    
    func UpdateBlog(){
       
            self.UpdatePic()
       
        
    }
    func sendnameid(name: NSMutableArray, id: NSMutableArray) {
        
        let arrayStr = name.componentsJoinedByString(",")
        numL.text="共\(name.count)人"
        nameLable.text=arrayStr
        idStr=id.componentsJoinedByString(",")
    }
    func sendteachernameid(name: NSMutableArray, id: NSMutableArray) {
        nameLable.text=name.componentsJoinedByString(",")
        numL.text="共\(name.count)人"
        idStr=id.componentsJoinedByString(",")
    }
    
    func UpdatePic(){
        if idStr.isEmpty {
            messageHUD(self.view, messageData: "请选择接受人")
            return
        }
        if contentTextView.text.isEmpty {
            messageHUD(self.view, messageData: "请输入内容！")
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
        addqunfa()
        
    
    }
    
    func addqunfa(){
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=message&a=send_message"
        let defalutid = NSUserDefaults.standardUserDefaults()
        let userid = defalutid.stringForKey("userid")
        let schoolid = defalutid.stringForKey("schoolid")
        let name = defalutid.stringForKey("username")
        
        
        let param = [
            "send_user_id" : userid,
            "schoolid":schoolid,
            "send_user_name":name,
            "receiver_user_id" : idStr,
            "picture_url" : imageUrl,
            "message_content" : contentTextView.text!,
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
}
