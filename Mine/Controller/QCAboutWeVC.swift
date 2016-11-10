//
//  QCAboutWeVC.swift
//  WXT_Parents
//
//  Created by 沈晓龙 on 16/7/12.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class QCAboutWeVC: UIViewController, UIWebViewDelegate {
    var row : Int!

    var webView = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func initUI(){
        
        self.tabBarController?.tabBar.hidden = true
        self.view.backgroundColor = RGBA(239, g: 239, b: 244, a: 1)
        if self.row == 0 {
            //
            self.title = "使用帮助"
            createUI()
            GETDate()
        }
        if self.row == 2{
            //
            self.title = "关于我们"
            createUI()
            GETData()
            
        }
    }
    func getLabel(content:String){
        let label = UILabel()
        label.frame = self.view.bounds
        label.text = content
        label.font = UIFont.systemFontOfSize(50)
        self.view.addSubview(label)
    }
    
    func createUI(){
        self.tabBarController?.tabBar.hidden = true
        //  进行webView的请求
        webView.frame = CGRectMake(0, 0, WIDTH, HEIGHT - 20)
        self.view.addSubview(webView)
        
    }
    func GETData(){
        
        let url = NSURL(string: "http://wxt.xiaocool.net/index.php?g=portal&m=OurParent&a=index")
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
        
    }
    
    func GETDate(){
        
        let url = NSURL(string: "http://wxt.xiaocool.net/index.php?g=portal&m=help&a=index")
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
        
    }
    
    

}
