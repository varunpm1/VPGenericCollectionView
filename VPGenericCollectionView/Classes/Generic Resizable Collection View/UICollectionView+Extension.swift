//
//  UICollectionView+Extension.swift
//  VPGenericCollectionView
//
//  Created by Varun P M on 15/11/20.
//  Copyright © 2020 Varun P M. All rights reserved.
//

import UIKit

extension UICollectionView {
    func registerClass<T: UICollectionViewCell>(_ cell: T.Type) {
        self.register(T.self, forCellWithReuseIdentifier: String(describing: cell))
    }
    
    func registerNib<T: UICollectionViewCell>(_ cell: T.Type) {
        self.register(UINib(nibName: String(describing: cell), bundle: nil), forCellWithReuseIdentifier: String(describing: cell))
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("Invalid cell dequeued. Register cell properly before using")
        }
        
        cell.tag = indexPath.item
        
        return cell
    }
    
    func registerNib<T: UICollectionReusableView>(_ view: T.Type, forSupplementaryViewOfKind kind: String) {
        self.register(UINib(nibName: String(describing: view), bundle: nil), forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: view))
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind: String, for indexPath: IndexPath) -> T {
        guard let reusableView = self.dequeueReusableSupplementaryView(ofKind: ofKind, withReuseIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("Invalid reusable view dequeued. Register reusable view properly before using")
        }
        
        return reusableView
    }
    
    // This fixes crash when reloadData is called for self-sizing cell and also calculates cell height properly when placed inside another cell
    func reloadDataByMaintainingOffset() {
        // Retain offset which wouldn't be automatically handled due to self sizing cells
        var contentOffset = self.contentOffset
        reloadData()
        
        DispatchQueue.main.async {
            self.collectionViewLayout.invalidateLayout() // This fixes crash when reloadData is called for self-sizing cell and also calculates cell height properly when placed inside another cell
            self.superview?.invalidateIntrinsicContentSize() // force calculate the intrinsic content size
            
            // App scrolls to top for self sizing collection view cells when calling reloadData. So reset the offset with previous offset value
            // To recaculate the content size properly again to adjust the offset properly, dispatch main is needed
            DispatchQueue.main.async {
                // Set offset back only if the content size hasn't reduced
                contentOffset.x = max(-self.adjustedContentInset.left, min(self.contentSize.width - self.frame.size.width + self.adjustedContentInset.right, contentOffset.x))
                contentOffset.y = max(-self.adjustedContentInset.top, min(self.contentSize.height - self.frame.size.height + self.adjustedContentInset.bottom, contentOffset.y))
                
                self.contentOffset = contentOffset
            }
        }
    }
}
