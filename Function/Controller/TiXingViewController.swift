//
//  TiXingViewController.swift
//  WXT_Teacher
//
//  Created by 李春波 on 16/3/22.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import MBProgressHUD

class TiXingViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    let photoView = UIImageView()
    let finishBtn = UIButton()
    var hud = MBProgressHUD()
    var data = NSData()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "代接提醒"
        self.view.backgroundColor = UIColor.whiteColor()
        let rightItem = UIBarButtonItem(title: "发送", style: .Done, target: self, action: #selector(TiXingViewController.Fasong))
        self.navigationItem.rightBarButtonItem = rightItem
        photoView.frame = CGRectMake(0, 100, 250, 250)
        photoView.center.x = self.view.center.x
        finishBtn.frame = CGRectMake(0, 360, 250, 40)
        finishBtn.center.x = self.view.center.x
        finishBtn.layer.cornerRadius = 5
        finishBtn.layer.masksToBounds = true
        finishBtn.setTitle("拍照上传图片", forState: .Normal)
        finishBtn.backgroundColor = UIColor(red: 155.0 / 255.0, green: 229.0 / 255.0, blue: 180.0 / 255.0, alpha: 1.0)
        finishBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
        finishBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        finishBtn.addTarget(self, action: #selector(TiXingViewController.PaiShe), forControlEvents: .TouchUpInside)
        self.view.addSubview(photoView)
        self.view.addSubview(finishBtn)
        
    }
    
    func PaiShe(){
        var sourceType = UIImagePickerControllerSourceType.Camera
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true//设置可编辑
        picker.sourceType = sourceType
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        print("choose--------->>")
        print(info)
        
        let img = info[UIImagePickerControllerEditedImage] as! UIImage
        if(img.size.width>200 || img.size.height>200)
        {
            data = UIImageJPEGRepresentation(img, 0.1)!
        }
        else
        {
            data = UIImageJPEGRepresentation(img, 0.3)!
        }
        if (data.length>104850)
        {
            self.hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            self.hud.mode = MBProgressHUDMode.Text
            self.hud.margin = 10
            self.hud.removeFromSuperViewOnHide = true
            self.hud.labelText = "图片大于1M，请重新选择"
            self.hud.hide(true, afterDelay: 1)
            return
        }
        photoView.image = img
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    //取消之后
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

    func Fasong(){
        print("发送")
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
