//
//  AddDianpingView.swift
//  WXT_Teacher
//
//  Created by qiang on 16/8/31.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit



class DianPingView : UIView{

   
    var type = 1

    var v1 :AddDianpingView?
    
      let label1 = UILabel()
    init(frame: CGRect ,name:String,type:Int) {
        super.init(frame: frame)
        self.tag = type
        let label1 = UILabel()
        label1.frame = CGRectMake(5, 0, 80, 50)
        label1.text = name
        self.addSubview(label1)
        v1 = AddDianpingView(frame:CGRectMake(label1.frame.maxX, 0, WIDTH-label1.frame.width, 50),type:self.type)
        self.addSubview(v1!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AddDianpingView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var type :Int?
    
    var view1 : LittleDianpingView?
    var view2 : LittleDianpingView?
    var view3 : LittleDianpingView?
    var array = NSMutableArray()
    

     init(frame: CGRect, type:Int) {
        super.init(frame: frame)
        self.type = type
        //初始化
        let fra1 = CGRectMake(CGFloat(Float(0))  * frame.width/3, 0, frame.width/3, frame.height)
        let view1 = LittleDianpingView(frame: fra1, type: 1)
        view1.type = 1
        view1.label.text = "优秀"
        view1.addTarget(self, action: #selector(self.clickBtn(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        view1.btn.selected = true
        view1.btn.addTarget(self, action: #selector(self.clickBtnn(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(view1)
        array.addObject(view1)
        
        
        let fra2 = CGRectMake(CGFloat(Float(1))  * frame.width/3, 0, frame.width/3, frame.height)
        let view2 = LittleDianpingView(frame: fra2,type: 2)
        view2.type = 2
        view2.label.text = "良好"
        view2.addTarget(self, action: #selector(self.clickBtn(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        view2.btn.addTarget(self, action: #selector(self.clickBtnn(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(view2)
         array.addObject(view2)
        
        
        let fra3 = CGRectMake(CGFloat(Float(2))  * frame.width/3, 0, frame.width/3, frame.height)
        let view3 = LittleDianpingView(frame: fra3,type: 3)
        view3.type = 3
        view3.label.text = "一般"
        view3.addTarget(self, action: #selector(self.clickBtn(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        view3.btn.addTarget(self, action: #selector(self.clickBtnn(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(view3)
         array.addObject(view3)
}
    
    func clickBtn(sender:LittleDianpingView){
//        sender.selected = true
    
        for index in 0...array.count-1 {
            let view = array[index]
            if view.type == sender.type {
                view.btn.selected = true
                self.superview?.tag = index+1
            }else{
                view.btn.selected = false
            }
            
        }

    }
    
    func clickBtnn(sender:LittleDianpingView){
        //        sender.selected = true
        
        for var index in 0...array.count-1 {
            let view = array[index]
            if view.type == sender.tag {
                view.btn.selected = true
               self.superview?.tag = index+1
            }else{
                view.btn.selected = false
            }
            
        }
        
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class LittleDianpingView: UIButton {
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
    var btn = UIButton()
    var label = UILabel()
    var type = 1

    
    
    init(frame: CGRect ,type: Int) {
        super.init(frame: frame)
        self.type = type
        //初始化
        btn.frame = CGRectMake(0, 0, self.frame.width/2, self.frame.height)
        btn.setImage(UIImage(named: "ic_hui"), forState: UIControlState.Normal)
        btn.tag = type
        if type==1 {
             btn.setImage(UIImage(named: "ic_hong"), forState: UIControlState.Selected)
        }else if type==2{
            btn.setImage(UIImage(named: "ic_ju"), forState: UIControlState.Selected)
        }else{
            btn.setImage(UIImage(named: "ic_huang"), forState: UIControlState.Selected)
        }
        self.addSubview(btn)
        
        label.frame = CGRectMake(self.frame.width/2, 0, self.frame.width/2, self.frame.height)
        label.textColor = UIColor.grayColor()
        self.addSubview(label)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}