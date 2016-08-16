//
//  XinWenInfoViewController.swift
//  WXT_Teacher
//
//  Created by 李春波 on 16/3/26.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class XinWenInfoViewController: UIViewController {

    let webView = UIWebView()
    var id = String()
    var ziduan = String()
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "新闻详情"
        super.viewDidLoad()
        //http://wxt.xiaocool.net/index.php?g=portal&m=article&a=notice&id=16
        webView.frame=CGRectMake(0, 0, frame.width, frame.height)
        let str = "http://wxt.xiaocool.net/index.php?g=portal&m=article&a="+ziduan+"&id="+id
        let url = NSURL(string: str)
        let requ = NSURLRequest(URL: url!)
        webView.loadRequest(requ)
  
        self.view.addSubview(webView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
