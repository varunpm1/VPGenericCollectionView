//
//  ViewController.swift
//  VPGenericCollectionView
//
//  Created by Varun P M on 15/11/20.
//  Copyright © 2020 Varun P M. All rights reserved.
//

import UIKit
import VPGenericCollectionView

class ViewController: UIViewController {
    
    let collectionView = VPGenericCollectionView<SampleCollectionViewCell>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView.maximumCellWidth = UIScreen.main.bounds.size.width / 2
        collectionView.frame = view.bounds
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
        
        optionSetup()
        
        // Dummy
        let data = [("title1", loremIpsum()),
                    ("title1", loremIpsum()),
                    ("title1", loremIpsum()),
                    ("title1", loremIpsum()),
                    ("title1", loremIpsum()),
                    ("title1", loremIpsum())]
        
        // Call reload whenver we have proper data
        collectionView.reload(items: data)
    }
    
    // All Optional setup variable/closures
    private func optionSetup() {
        collectionView.minimumCellHeight = 60 // Here 59 is minimum required height for the cell - Title Label top space (8) + Long Label top and bottom space (8 + 8) + dummy view height constraint (35). Rounded it to 60. Anything below 59 will result in constraint breaks
        collectionView.backgroundColor = .green
        collectionView.sectionInsets = UIEdgeInsets(top: 100, left: 0, bottom: 50, right: 0)
        collectionView.cellSpacing = 20
        
        collectionView.configureCellCallback = { cell, indexPath in
            if indexPath.item == 0 {
                cell.titleLabel.backgroundColor = .red
            } else {
                cell.titleLabel.backgroundColor = .clear
            }
        }
        
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

