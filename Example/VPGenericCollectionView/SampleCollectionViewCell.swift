//
//  SampleCollectionViewCell.swift
//  VPGenericCollectionView
//
//  Created by Varun P M on 15/11/20.
//  Copyright © 2020 Varun P M. All rights reserved.
//

import UIKit

// Confirm to GenericCellProtocol
class SampleCollectionViewCell: UICollectionViewCell, GenericCellProtocol {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    
    // Declare viewModel as required. Changing this data type will automatically reflect in reload function and will throw compiler error
    var viewModel: (title: String, description: String)? {
        didSet {
            // Update UI inside this function
            titleLabel.text = viewModel?.title
            longLabel.text = viewModel?.description
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Auto resizing cell won't work without this code
        
    }

}
