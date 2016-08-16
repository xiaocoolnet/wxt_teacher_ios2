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
class AddQunFaViewController: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate{
    
    
    let lbl2 = UILabel()
    let lbl4 = UILabel()
    var addPictureBtn = UIButton()
    let contentTextView = BRPlaceholderTextView()
    var flowLayout = UICollectionViewFlowLayout()
    var collectV:UICollectionView?
    var i = 0
    var pictureArray = NSMutableArray()
    var itemCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor=bkColor
        self.title="消息群发"
        createUI()
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
        
        
        let btn1 = UIButton(type: .Custom)
        btn1.frame = CGRectMake(WIDTH-30, 20, 20, 20)
        btn1.setImage(UIImage(named: "箭头"), forState: .Normal)
        btn1.addTarget(self, action: #selector(AddQunFaViewController.choosePeople), forControlEvents: .TouchUpInside)
        v1.addSubview(btn1)
        
        
        
        
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
        addPictureBtn.frame = CGRectMake(10,10, 80, 80)
        addPictureBtn.setBackgroundImage(UIImage(named: "add2"), forState: UIControlState.Normal)
        addPictureBtn.layer.borderWidth = 1.0
        addPictureBtn.layer.borderColor = UIColor.grayColor().CGColor
        addPictureBtn.addTarget(self, action: #selector(AddQunFaViewController.AddPictrures), forControlEvents: UIControlEvents.TouchUpInside)
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
        
    }
    func AddPictrures(){
        
    }
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
}
