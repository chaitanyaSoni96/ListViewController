//
//  ExampleListCollectionViewCell.swift
//  ListViewControllerDemo
//
//  Created by Chaitanya Soni on 19/04/21.
//

import UIKit
import ListViewController

class ExampleListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

struct ExampleListCVCellItemViewModel: ItemCellViewModelProtocol {
    var notifyItemHeightChanged: (() -> ())?
    
    var cellNibANDReuseID: String = "ExampleListCollectionViewCell"
    
    var cellHeight: CGFloat = 50
    
    var cellWidth: CGFloat = 0
    
    var data: Codable
    
    var didSelectAction: (() -> ())
    
    func configure(cell: UICollectionViewCell) {
        if let data = data as? ExampleListCellData, let cell = cell as? ExampleListCollectionViewCell {
            cell.label.text = data.text
        }
    }
}


struct ExampleListCellData: Codable {
    let text: String
}
