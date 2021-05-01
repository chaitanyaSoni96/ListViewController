//
//  Created by Chaitanya Soni on 19/04/21.
//

import UIKit


//Requirements

/*
 
 A vc that takes a view model array registers cell using the view model type and bundle, vc passes lifecycle methods to view model at index with cell
 view model that has cell configure code, on click action closures using uiaction [weak self] ,has cell reaction code(expand collapse),
 view model has func to get the collectionview and return a dequed cell with data configured.
 
 
 
 */


public class ListViewController: UIViewController {
    
    public static func instantiate(layout: UICollectionViewFlowLayout) -> Self {
        let vc = Self()
        vc.layout = layout
        return vc
    }
    
    private var layout: UICollectionViewFlowLayout!
    
    private lazy var itemListController: SectionedItemListController = {
        let itemListController = SectionedItemListController(collectionView: collectionView, sectionInsets: layout.sectionInset)
        return itemListController
    }()
    
    internal lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    private var items: [ItemSectionViewModelProtocol] = [] {
        didSet {
            
            self.itemListController.loadData(viewModelArray: items)
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        self.view.addSubview(collectionView)
        view.anchor(top: collectionView.topAnchor, leading: collectionView.leadingAnchor, bottom: collectionView.bottomAnchor, trailing: collectionView.trailingAnchor)
    }
    
    public func loadItems(_ items: [ItemCellViewModelProtocol]) {
        
        var tempItems = items
        injectCompletionForReloadOnHeightChange(in: &tempItems)
        
        self.items = [SingleSectionViewModel(itemCellArray: tempItems)]
        
    }
    
    public func loadItems(_ items: [ItemSectionViewModelProtocol]) {
        let tempSections: [ItemSectionViewModelProtocol] = items.map({ section in
            var tempSection = section
            injectCompletionForReloadOnHeightChange(in: &tempSection.itemCellArray)
            return tempSection
        })
        
        self.items = tempSections
    }
    
    private func injectCompletionForReloadOnHeightChange(in items: inout [ItemCellViewModelProtocol]) {
        for (index, _) in items.enumerated() {
            let reload = { [weak self] in
                guard let `self` = self else { return }
                self.collectionView.reloadData()
            }
            items[index].notifyItemHeightChanged = reload
        }
    }
    
    struct SingleSectionViewModel: ItemSectionViewModelProtocol {
        var itemCellArray: [ItemCellViewModelProtocol]
        var header: ItemHeaderFooterViewModelProtocol? = nil
        var footer: ItemHeaderFooterViewModelProtocol? = nil
    }
}

