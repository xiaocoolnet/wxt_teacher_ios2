//
//  GroupPicViewController.swift
//  WXT_Teacher
//
//  Created by xiaocool on 16/10/9.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class GroupPicViewController: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    var arrayInfo = Array<FSendPicInfo>()
    
    var img = NSString()
    var nu = 0
    var count = 0
    var collectV:UICollectionView?
    var flowLayout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        
        
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        flowLayout.itemSize = CGSizeMake(WIDTH, HEIGHT)
        flowLayout.minimumLineSpacing = 0;
        self.collectV = UICollectionView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, HEIGHT), collectionViewLayout: flowLayout)
        //        注册
        self.collectV?.registerClass(PictureCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        self.collectV?.delegate = self
        self.collectV?.dataSource = self
        self.collectV?.backgroundColor = UIColor.clearColor()
        self.collectV!.pagingEnabled = true
        
        //设置每一个cell的宽高
        //        layout.itemSize = CGSizeMake(WIDTH, HEIGHT)
        self.view.addSubview(collectV!)
        collectV!.contentOffset = CGPointMake(CGFloat(nu)*WIDTH, 0)
        
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return nu
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! PictureCollectionViewCell
        
        
        cell.imgView.frame = CGRectMake(0, 0, frame.width, frame.height)
        cell.imgView.contentMode = .ScaleAspectFit
        cell.clipsToBounds = true
        let str = arrayInfo[indexPath.item].picture_url
        let imgUrl = pictureUrl + str
        let photourl = NSURL(string: imgUrl)
        cell.imgView.yy_setImageWithURL(photourl, placeholder: UIImage(named: "4"))
        cell.contentView.addSubview(cell.imgView)
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
