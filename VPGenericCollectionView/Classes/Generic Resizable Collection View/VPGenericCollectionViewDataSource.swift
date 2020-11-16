//
//  VPGenericCollectionViewDataSource.swift
//  VPGenericCollectionView
//
//  Created by Varun P M on 15/11/20.
//  Copyright © 2020 Varun P M. All rights reserved.
//

import UIKit

final class VPGenericCollectionViewDataSource<T: VPGenericCellProtocol>: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var configureCellCallback: ((_ cell: T, _ indexPath: IndexPath) -> Void)?
    
    var didSelectCallback: ((_ item: T.Item, _ indexPath: IndexPath) -> Void)?
    
    private var items: [T.Item] = []
    
    // Stores the width constraints which can be easier to access instead of looping through constraints of contentView using identifier
    private var constraintsDataSource: [String: NSLayoutConstraint] = [:]
    
    func reload(items: [T.Item]) {
        self.items = items
    }
    
    // MARK: UICollectionViewDataSource and UICollectionViewDelegateFlowLayout functions
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as! T
        
        cell.viewModel = items[indexPath.item]
        configureCellCallback?(cell, indexPath)
        
        constraintsDataSource["\(indexPath.section)+\(indexPath.item)"]?.isActive = false
        
        let widthConstraint = cell.contentView.widthAnchor.constraint(equalToConstant: (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.estimatedItemSize.width ?? 0)
        widthConstraint.isActive = true
        
        constraintsDataSource["\(indexPath.section)+\(indexPath.item)"] = widthConstraint
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = items[indexPath.item]
        didSelectCallback?(selectedItem, indexPath)
    }
}
