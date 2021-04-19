//
//  Created by Chaitanya Soni on 19/04/21.
//

import UIKit

class SectionedItemListController: NSObject {
    
    var viewModelArray: [ItemSectionViewModelProtocol] = []
    var collectionView: UICollectionView
    var sectionInsets: UIEdgeInsets
    
    init(collectionView: UICollectionView, sectionInsets: UIEdgeInsets) {
        
        self.collectionView = collectionView
        self.sectionInsets = sectionInsets
        
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func loadData(viewModelArray: [ItemSectionViewModelProtocol]) {
        self.viewModelArray = viewModelArray
        
        let bundle = Bundle.init(for: SectionedItemListController.self)
        
        let uniqueCellNibNames: [String] = viewModelArray.flatMap { (section) -> [String] in section.itemCellArray.map({ $0.cellNibANDReuseID }) }.uniqued()
        let uniqueHeaderNibNames: [String] = viewModelArray.compactMap { section in section.header?.nibANDReuseID }.uniqued()
        let uniqueFooterNibNames: [String] = viewModelArray.compactMap{ section in section.footer?.nibANDReuseID }.uniqued()
        
        uniqueCellNibNames.forEach({
            collectionView.register(UINib(nibName: $0, bundle: bundle),
                                    forCellWithReuseIdentifier: $0)
            
        })
        
        uniqueHeaderNibNames.forEach({
            collectionView.register(UINib(nibName: $0, bundle: bundle),
                                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                    withReuseIdentifier: $0)
        })
        
        uniqueFooterNibNames.forEach({
            collectionView.register(UINib(nibName: $0, bundle: bundle),
                                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                    withReuseIdentifier: $0)
        })
        
        collectionView.reloadData()
    }
}

extension SectionedItemListController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: viewModelArray[section].header?.width ?? 0, height: viewModelArray[section].header?.height ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: viewModelArray[section].footer?.width ?? 0, height: viewModelArray[section].footer?.height ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = viewModelArray[indexPath.section].header else { fatalError("Header not found") }
            return header.getReusableView(collectionView, at: indexPath)
        case UICollectionView.elementKindSectionFooter:
            guard let footer = viewModelArray[indexPath.section].footer else { fatalError("Footer not found") }
            return footer.getReusableView(collectionView, at: indexPath)
            
        default: fatalError("Not handled for \(kind)")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModelArray[section].itemCellArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        viewModelArray[indexPath.section].itemCellArray[indexPath.row].getCell(collectionView: collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModelArray[indexPath.section].itemCellArray[indexPath.row].willDisplayCell(collectionView, willDisplay: cell, forItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModelArray[indexPath.section].itemCellArray[indexPath.row].didSelectAction()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        viewModelArray[indexPath.section].itemCellArray[indexPath.row].collectionView(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath)
    }
}

