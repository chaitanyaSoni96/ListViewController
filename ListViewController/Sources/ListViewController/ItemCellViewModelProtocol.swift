//
//  Created by Chaitanya Soni on 19/04/21.
//

import UIKit

public protocol ItemCellViewModelProtocol  {
    var notifyItemHeightChanged: (() -> ())? { set get }
    
    /// Nib name and Reuse Identifier must be the same.
    var cellNibANDReuseID: String { get }
    var cellHeight: CGFloat { get }
    var cellWidth: CGFloat { get }
    var data: Codable { get set }
    
    var didSelectAction: (() -> ()) { get set }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    func getCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
    
    func willDisplayCell(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    func configure(cell: UICollectionViewCell)
}


public protocol ItemHeaderFooterViewModelProtocol {
    var height: CGFloat { get }
    var width: CGFloat { get }
    
    /// Nib name and Reuse Identifier must be the same.
    var nibANDReuseID: String { get }
    
    var data: Codable { get set }
    
    var didSelectAction: (() -> ()) { get set }
    
    func getReusableView(_ collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionReusableView
}


public protocol ItemSectionViewModelProtocol {
    var itemCellArray: [ItemCellViewModelProtocol] { get set }
    
    var header: ItemHeaderFooterViewModelProtocol? { get }
    var footer: ItemHeaderFooterViewModelProtocol? { get }
}


public extension ItemCellViewModelProtocol {
    
    func getCell(collectionView: UICollectionView,
                 indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellNibANDReuseID, for: indexPath)
        configure(cell: cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard
        let layout = collectionViewLayout as? UICollectionViewFlowLayout
        else {
            fatalError()
        }
        
        let sectionInsets = layout.sectionInset
        
        if layout.scrollDirection == .vertical {
            
            /* we take full width of collectionview minus the insets
             for the cell width if the scroll direction is vertical */
            let collectionViewWidth = collectionView.frame.width
            let sectionInsetLeftRight = sectionInsets.left + sectionInsets.right
            
            //if width is not assigned in view model, take auto width
            let autoWidth = collectionViewWidth - sectionInsetLeftRight
            let width = self.cellWidth == 0 ? autoWidth : self.cellWidth
            
            let size = CGSize.init(width: width, height: cellHeight)
            
            return size
            
        } else {
            
            /* we take full height of collectionview minus the insets
             for the cell width if the scroll direction is horizontal */
            
            let collectionViewHeight = collectionView.frame.height
            let sectionInsetTopBottom = sectionInsets.top + sectionInsets.bottom
            
            //if height is not assigned in view model, take auto height
            let autoHeight = collectionViewHeight - sectionInsetTopBottom
            let height = self.cellHeight == 0 ? autoHeight : self.cellHeight
            let size = CGSize.init(width: cellWidth, height: height)
            return size
        }
    }
    
    func willDisplayCell(_ collectionView: UICollectionView,
                         willDisplay cell: UICollectionViewCell,
                         forItemAt indexPath: IndexPath) {
        
    }
}
