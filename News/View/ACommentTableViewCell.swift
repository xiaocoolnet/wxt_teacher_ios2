//
//  ACommentTableViewCell.swift
//  WXT_Parents
//
//  Created by zhang on 16/5/30.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class ACommentTableViewCell: UITableViewCell {

    @IBOutlet weak var headImageView: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var contentLbl: UILabel!
    
    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var photoImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func updateCellWithACommentInfo(aCommentInfo:ACommentInfo){
        let dateformate = NSDateFormatter()
        dateformate.dateFormat = "yyyy-MM-dd HH:mm"
        
        self.nameLbl.text = aCommentInfo.name
        self.contentLbl.text = aCommentInfo.content
        let date = NSDate(timeIntervalSince1970: NSTimeInterval(aCommentInfo.comment_time!)!)
        let str:String = dateformate.stringFromDate(date)
        self.timeLbl.text = str
        let imgUrl = microblogImageUrl + aCommentInfo.photo!
        let photourl = NSURL(string: imgUrl)
        self.photoImageView.yy_setImageWithURL(photourl, placeholder: UIImage(named: "卡通.png"))
        
        let imgUrl1 = imageUrl + aCommentInfo.avatar!
        let avatarUrl = NSURL(string: imgUrl1)
        self.headImageView.yy_setImageWithURL(avatarUrl, placeholder: UIImage(named: "Logo.png"))
    }
    
}
