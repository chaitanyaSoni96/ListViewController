//
//  SingleLabelPaddedCell.swift
//  ListViewControllerDemo
//
//  Created by Chaitanya Soni on 27/09/21.
//

import UIKit
import ListViewController

class SingleLabelPaddedCell: UICollectionViewCell {

    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var trailing: NSLayoutConstraint!
    @IBOutlet weak var top: NSLayoutConstraint!
    @IBOutlet weak var bottom: NSLayoutConstraint!
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

struct SingleLabelPaddedCellItemViewModel: ItemCellViewModelProtocol {
    var notifyItemHeightChanged: (() -> ())?
    
    var cellNibANDReuseID: String = "SingleLabelPaddedCell"
    
    var cellHeight: CGFloat = 50
    
    var cellWidth: CGFloat = 0
    
    var data: Codable
    
    var didSelectAction: (() -> ())
    
    var configure: ((SingleLabelPaddedCell) -> Void)
    
    func configure(cell: UICollectionViewCell) {
        guard let cell = cell as? SingleLabelPaddedCell else { return }
        
        self.configure(cell)
        
    }
}

