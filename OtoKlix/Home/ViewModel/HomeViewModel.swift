//
//  HomeViewModel.swift
//  OtoKlix
//
//  Created by Phincon on 04/02/22.
//

import Foundation
import UIKit
import Alamofire

class HomeViewModel {
    var listPosts: Bindable<[GetPostsListModel]?> = Bindable([])
    var showAlert: Bindable<AlertError?> = Bindable(nil)
    var selectedIndex: Bindable<GetPostsListModel?> = Bindable(nil)
    var showLoading : Bindable<Bool> = Bindable(false)
    var filterList : [GetPostsListModel] = []
    var emptyList: Bindable<Bool?> = Bindable(false)
    
    func showListPost() {
        showLoading.value = true
        APIServices.shared.request(url: Constant.baseUrl + "posts", method: .get, params: [:], encoding: URLEncoding.default, headers: nil) { [weak self] (listpost: [GetPostsListModel]?, errorModel: BaseErrorModel?, error) in
            
            guard let self = self else { return }
            
            self.filterList = []
            self.showLoading.value = false
            
            if let _ = error {
                self.showAlertWith(title: "Error", description: "Please check your connection")
            } else if let errorModels = errorModel {
                self.showAlertWith(title: "Error", description: errorModels.error ?? "")
            } else {
                
                if listpost?.isEmpty == true || listpost == nil {
                    self.emptyList.value = true
                } else {
                    self.emptyList.value = false
                    for i in listpost ?? [] {
                        let test = GetPostsListModel(id: i.id, content: i.content, title: i.title, publishedAt: i.publishedAt?.convertDateStringToDate(date: i.publishedAt ?? ""), createAt: i.createAt?.convertDateStringToDate(date: i.createAt ?? ""), updateAt: i.updateAt?.convertDateStringToDate(date: i.updateAt ?? ""))
                        
                        self.filterList.append(test)
                        
                        self.filterList = self.filterList.sorted(by: {
                            $1.updateAt?.compare($0.updateAt ?? "") == .orderedAscending
                        })
                        
                        self.listPosts.value = self.filterList
                    }
                }
            }
        }
    }
    
    func deleteListPost() {
        showLoading.value = true
        APIServices.shared.request(url: Constant.baseUrl + "posts/\(selectedIndex.value?.id ?? 0)", method: .delete, params: nil, encoding: URLEncoding.default, headers: nil) { [weak self] (listpost: GetPostsListModel?, errorModel: BaseErrorModel?, error) in
            
            guard let self = self else { return }
            self.showLoading.value = false
            if let _ = error {
                self.showAlertWith(title: "Error", description: "Please check your connection")
            } else if let errorModels = errorModel {
                self.showAlertWith(title: "Error", description: errorModels.error ?? "")
            } else {
                self.showListPost()
            }
        }
    }
    
    private func showAlertWith(title: String, description: String){
        let error = AlertError(title: title, description: description, action: AlertAction(title: "OK", handle: {
            self.showListPost()
        }))
        self.showAlert.value = error
    }
}
