//
//  SystemDetailViewController.swift
//  WXT_Parents
//
//  Created by 沈晓龙 on 16/8/22.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class SystemDetailViewController: UIViewController {

    var id:String!
    var webView = UIWebView()
    var table = UITableView()
    var tit:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGrayColor()
        
        self.title = tit
        createUI()
        
        GETData()
        //        self.createtable()
    }
    func createUI(){
        self.tabBarController?.tabBar.hidden = true
        //  进行webView的请求
        webView.frame = CGRectMake(0, 0, WIDTH, HEIGHT)
        self.view.addSubview(webView)
        
    }
    func GETData(){
        
        let url = NSURL(string: "http://wxt.xiaocool.net/index.php?g=portal&m=article&a=system&id" + id)
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
        
        
    }
  
}
