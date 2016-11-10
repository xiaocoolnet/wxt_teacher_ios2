//
//  ErWeiMaViewController.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/9/27.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class ErWeiMaViewController: UIViewController {

    let imageview = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor=UIColor.whiteColor()
        imageview.frame=CGRectMake(100, (frame.height-(frame.width-200)-44)/2, frame.width-200, frame.width-200)
        imageview.image=UIImage(named: "liantu")
        self.view.addSubview(imageview)
    }

    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=true
        
    }
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=false
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
