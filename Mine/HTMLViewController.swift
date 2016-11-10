//
//  HTMLViewController.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/8/24.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire
class HTMLViewController: UIViewController ,UIWebViewDelegate{

    var id:String!
    var webView = UIWebView()
    var table = UITableView()
    var url:String?
    var tit:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGrayColor()
        self.title = tit
        createUI()
        //        GETData()
        GetH5Date()
    }
    func createUI(){
        self.tabBarController?.tabBar.hidden = true
        //  进行webView的请求
        webView.frame = CGRectMake(0, 0, WIDTH, HEIGHT)
        self.view.addSubview(webView)
        
    }
    
    func GetH5Date(){
        
        let url = "http://wxt.xiaocool.net/index.php?g=apps&m=index&a=FairylandUrl"
        let param = [
            "name":self.tit
        ]
        Alamofire.request(.GET, url, parameters: param as? [String:String]).response { request, response, json, error in
            if(error != nil){
            }
            else{
                print("request是")
                print(request!)
                print("====================")
                //  进行数据解析
                let status = MineModel(JSONDecoder(json!))
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
                    //  手机号
                    self.url = (status.data?.url!)!
                    self.GETData()
                    print(self.url)
                }
            }
            
        }
        
    }
    
    
    func GETData(){
        
        let url = NSURL(string: self.url!)
        let request = NSURLRequest(URL: url!)
        print("@#$%^&")
        print(self.url)
        webView.loadRequest(request)
        
        
    }
    
}
