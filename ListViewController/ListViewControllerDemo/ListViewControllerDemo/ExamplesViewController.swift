//
//  ExamplesViewController.swift
//  ListViewControllerDemo
//
//  Created by Chaitanya Soni on 19/04/21.
//

import UIKit
import ListViewController

class ExamplesViewController: UIViewController {
    static func instantiate() -> ExamplesViewController {
        let vc = ExamplesViewController(nibName: "ExamplesViewController", bundle: Bundle.init(for: Self.self))
        return vc
    }
    
    lazy var listViewController: ListViewController = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        
        let vc = ListViewController.instantiate(layout: layout)
        self.addChild(vc)
        return vc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.addSubview(listViewController.view)
        listViewController.view.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
        let getDidSelectItem: (ExampleListCellData) -> (() -> ()) = { data in
            return { [weak self] in
                guard let self = self else { return }
                self.showDetailVC(type: data.detailType)
            }
        }
        
        let items: [ItemCellViewModelProtocol] = ExampleListCellData.sampleData.map({
            return ExampleListCVCellItemViewModel(data: $0, didSelectAction: getDidSelectItem($0))
        })
        
        listViewController.loadItems(items)
        
    }
    
    func showDetailVC(type: DetailType) {
        switch type {
        
        case .simple:
            
            break
        case .multiple:
            
            break
        case .autoResizing:
            
            break
        }
    }
}


extension ExampleListCellData {
    static let sampleData = [ExampleListCellData(text: "Simple", detailType: .simple),
                             ExampleListCellData(text: "Multiple Cells", detailType: .multiple),
                             ExampleListCellData(text: "Auto sizing cells", detailType: .autoResizing)]
}

