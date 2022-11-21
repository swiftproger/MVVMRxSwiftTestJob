//
//  RootViewController.swift
//  MVVMRxSwiftTestJob
//
//  Created by Александр Новиков on 15.11.2022.
//

import UIKit

class RootViewController: UIViewController {
    
    private var isLogined = true
    private var activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        logined()
    }
    
    private func logined() {
        if self.isLogined {
            perform(#selector(showController), with: nil, afterDelay: 0.01)
        }
    }
    
    @objc
    private func showController() {
        let controller = LoginViewController()
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: false, completion: nil)
    }
}
