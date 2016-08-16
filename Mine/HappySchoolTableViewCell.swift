//
//  HappySchoolTableViewCell.swift
//  WXT_Parents
//
//  Created by 沈晓龙 on 16/8/3.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class HappySchoolTableViewCell: UITableViewCell {

    
    let imgView = UIImageView()
    let titleLab = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        for view in self.contentView.subviews {
            view.removeFromSuperview()
        }
        
        imgView.frame = CGRectMake(10, 15, 30, 30)
        imgView.cornerRadius = 15
        self.contentView.addSubview(imgView)
        
        titleLab.frame = CGRectMake(50, 15, WIDTH  - 60, 30)
        self.contentView.addSubview(titleLab)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
