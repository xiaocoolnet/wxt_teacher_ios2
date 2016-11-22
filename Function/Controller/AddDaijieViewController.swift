//
//  AddDaijieViewController.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/7/29.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import TZImagePickerController
class AddDaijieViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,sendnameidDelegate,UICollectionViewDelegate,UICollectionViewDataSource,TZImagePickerControllerDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    var tableview = UITableView()
    var nameL : UILabel!
    let textview = BRPlaceholderTextView()
    var id = String()
    var collectV:UICollectionView?
    var flowLayout = UICollectionViewFlowLayout()
    var pictureArray = NSMutableArray()
    var imageUrl:String?
    var imagePath = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title="确认代接"
        self.view.backgroundColor=UIColor.whiteColor()
        tableview.frame=CGRectMake(0, 0, frame.width, frame.height)
        tableview.delegate=self
        tableview.dataSource=self
       tableview.scrollEnabled=false
        self.view.addSubview(tableview)
        let rightItem = UIBarButtonItem(title: "提交", style: UIBarButtonItemStyle.Done, target: self, action: #selector(addDaijie))
        self.navigationItem.rightBarButtonItem = rightItem
    }
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 3
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = UITableViewCell()
        if indexPath.row==0 {
            cell.accessoryType = .DisclosureIndicator
            cell.textLabel?.text="选择学生"
            nameL = UILabel(frame: CGRectMake(frame.width-100,10,90,20))
            nameL.text="选择 "
            nameL.font=UIFont.systemFontOfSize(14)
            cell.contentView.addSubview(nameL)
            
        tableView.rowHeight=44
        }else if indexPath.row==1{
            
            textview.frame=CGRectMake(5, 5, frame.width-10, 190)
            textview.placeholder = "请输入待接内容"
            textview.layer.borderColor=UIColor.grayColor().CGColor
            cell.addSubview(textview)
            tableView.rowHeight=200
            
        }else if indexPath.row==2{
           
            flowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
            flowLayout.itemSize = CGSizeMake(80,80)
            self.collectV = UICollectionView(frame: CGRectMake(8, 10, UIScreen.mainScreen().bounds.width-30, 359), collectionViewLayout: flowLayout)
            self.collectV?.registerClass(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
            self.collectV?.delegate = self
            self.collectV?.dataSource = self
            self.collectV?.backgroundColor = UIColor.clearColor()
            cell.contentView.addSubview(self.collectV!)
            tableView.rowHeight = 400
        }else{
          
        }
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row==0 {
            let vc = StudentLIstViewController()
            vc.delegate=self
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }

    func sendnameid(name: String, id: String) {
        nameL.text=name
        self.id=id
    }
    
    func AddPictrures(){
        let imagePickerVc = TZImagePickerController.init(maxImagesCount: 1, delegate:self)
        
        print(pictureArray.count)
        print("上传图片")
        let imagePicker = UIImagePickerController();
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePickerVc, animated: true, completion: nil)
    }
    func imagePickerController(picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [AnyObject]!, isSelectOriginalPhoto: Bool, infos: [[NSObject : AnyObject]]!) {
        self.pictureArray.removeAllObjects()
        for imagess in photos {
            pictureArray.addObject(imagess)
        }
        print(self.pictureArray.count)
        self.collectV?.reloadData()
        
        
    }

    func addDaijie(){
        UpdatePic()
    }
    func UpdatePic(){
        if self.id.isEmpty {
            messageHUD(self.view, messageData: "请选择接收人")
            return
        }
        if textview.text!.isEmpty {
            messageHUD(self.view, messageData: "请输入内容")
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
    //MARK: - 发布待接确认
    //http://wxt.xiaocool.net/index.php?g=apps&m=teacher&a=addtransport&teacherid=605&studentid=661,666&photo=123.jpg&content=asdsad
    func GETDate(){
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=teacher&a=addtransport"
        let defalutid = NSUserDefaults.standardUserDefaults()
        let userid = defalutid.stringForKey("userid")
        let param = [
            "teacherid" : userid,
            "studentid" : self.id,
            "photo" : self.imageUrl,
            "content" : textview.text!
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
