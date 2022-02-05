//
//  UpdateViewModel.swift
//  OtoKlix
//
//  Created by Phincon on 05/02/22.
//

import Foundation
import UIKit
import Alamofire

protocol HandleAlert {
    func didSelectOk()
}

enum HandleAlertError {
    case success
    case error
}

class UpdateViewModel {
    
    var selectedIndex: Bindable<GetPostsListModel?> = Bindable(nil)
    var showLoading : Bindable<Bool> = Bindable(false)
    var showAlert: Bindable<AlertError?> = Bindable(nil)
    
    var delegate: HandleAlert?
    
    func updateListPost(title: String, content: String) {
        
        let param = ["title": title, "content":content]
        
        self.showLoading.value = true
        APIServices.shared.request(url: Constant.baseUrl + "posts/\(selectedIndex.value?.id ?? 0)", method: .put, params: param, encoding: URLEncoding.default, headers: nil) { [weak self] (listpost: GetPostsListModel?, errorModel: BaseErrorModel?, error) in
            
            guard let self = self else { return }
            
            self.showLoading.value = false
            
            if let _ = error {
                self.showAlertWith(title: "Error", description: "Please check your connection", status: .error)
            } else if let errorModels = errorModel {
                self.showAlertWith(title: "Error", description: errorModels.error ?? "", status: .error)
            } else {
                self.showAlertWith(title: "Success", description: "Success Update", status: .success)
            }
            
        }
    }
    
    func createPost(title: String, content: String){
        let param = ["title": title, "content":content]
        
        self.showLoading.value = true
        
        APIServices.shared.request(url: Constant.baseUrl + "posts", method: .post, params: param, encoding: URLEncoding.default, headers: nil) { [weak self] (listpost: GetPostsListModel?, errorModel: BaseErrorModel?, error) in
            
            guard let self = self else { return }
            
            self.showLoading.value = false
            
            if let _ = error {
                self.showAlertWith(title: "Error", description: "Please check your connection", status: .error)
            } else if let errorModels = errorModel {
                self.showAlertWith(title: "Error", description: errorModels.error ?? "", status: .error)
            } else {
                self.showAlertWith(title: "Success", description: "Success create new post", status: .success)
            }
            
        }
    }
    
    private func showAlertWith(title: String, description: String, status: HandleAlertError){
        let error = AlertError(title: title, description: description, action: AlertAction(title: "OK", handle: {
            
            if status == .success {
                self.delegate?.didSelectOk()
            }
            
        }))
        self.showAlert.value = error
    }
}
