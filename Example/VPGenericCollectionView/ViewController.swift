//
//  ViewController.swift
//  VPGenericCollectionView
//
//  Created by Varun P M on 15/11/20.
//  Copyright © 2020 Varun P M. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let collectionView = GenericCollectionView<SampleCollectionViewCell>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Set frame with auto resizing mask or constraints whichever is appropriate
        collectionView.frame = view.bounds
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Add the view as subview to self.view or container view
        view.addSubview(collectionView)
        
        // Pass the required maxCellWidth which has to be constrained with expandable height
        collectionView.maximumCellWidth = UIScreen.main.bounds.size.width / 2
        
        let data = [("title1", loremIpsum()),
                    ("title1", loremIpsum()),
                    ("title1", loremIpsum()),
                    ("title1", loremIpsum()),
                    ("title1", loremIpsum()),
                    ("title1", loremIpsum())]
        
        // Call reload whenver we have proper data
        collectionView.reload(items: data)
        
        optionSetup()
    }
    
    // All Optional setup variable/closures
    private func optionSetup() {
        // Optional - Minimum cell height to be used when the content is very minimal.
        collectionView.minimumCellHeight = 100
        
        // Optional - General collection view background color, insets, spacing
        collectionView.backgroundColor = .green
        collectionView.sectionInsets = UIEdgeInsets(top: 100, left: 0, bottom: 50, right: 0)
        collectionView.cellSpacing = 20
        
        // Optional - Define this closure if something has to be updated on top of normal viewModel based customization, eg., add/remove subviews, handle some condition based on indexPath etc
        collectionView.configureCellCallback = { cell, indexPath in
            if indexPath.item == 0 {
                cell.titleLabel.backgroundColor = .red
            } else {
                cell.titleLabel.backgroundColor = .clear
            }
        }
        
        // Optional - Define this closure if didselect of cell has to be handled
        collectionView.didSelectCallback = { data, indexPath in
            if indexPath.item == 1 {
                print("Detected second cell tap")
            }
        }
    }
    
    // Dummy function to populate data
    private func loremIpsum() -> String {
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    }
}

