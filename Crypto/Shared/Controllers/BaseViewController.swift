//
//  BaseViewController.swift
//  Crypto
//
//  Created by Yaroslav Babalich on 4/29/18.
//  Copyright © 2018 PxToday. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    // MARK: - Variable
    var navigationTitle: String {
        return "Base title"
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = self.navigationTitle
        setupButtons()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Public methods
    @objc func navigationGoBackEvent() {
        navigationVC.popViewController(animated: true)
    }
    
    // MARK: - Private methods
    private func setupButtons() {
        let shareButton = UIBarButtonItem(title: "←",
                                          style: .plain,
                                          target: self,
                                          action: #selector(navigationGoBackEvent))
        shareButton.tintColor = .yellow
        navigationItem.leftBarButtonItems = [shareButton]
    }
    
}
