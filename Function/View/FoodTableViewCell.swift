//
//  FoodTableViewCell.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/4/6.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class FoodTableViewCell: UITableViewCell {

    var foodInfo:FoodInfo?
    var imageCache = Dictionary<String,UIImage>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
     
        
        
    }
    
    //MARK: - 加载子视图
    
    func loadSubviews() -> Void {
      //早午餐

        
        
        
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        //加载子视图
        loadSubviews()
        
    }

}
