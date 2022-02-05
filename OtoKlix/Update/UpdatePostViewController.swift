//
//  UpdateViewController.swift
//  OtoKlix
//
//  Created by Phincon on 05/02/22.
//

import UIKit

enum updateOrPostScreen {
    case update
    case post
}

class UpdatePostViewController: BaseViewController, UITextViewDelegate {

    @IBOutlet weak var titleTf: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var updateBtn: UIButton!
    
    var vm = UpdateViewModel()
    var detail: GetPostsListModel?
    var checkScreen: updateOrPostScreen = .update
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        contentTextView.layer.cornerRadius = 10
        titleTf.addTarget(self, action: #selector(textfieldUpdate(_:)), for: .editingChanged)
        contentTextView.delegate = self
        updateBtn.layer.cornerRadius = 20
        vm.delegate = self
    }
    
    override func configView() {
        super.configView()
        vm.showLoading.bind { [weak self] loading in
            
            guard let self = self else { return }
            
            if loading != true {
                self.loading.stopAnimating()
            }
        }
        
        vm.showAlert.bind { [weak self] alert in
            guard let self = self else { return }
            
            if let alert = alert {
                self.showError(with: alert)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if checkScreen == .post {
            updateBtn.setTitle("Post", for: .normal)
        } else {
            titleTf.text = detail?.title
            contentTextView.text = detail?.content
            updateBtn.setTitle("Update", for: .normal)
        }
        
        checkValidation()
    }
    
    @objc func textfieldUpdate(_ textfield: UITextField){
        checkValidation()
    }
    
    func checkValidation(){
        updateBtn.isUserInteractionEnabled = false
        updateBtn.backgroundColor = UIColor.blue.withAlphaComponent(0.4)
        
        guard let title = titleTf.text, !title.isEmpty, let content = contentTextView.text, !content.isEmpty else { return }
        
        updateBtn.isUserInteractionEnabled = true
        updateBtn.backgroundColor = UIColor.blue.withAlphaComponent(0.8)
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        checkValidation()
    }
    
    @IBAction func updatePosts(_ sender: UIButton){
        self.loading.startAnimating()
        switch checkScreen {
        case .update:
            vm.selectedIndex.value = detail
            vm.updateListPost(title: titleTf.text ?? "", content: contentTextView.text ?? "")
            
        case .post:
            vm.createPost(title: titleTf.text ?? "", content: contentTextView.text ?? "")
        }
    }
}

extension UpdatePostViewController: HandleAlert {
    func didSelectOk() {
        self.navigationController?.popViewController(animated: true)
    }
}
