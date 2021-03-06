//
//  FlexibleTableView.swift
//  FlexibleTableView
//
//  Created by 吴浩文 on 15/7/29.
//  Copyright (c) 2015年 吴浩文. All rights reserved.
//

import UIKit

@objc public protocol FlexibleTableViewDelegate: NSObjectProtocol {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func tableView(tableView: UITableView, numberOfSubRowsAtIndexPath indexPath: NSIndexPath) -> Int
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    func tableView(tableView: UITableView, cellForSubRowAtIndexPath indexPath: FlexibleIndexPath) -> UITableViewCell
    optional func numberOfSectionsInTableView(tableView: UITableView) -> Int
    optional func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    optional func tableView(tableView: UITableView, heightForSubRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    optional func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    optional func tableView(tableView: FlexibleTableView, didSelectSubRowAtIndexPath indexPath: FlexibleIndexPath)
    optional func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    optional func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    optional func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    optional func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String?
    optional func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    optional func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    optional func tableView(tableView: UITableView, shouldExpandSubRowsOfCellAtIndexPath indexPath: NSIndexPath) -> Bool
}

public class FlexibleIndexPath: NSObject{
    public var subRow: Int, row: Int, section: Int, ns: NSIndexPath
    init(forSubRow subrow:Int,inRow row:Int,inSection section:Int){
        self.subRow = subrow
        self.row=row
        self.section=section
        self.ns=NSIndexPath(forRow: row, inSection: section)
    }
}

public class FlexibleTableView : UITableView, UITableViewDelegate, UITableViewDataSource {
    public var flexibleTableViewDelegate: FlexibleTableViewDelegate
    public var shouldExpandOnlyOneCell = false
    
    let kIsExpandedKey = "isExpanded"
    let kSubrowsKey = "subrowsCount"
    let kDefaultCellHeight = 44.0
    
    public let expandableCells = NSMutableDictionary()
    
    public init(frame: CGRect,delegate: FlexibleTableViewDelegate) {
        flexibleTableViewDelegate = delegate
        super.init(frame: frame, style: .Plain)
        self.delegate=self
        self.dataSource=self
        refreshData()
    }
    required public init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let correspondingIndexPath = correspondingIndexPathForRowAtIndexPath(indexPath)
        if correspondingIndexPath.subRow == 0 {
            let expandableCell = flexibleTableViewDelegate.tableView(self, cellForRowAtIndexPath:correspondingIndexPath.ns) as! FlexibleTableViewCell
            
            if (expandableCell.expandable) {
                expandableCell.expanded = (expandableCells[correspondingIndexPath.section] as! NSMutableArray)[correspondingIndexPath.row][kIsExpandedKey] as! Bool
                if (expandableCell.expanded){
                    expandableCell.accessoryView!.transform = CGAffineTransformMakeRotation(CGFloat(M_PI));
                }
            }
            return expandableCell;
        } else {
            let cell = flexibleTableViewDelegate.tableView(self, cellForSubRowAtIndexPath:correspondingIndexPath)
            cell.indentationLevel = 2
            return cell;
        }
    }
    
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated:true)
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        if let x = cell as? FlexibleTableViewCell {
            
            if !x.expandable { return }
            
            x.expanded = !x.expanded
            
            var _indexPath = indexPath
            let correspondingIndexPath = correspondingIndexPathForRowAtIndexPath(_indexPath)
            if (x.expanded && shouldExpandOnlyOneCell) {
                _indexPath = correspondingIndexPath.ns;
                collapseCurrentlyExpandedIndexPaths()
            }
            
            let numberOfSubRows = numberOfSubRowsAtIndexPath(correspondingIndexPath.ns)
            
            var expandedIndexPaths = [NSIndexPath]()
            let row = _indexPath.row;
            let section = _indexPath.section;
            
            for var index = 1; index <= numberOfSubRows; index += 1 {
                let expIndexPath = NSIndexPath(forRow:row+index, inSection:section)
                expandedIndexPaths.append(expIndexPath)
            }
            
            if (x.expanded)
            {
                setExpanded(true, forCellAtIndexPath:correspondingIndexPath)
                insertRowsAtIndexPaths(expandedIndexPaths, withRowAnimation:UITableViewRowAnimation.Top)
            }
            else
            {
                setExpanded(false, forCellAtIndexPath:correspondingIndexPath)
                deleteRowsAtIndexPaths(expandedIndexPaths, withRowAnimation:UITableViewRowAnimation.Top)
            }
            
            x.accessoryViewAnimation()
            
            flexibleTableViewDelegate.tableView?(self, didSelectRowAtIndexPath:indexPath)
            
        } else {
            let correspondingIndexPath = correspondingIndexPathForRowAtIndexPath(indexPath)
            
            flexibleTableViewDelegate.tableView?(self, didSelectSubRowAtIndexPath:correspondingIndexPath)
        }
    }
    
    public func numberOfExpandedSubrowsInSection(section: Int) -> Int {
        var totalExpandedSubrows = 0;
        
        let rows = expandableCells[section] as! [NSDictionary]
        for row in rows {
            if row[kIsExpandedKey] as! Bool {
                totalExpandedSubrows += row[kSubrowsKey] as! Int
            }
        }
        return totalExpandedSubrows;
    }
    
    public func numberOfSubRowsAtIndexPath(indexPath: NSIndexPath) -> Int {
        return flexibleTableViewDelegate.tableView(self, numberOfSubRowsAtIndexPath:indexPath)
    }
    
    func correspondingIndexPathForRowAtIndexPath(indexPath: NSIndexPath) -> FlexibleIndexPath {
        var expandedSubrows = 0;
        
        let rows = self.expandableCells[indexPath.section] as! NSArray
        for (index, value) in rows.enumerate() {
            let isExpanded = value[self.kIsExpandedKey] as! Bool
            var numberOfSubrows = 0;
            if (isExpanded){
                numberOfSubrows = value[self.kSubrowsKey] as! Int
            }
            
            let subrow = indexPath.row - expandedSubrows - index;
            if (subrow > numberOfSubrows){
                expandedSubrows += numberOfSubrows;
            }
            else{
                return FlexibleIndexPath(forSubRow: subrow, inRow: index, inSection: indexPath.section)
            }
        }
        return FlexibleIndexPath(forSubRow: 0, inRow: 0, inSection: 0)
    }
    
    public func setExpanded(isExpanded: Bool, forCellAtIndexPath indexPath: FlexibleIndexPath) {
        let cellInfo = (expandableCells[indexPath.section] as! NSMutableArray)[indexPath.row] as! NSMutableDictionary
        cellInfo.setObject(isExpanded, forKey:kIsExpandedKey)
    }
    
    public func collapseCurrentlyExpandedIndexPaths() {
        var totalExpandedIndexPaths = [NSIndexPath]()
        let totalExpandableIndexPaths = NSMutableArray()
        
        for x in expandableCells {
            var totalExpandedSubrows = 0;
            
            for (index, value) in (x.value as! NSArray).enumerate() {
                
                let currentRow = index + totalExpandedSubrows;
                
                if (value[kIsExpandedKey] as! Bool)
                {
                    let expandedSubrows = value[kSubrowsKey] as! Int
                    for (var index = 1; index <= expandedSubrows; index += 1)
                    {
                        let expandedIndexPath = NSIndexPath(forRow:currentRow + index, inSection:x.key as! Int)
                        totalExpandedIndexPaths.append(expandedIndexPath)
                    }
                    
                    value.setObject(false, forKey:kIsExpandedKey)
                    totalExpandedSubrows += expandedSubrows;
                    
                    totalExpandableIndexPaths.addObject(NSIndexPath(forRow:currentRow, inSection:x.key as! Int))
                }
            }
        }
        
        
        for indexPath in totalExpandableIndexPaths
        {
            let cell = cellForRowAtIndexPath(indexPath as! NSIndexPath) as! FlexibleTableViewCell
            cell.expanded = false
            cell.accessoryViewAnimation()
        }
        
        deleteRowsAtIndexPaths(totalExpandedIndexPaths, withRowAnimation:UITableViewRowAnimation.Top)
    }
    
    public func refreshData(){
        expandableCells.removeAllObjects()
        for section in 0 ..< numberOfSections {
            let numberOfRowsInSection = flexibleTableViewDelegate.tableView(self, numberOfRowsInSection:section)
            let rows = NSMutableArray()
            for row in 0 ..< numberOfRowsInSection {
                let rowIndexPath = NSIndexPath(forRow:row, inSection:section)
                let numberOfSubrows = flexibleTableViewDelegate.tableView(self, numberOfSubRowsAtIndexPath:rowIndexPath)
                var isExpandedInitially = false
                if flexibleTableViewDelegate.respondsToSelector(#selector(FlexibleTableViewDelegate.tableView(_:shouldExpandSubRowsOfCellAtIndexPath:))) {
                    isExpandedInitially = flexibleTableViewDelegate.tableView!(self, shouldExpandSubRowsOfCellAtIndexPath:rowIndexPath)
                }
                let rowInfo = NSMutableDictionary(objects:[isExpandedInitially, numberOfSubrows], forKeys:[kIsExpandedKey, kSubrowsKey])
                rows.addObject(rowInfo)
            }
            expandableCells.setObject(rows, forKey:section)
        }
        super.reloadData()
    }
    
    
    
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        if flexibleTableViewDelegate.respondsToSelector(#selector(FlexibleTableViewDelegate.numberOfSectionsInTableView(_:))) {
            return flexibleTableViewDelegate.numberOfSectionsInTableView!(self)
        }
        return 1;
    }
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return flexibleTableViewDelegate.tableView(self, numberOfRowsInSection:section) + numberOfExpandedSubrowsInSection(section)
    }
    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        let correspondingIndexPath = correspondingIndexPathForRowAtIndexPath(indexPath)
        if correspondingIndexPath.subRow == 0 {
            if flexibleTableViewDelegate.respondsToSelector(#selector(FlexibleTableViewDelegate.tableView(_:heightForRowAtIndexPath:))) {
                return flexibleTableViewDelegate.tableView!(self, heightForRowAtIndexPath:correspondingIndexPath.ns)
            }
            return 60.0;
        } else {
            if flexibleTableViewDelegate.respondsToSelector(#selector(FlexibleTableViewDelegate.tableView(_:heightForSubRowAtIndexPath:))) {
                return flexibleTableViewDelegate.tableView!(self, heightForSubRowAtIndexPath:correspondingIndexPath.ns)
            }
            return 60.0;
        }
    }
    public func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if flexibleTableViewDelegate.respondsToSelector(#selector(FlexibleTableViewDelegate.tableView(_:heightForHeaderInSection:))) {
            return flexibleTableViewDelegate.tableView!(self, heightForHeaderInSection: section)
        }
        return 0.0
    }
    public func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if flexibleTableViewDelegate.respondsToSelector(#selector(FlexibleTableViewDelegate.tableView(_:heightForFooterInSection:))) {
            return flexibleTableViewDelegate.tableView!(self, heightForFooterInSection: section)
        }
        return 0.0
    }
    public func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return flexibleTableViewDelegate.tableView?(self, titleForHeaderInSection: section)
    }
    public func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return flexibleTableViewDelegate.tableView?(self, titleForFooterInSection: section)
    }
    public func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return flexibleTableViewDelegate.tableView?(self, viewForHeaderInSection: section)
    }
    public func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return flexibleTableViewDelegate.tableView?(self, viewForFooterInSection: section)
    }
}