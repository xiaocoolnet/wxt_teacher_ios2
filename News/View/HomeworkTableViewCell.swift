//
//  HomeworkTableViewCell.swift
//  WXT_Parents
//
//  Created by zhang on 16/4/27.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class HomeworkTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var contentLbl: UILabel!
    
    @IBOutlet weak var bigImageView: UIImageView!
    
    @IBOutlet weak var senderLbl: UILabel!
    
    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var readBtn: UIButton!
    
    @IBOutlet weak var dianzanBtn: UIButton!
    
    @IBOutlet weak var pinglunBtn: UIButton!
//    点赞列表
    @IBOutlet weak var zanListLbl: UILabel!
//    点赞图标
    @IBOutlet weak var zanImageView: UIImageView!
    
    @IBOutlet weak var senderIV: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
