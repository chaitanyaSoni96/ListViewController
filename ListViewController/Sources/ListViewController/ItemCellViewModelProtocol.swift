//
//  Created by Chaitanya Soni on 19/04/21.
//

import UIKit

public protocol ItemCellViewModelProtocol  {
    /// Cell Nib name and Reuse Identifier must be the same.
    var notifyItemHeightChanged: (() -> ())? { set get }
    
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


public extension ItemCellViewModelProtocol {
    func getCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellNibANDReuseID, for: indexPath)
        configure(cell: cell)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
            fatalError()
        }
        if layout.scrollDirection == .vertical {
            let autoWidth = collectionView.frame.width - (layout.sectionInset.left + layout.sectionInset.right)
            let size = CGSize.init(width: cellWidth == 0 ? autoWidth : cellWidth, height: cellHeight)
            print(size)
            return size
        } else {
            let autoHeight = collectionView.frame.height - (layout.sectionInset.left + layout.sectionInset.right)
            let size = CGSize.init(width: cellWidth, height: cellHeight == 0 ? autoHeight : cellHeight)
            print(size)
            return size
        }
    }
    func willDisplayCell(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
}

public protocol ItemSectionViewModelProtocol {
    var itemCellArray: [ItemCellViewModelProtocol] { get set }
    
    var header: ItemHeaderFooterViewModelProtocol? { get }
    var footer: ItemHeaderFooterViewModelProtocol? { get }
    
    
    
}

public protocol ItemHeaderFooterViewModelProtocol {
    var height: CGFloat { get }
    var width: CGFloat { get }
    
    var nibANDReuseID: String { get }
    
    var data: Codable { get set }
    
    var didSelectAction: (() -> ()) { get set }
    
    func getReusableView(_ collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionReusableView
    
}
