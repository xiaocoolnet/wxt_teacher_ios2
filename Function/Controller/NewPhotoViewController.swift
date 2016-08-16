//
//  NewPhotoViewController.swift
//  WXT_Teacher
//
//  Created by 李春波 on 16/3/17.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import MBProgressHUD

class NewPhotoViewController: UIViewController {

    let nameView = UIView()
    let nameLabel = UILabel()
    let nameContent = UITextField()
    let miaoshuView = UIView()
    let miaoshiLabel = UILabel()
    let miaoshuContent = UITextField()
    let finishBtn = UIButton()
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        self.title = "新建相册"
        super.viewDidLoad()
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
        finishBtn.frame = CGRectMake(10, 114, self.view.bounds.width - 20, 40)
        finishBtn.layer.cornerRadius = 5
        finishBtn.layer.masksToBounds = true
        finishBtn.setTitle("上传图片", forState: .Normal)
        finishBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
        finishBtn.addTarget(self, action: #selector(NewPhotoViewController.UpLoadPicView), forControlEvents: .TouchUpInside)
        finishBtn.backgroundColor = UIColor(red: 54.0 / 255.0, green: 190.0 / 255.0, blue: 100.0 / 255.0, alpha: 1.0)
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
