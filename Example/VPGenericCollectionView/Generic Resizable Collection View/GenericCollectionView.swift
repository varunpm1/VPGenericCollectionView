//
//  GenericCollectionView.swift
//  VPGenericCollectionView
//
//  Created by Varun P M on 15/11/20.
//  Copyright © 2020 Varun P M. All rights reserved.
//

import UIKit

protocol GenericCellProtocol where Self: UICollectionViewCell {
    associatedtype Item
    
    var viewModel: Item? { get set }
}

final class GenericCollectionView<T: GenericCellProtocol>: UIView {
    /// Optional callback to configure cell during cell setup
    var configureCellCallback: ((_ cell: T, _ indexPath: IndexPath) -> Void)? {
        didSet {
            dataSource.configureCellCallback = configureCellCallback
        }
    }
    
    /// Optional callback to handle cell selection
    var didSelectCallback: ((_ item: T.Item, _ indexPath: IndexPath) -> Void)? {
        didSet {
            dataSource.didSelectCallback = didSelectCallback
        }
    }
    
    /// Spacing between cells
    var cellSpacing: CGFloat = 8 {
        didSet {
            (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing = cellSpacing
        }
    }
    
    /// Background color for collection view
    override var backgroundColor: UIColor? {
        didSet {
            collectionView.backgroundColor = backgroundColor
        }
    }
    
    /// Insets to be considered when loading colelction view
    var sectionInsets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0) {
        didSet {
            (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset = sectionInsets
        }
    }
    
    /// Pass minimum cell height which can be taken by cell to avoid constraint break
    var minimumCellHeight: CGFloat = 50 {
        didSet {
            (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.estimatedItemSize = CGSize(width: maximumCellWidth, height: minimumCellHeight)
        }
    }
    
    var maximumCellWidth: CGFloat = 50 {
        didSet {
            (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.estimatedItemSize = CGSize(width: maximumCellWidth, height: minimumCellHeight)
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = cellSpacing
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = sectionInsets
        flowLayout.estimatedItemSize = CGSize(width: maximumCellWidth, height: minimumCellHeight) // Dummy height to control UI break with automatic size when calling reloadData
        
        let genericCollectionView = UICollectionView(frame: bounds, collectionViewLayout: flowLayout)
        genericCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        genericCollectionView.showsVerticalScrollIndicator = false
        genericCollectionView.showsHorizontalScrollIndicator = false
        genericCollectionView.alwaysBounceVertical = true
        genericCollectionView.backgroundColor = backgroundColor ?? .white
        
        return genericCollectionView
    }()
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: bounds.size.width, height: max(collectionView.contentSize.height, shouldHideCollectionView ? 1 : minimumCellHeight)) // Pass a minimum value so as to calculate proper height when loaded from nib
    }
    
    // To avoid deallocating of data source.
    private var dataSource: GenericCollectionViewDataSource<T>!
    
    private var shouldHideCollectionView: Bool = false
    
    init() {
        self.dataSource = GenericCollectionViewDataSource()
        
        super.init(frame: .zero)
        
        setupUI()
        updateDataSource(dataSource: dataSource)
        collectionView.register(UINib(nibName: String(describing: T.self), bundle: nil), forCellWithReuseIdentifier: String(describing: T.self))
    }
    
    required init?(coder: NSCoder) {
        self.dataSource = nil
        
        super.init(coder: coder)
        
        setupUI()
    }
    
    func reload(items: [T.Item]) {
        shouldHideCollectionView = (items.count == 0)
        dataSource.reload(items: items)
        
        collectionView.reloadDataByMaintainingOffset()
    }
    
    private func setupUI() {
        addSubview(collectionView)
    }
    
    private func updateDataSource(dataSource: GenericCollectionViewDataSource<T>) {
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
    }
}
