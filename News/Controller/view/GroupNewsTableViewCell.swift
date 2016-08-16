//
//  GroupNewsTableViewCell.swift
//  WXT_Parents
//
//  Created by zhang on 16/6/14.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class GroupNewsTableViewCell: UITableViewCell {

 

    @IBOutlet weak var dianzanBtn: UIButton!
//    @IBOutlet weak var pinglunBtn: UIButton!
//    
//    @IBOutlet weak var dianzanBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.pinglunBtn.setBackgroundImage(UIImage(named: "评论"), forState: .Normal)
//        self.dianzanBtn.setBackgroundImage(UIImage(named: "点赞"), forState: .Normal)
       
        self.dianzanBtn.setBackgroundImage(UIImage(named: "已点赞"), forState: .Selected)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
