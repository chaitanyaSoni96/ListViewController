//
//  Created by Chaitanya Soni on 19/04/21.
//

import UIKit


public class HeightUpdatingListViewController: ListViewController {
    static func instantiate(layout: UICollectionViewFlowLayout, whenUpdatesContentSize: @escaping ((CGSize) -> Void)) -> HeightUpdatingListViewController {
        let vc = HeightUpdatingListViewController.instantiate(
            layout: layout)
        vc.didUpdateCollectionViewContentSize = whenUpdatesContentSize
        return vc
    }
    var didUpdateCollectionViewContentSize: ((CGSize) -> Void)!
    
    public override func loadItems(_ items: [ItemCellViewModelProtocol]) {
        super.loadItems(items)
        self.collectionView.layoutIfNeeded()
        didUpdateCollectionViewContentSize(collectionView.contentSize)
    }
    
    public override func loadItems(_ items: [ItemSectionViewModelProtocol]) {
        super.loadItems(items)
        self.collectionView.layoutIfNeeded()
        didUpdateCollectionViewContentSize(collectionView.contentSize)
    }
}
