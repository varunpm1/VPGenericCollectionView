//
//  GenericCollectionViewDataSource.swift
//  VPGenericCollectionView
//
//  Created by Varun P M on 15/11/20.
//  Copyright © 2020 Varun P M. All rights reserved.
//

import UIKit

final class GenericCollectionViewDataSource<T: GenericCellProtocol>: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var configureCellCallback: ((_ cell: T, _ indexPath: IndexPath) -> Void)?
    
    var didSelectCallback: ((_ item: T.Item, _ indexPath: IndexPath) -> Void)?
    
    private var items: [T.Item] = []
    
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
        
        cell.contentView.constraints.filter { constraint -> Bool in
            constraint.identifier == "GenericCellConstraintIdentifier"
        }.forEach { constraint in
            constraint.isActive = false
        }
        
        let widthConstraint = cell.contentView.widthAnchor.constraint(equalToConstant: (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.estimatedItemSize.width ?? 0)
        widthConstraint.identifier = "GenericCellConstraintIdentifier"
        widthConstraint.isActive = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = items[indexPath.item]
        didSelectCallback?(selectedItem, indexPath)
    }
}
