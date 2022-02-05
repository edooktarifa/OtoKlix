//
//  BaseViewController.swift
//  OtoKlix
//
//  Created by Phincon on 04/02/22.
//

import UIKit
import NVActivityIndicatorView

class BaseViewController: UIViewController {

    let loading = NVActivityIndicatorView(frame: .zero, type: .ballRotateChase, color: UIColor.red)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configView()
        setupLoading()
    }
    
    func configView(){
        
    }
    
    func setupLoading(){
        self.loading.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.loading)
        
        NSLayoutConstraint.activate([
            self.loading.widthAnchor.constraint(equalToConstant: 40),
            self.loading.heightAnchor.constraint(equalToConstant: 40),
            self.loading.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.loading.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }

    func showError(with error: AlertError){
        let alert = UIAlertController(title: error.title, message: error.description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: error.action.title, style: .default, handler: { alert in
            error.action.handle?()
        }))
        present(alert, animated: true, completion: nil)
    }
}
