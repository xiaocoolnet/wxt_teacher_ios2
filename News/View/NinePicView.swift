//
//  NinePicView.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/11/14.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class NinePicView: UIView {
    
    var pic : Array<String>!
    var buttonTagForRow = 0
    var image_h = CGFloat()
    var oldFrame:CGRect!
    var vc : UIViewController!
    
    init(frame: CGRect,pic:Array<String>,vc:UIViewController) {
        super.init(frame:frame)
        self.backgroundColor = UIColor.whiteColor()
        var button:UIImageView?
        self.pic = pic
        self.vc = vc
        //判断图片张数显示
        if pic.count == 1 {
            if !(pic.first!=="") && !(pic.first=="null") {
                self.image_h=300
                let pciInfo = pic[0]
                let imgUrl = pictureUrl+(pciInfo)
                let avatarUrl = NSURL(string: imgUrl)
                let imv = UIImageView(frame:CGRectMake(12, 0, frame.size.width - 24, 300))
                imv.tag = 0
                imv.userInteractionEnabled = true
                imv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapclickBtn)))
                imv.yy_setImageWithURL(avatarUrl, placeholder: UIImage(named: "图片默认加载"))
                self.addSubview(imv)
            }
        }
        if(pic.count>1&&pic.count<=3){
            self.image_h=(frame.size.width - 40)/3.0
            for i in 1...pic.count{
                self.buttonTagForRow = i-1
                var x = 12
                let pciInfo = pic[i-1]
                let imgUrl = pictureUrl+(pciInfo)
                print(imgUrl)
                let avatarUrl = NSURL(string: imgUrl)
                x = x+((i-1)*Int((frame.size.width - 40)/3.0 + 10))
                
                let imv = UIImageView(frame:CGRectMake(CGFloat(x), 0, (frame.size.width - 40)/3.0, (frame.size.width - 40)/3.0))
                imv.tag = i-1
                imv.userInteractionEnabled = true
                imv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapclickBtn)))
                imv.yy_setImageWithURL(avatarUrl, placeholder: UIImage(named: "图片默认加载"))
                self.addSubview(imv)
                
            }
        }
        if(pic.count>3&&pic.count<=6){
            self.image_h=(frame.size.width - 40)/3.0*2 + 10
            for i in 1...pic.count{
                self.buttonTagForRow = i-1
                if i <= 3 {
                    var x = 12
                    let pciInfo = pic[i-1]
                    if pciInfo != "" {
                        let imgUrl = pictureUrl+(pciInfo)
                        let avatarUrl = NSURL(string: imgUrl)
                        x = x+((i-1)*Int((frame.size.width - 40)/3.0 + 10))
                        let button = UIImageView(frame : CGRectMake(CGFloat(x), 0, (frame.size.width - 40)/3.0, (frame.size.width - 40)/3.0))
                        button.userInteractionEnabled = true
                        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapclickBtn)))
                        button.yy_setImageWithURL(avatarUrl, placeholder: UIImage(named: "图片默认加载"))
                        button.tag = i-1
                        self.addSubview(button)
                        
                    }}else{
                    var x = 12
                    let pciInfo = pic[i-1]
                    if pciInfo != "" {
                        let imgUrl = pictureUrl+(pciInfo)
                        let avatarUrl = NSURL(string: imgUrl)
                        x = x+((i-4)*Int((frame.size.width - 40)/3.0 + 10))
                        button = UIImageView(frame : CGRectMake(CGFloat(x), 0+(frame.size.width - 40)/3.0 + 5, (frame.size.width - 40)/3.0, (frame.size.width - 40)/3.0))
                        button!.userInteractionEnabled = true
                        button!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapclickBtn)))
                        button!.yy_setImageWithURL(avatarUrl, placeholder: UIImage(named: "图片默认加载"))
                   
                        button!.tag = i-1
                        self.addSubview(button!)
                       
                        
                    }
                }
            }}
        if(pic.count>6&&pic.count<=9){
            self.image_h=(frame.size.width - 40)/3.0*3+20
            for i in 1...pic.count{
                self.buttonTagForRow = i-1
                if i <= 3 {
                    var x = 12
                    let pciInfo = pic[i-1]
                    if pciInfo != "" {
                        let imgUrl = pictureUrl+(pciInfo)
                        let avatarUrl = NSURL(string: imgUrl)
            
                        x = x+((i-1)*Int((frame.size.width - 40)/3.0 + 10))
                        button = UIImageView(frame : CGRectMake(CGFloat(x), 0, (frame.size.width - 40)/3.0, (frame.size.width - 40)/3.0))
                        button!.userInteractionEnabled = true
                        button!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapclickBtn)))
                        button!.yy_setImageWithURL(avatarUrl, placeholder: UIImage(named: "图片默认加载"))
                   
                        button!.tag = i-1
                        self.addSubview(button!)
                        
                        
                    }}else if (i>3&&i<=6){
                    var x = 12
                    let pciInfo = pic[i-1]
                    if pciInfo != "" {
                        let imgUrl = pictureUrl+(pciInfo)
                        
                        //let image = self.imageCache[imgUrl] as UIImage?
                        let avatarUrl = NSURL(string: imgUrl)
                        x = x+((i-4)*Int((frame.size.width - 40)/3.0 + 10))
                        button = UIImageView(frame : CGRectMake(CGFloat(x), 0+(frame.size.width - 40)/3.0 + 5, (frame.size.width - 40)/3.0, (frame.size.width - 40)/3.0))
                        button!.userInteractionEnabled = true
                        button!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapclickBtn)))
                        button!.yy_setImageWithURL(avatarUrl, placeholder: UIImage(named: "图片默认加载"))
                   
                        button!.tag = i-1
                        self.addSubview(button!)
                      
                        
                    } }else{
                    var x = 12
                    let pciInfo = pic[i-1]
                    if pciInfo != "" {
                        let imgUrl = pictureUrl+(pciInfo)
                        let avatarUrl = NSURL(string: imgUrl)
                        x = x+((i-7)*Int((frame.size.width - 40)/3.0 + 10))
                        button = UIImageView(frame : CGRectMake(CGFloat(x), 0+(frame.size.width - 40)/3.0 + 5+(frame.size.width - 40)/3.0 + 5, (frame.size.width - 40)/3.0, (frame.size.width - 40)/3.0))
                        button!.userInteractionEnabled = true
                        button!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapclickBtn)))
                        button!.yy_setImageWithURL(avatarUrl, placeholder: UIImage(named: "图片默认加载"))
                   
                        button!.tag = i-1
                        self.addSubview(button!)
                       
                        
                    }
                    
                }
                
            }}
        if pic.count > 9 {
            self.image_h=(frame.size.width - 40)/3.0*3 + 20
            for i in 1...pic.count{
                if i <= 3 {
                    var x = 12
                    let pciInfo = pic[i-1]
                    if pciInfo != "" {
                        let imgUrl = pictureUrl+(pciInfo)
                        let avatarUrl = NSURL(string: imgUrl)
                        x = x+((i-1)*Int((frame.size.width - 40)/3.0 + 10))
                        print(x)
                        button = UIImageView(frame : CGRectMake(CGFloat(x), 0, (frame.size.width - 40)/3.0, (frame.size.width - 40)/3.0))
                        button!.userInteractionEnabled = true
                        button!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapclickBtn)))
                        button!.yy_setImageWithURL(avatarUrl, placeholder: UIImage(named: "图片默认加载"))
                   
                        button!.tag = i-1
                        self.addSubview(button!)
                        
                        
                    }}else if (i>3&&i<=6){
                    var x = 12
                    let pciInfo = pic[i-1]
                    if pciInfo != "" {
                        let imgUrl = pictureUrl+(pciInfo)
                        let avatarUrl = NSURL(string: imgUrl)
                        x = x+((i-4)*Int((frame.size.width - 40)/3.0 + 10))
                        button = UIImageView(frame : CGRectMake(CGFloat(x), 0+(frame.size.width - 40)/3.0 + 5, (frame.size.width - 40)/3.0, (frame.size.width - 40)/3.0))
                        button!.userInteractionEnabled = true
                        button!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapclickBtn)))
                        button!.yy_setImageWithURL(avatarUrl, placeholder: UIImage(named: "图片默认加载"))
                   
                        button!.tag = i-1
                        self.addSubview(button!)
                    } }else{
                    var x = 12
                    let pciInfo = pic[i-1]
                    if pciInfo != "" {
                        let imgUrl = pictureUrl+(pciInfo)
                        
                        
                        let avatarUrl = NSURL(string: imgUrl)
                    
                        x = x+((i-7)*Int((frame.size.width - 40)/3.0 + 10))
                        button = UIImageView(frame : CGRectMake(CGFloat(x), 0+(frame.size.width - 40)/3.0 + 5+(frame.size.width - 40)/3.0 + 5, (frame.size.width - 40)/3.0, (frame.size.width - 40)/3.0))
                        button!.userInteractionEnabled = true
                        button!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapclickBtn)))
                        button!.yy_setImageWithURL(avatarUrl, placeholder: UIImage(named: "图片默认加载"))
                   
                        button!.tag = i-1
                        self.addSubview(button!)
                        
                    }
                    
                }
                
            }}
        
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, image_h)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
       
    }

    
    func clickBtn(button:CustomBtn) -> Void {
        print(button.tag)
        let imgVc = ImagesViewController()
        imgVc.arrayInfo = self.pic
        imgVc.count = button.tag
        self.vc.navigationController?.pushViewController(imgVc, animated: true)
        
    }
    
    
    func tapclickBtn(tap:UITapGestureRecognizer) -> Void {
        let imgVc = ImagesViewController()
        imgVc.arrayInfo = self.pic
        imgVc.count = tap.view!.tag
        self.vc.navigationController?.pushViewController(imgVc, animated: true)
        
    }

    func AppRootViewController() -> UIViewController? {
        var topVC = UIApplication.sharedApplication().keyWindow?.rootViewController
        while topVC?.presentedViewController != nil {
            topVC = topVC?.presentedViewController
        }
        return topVC
    }
    
    func showImage(sender: UITapGestureRecognizer){
//        let photoView = sender.view as! CustomBtn
//        self.oldFrame = photoView.frame
//        var image = photoView.imageView?.image
//        var window = UIApplication.sharedApplication().keyWindow
//        var backgroundView = UIScrollView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height))
//        backgroundView.backgroundColor = UIColor.blackColor()
//        backgroundView.alpha = 0
//        var imageView = UIImageView(frame: photoView.frame)
//        
//        imageView.image = image
//        imageView.tag = 1
//        backgroundView.addSubview(imageView)
//        window?.addSubview(backgroundView)
//        var hide = UITapGestureRecognizer(target: self, action: "hideImage:")
//        
//        backgroundView.userInteractionEnabled = true
//        backgroundView.addGestureRecognizer(hide)
//        UIView.animateWithDuration(0.3, animations:{ () in
//            var vsize = UIScreen.mainScreen().bounds.size
//            imageView.frame = CGRect(x:0.0, y: 0.0, width: vsize.width, height: vsize.height)
//            imageView.contentMode = .ScaleAspectFit
//            backgroundView.alpha = 1
//            }, completion: {(finished:Bool) in })
//        
//    }
//    
//    func hideImage(sender: UITapGestureRecognizer){
//        var backgroundView = sender.view as UIView?
//        if let view = backgroundView{
//            UIView.animateWithDuration(0.3,
//                                       animations:{ () in
//                                        var imageView = view.viewWithTag(1) as! UIImageView
//                                        imageView.frame = self.oldFrame
//                                        imageView.alpha = 0
//                                        
//                },
//                                       completion: {(finished:Bool) in
//                                        view.alpha = 0
//                                        view.superview?.removeFromSuperview()
//                                        view.removeFromSuperview()
//            })
//        }
    }
}


