
//
//  TableViewDataSource.swift
//  ShopifyChallenge
//
//  Created by Haspinder on 20/01/19.
//  Copyright © 2019 Haspinder. All rights reserved.
//

import Foundation
import UIKit


typealias  ListCellConfigureBlock = (_ cell : AnyObject , _ item : AnyObject? , _ indexPath : IndexPath?) -> ()
typealias  DidSelectedRow = (_ indexPath : IndexPath) -> ()

class TableDataSource: NSObject {
    
    
    var items : Array<AnyObject>?
    var cellIdentifier : String?
    var tableView  : UITableView?
    var tableViewRowHeight : CGFloat = 44.0
    var configureCellBlock : ListCellConfigureBlock?
    var aRowSelectedListener : DidSelectedRow?
    
    init (items : Array<AnyObject>? , height : CGFloat , tableView : UITableView? , cellIdentifier : String?  , configureCellBlock : ListCellConfigureBlock? , aRowSelectedListener : @escaping DidSelectedRow) {
        
        self.tableView = tableView
        
        self.items = items
        
        self.cellIdentifier = cellIdentifier
        
        self.tableViewRowHeight = height
        
        self.configureCellBlock = configureCellBlock
        
        self.aRowSelectedListener = aRowSelectedListener
        
    }
    
    
    override init() {
        
        super.init()
        
    }
    
}



extension TableDataSource : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let identifier = cellIdentifier else{
            
            fatalError("Cell identifier not provided")
            
        }
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier , for: indexPath) as UITableViewCell
        
//        let selectedView = UIView()
//        selectedView.backgroundColor = UIColor(red: 255.0/255, green: 255.0/255, blue:     255.0/255.0, alpha: 0.0)
//        cell.selectedBackgroundView = selectedView
        
        
        if let block = self.configureCellBlock , let item: AnyObject = self.items?[indexPath.row]{
            
            block(cell , item ,indexPath)
            
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let block = self.aRowSelectedListener{
            block(indexPath)
        }
        self.tableView?.deselectRow(at: indexPath, animated: true)
        
        //Clear automatic selection of home
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    
    
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableViewRowHeight
}

}
