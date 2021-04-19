//
//  ExamplesViewController.swift
//  ListViewControllerDemo
//
//  Created by Chaitanya Soni on 19/04/21.
//

import UIKit

class ExamplesViewController: UIViewController {
    static func instantiate() -> ExamplesViewController {
        let vc = ExamplesViewController(nibName: "ExamplesViewController", bundle: Bundle.init(for: Self.self))
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

