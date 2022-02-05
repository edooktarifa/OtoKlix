//
//  HomeDataSource.swift
//  OtoKlix
//
//  Created by Phincon on 04/02/22.
//

import Foundation
import UIKit

protocol HomeDataSourceDelegate {
    func moveToDetail(withData: GetPostsListModel)
    func moveToUpdateScreen(withIndex: GetPostsListModel)
}

class HomeDataSource: NSObject {
    weak var vm: HomeViewModel?
    weak var tableView: UITableView?
    var delegate: HomeDataSourceDelegate?
    var view: BaseViewController?
    
    init(vm: HomeViewModel? = nil, tableView: UITableView? = nil, view: BaseViewController? = nil) {
        self.vm = vm
        self.tableView = tableView
        self.view = view
    }
}

extension HomeDataSource: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm?.listPosts.value?.count ?? 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeViewCell", for: indexPath) as! HomeViewCell
        let content = vm?.listPosts.value?[indexPath.row]
        cell.setContent(with: content)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detail = vm?.listPosts.value?[indexPath.row] {
            delegate?.moveToDetail(withData: detail)
        }
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let editAction = UIContextualAction(style: .normal, title:  "Edit", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
            if let listPosts = self.vm?.listPosts.value?[indexPath.row] {
                self.delegate?.moveToUpdateScreen(withIndex: listPosts)
            }
            
            success(true)
        })
        
        let deleteAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            self.vm?.selectedIndex.value = self.vm?.listPosts.value?[indexPath.row]
            self.vm?.deleteListPost()
            self.view?.loading.startAnimating()
            self.tableView?.reloadData()
            self.vm?.showLoading.bind { [weak self] loading in
                
                guard let self = self else { return }
                
                if loading != true {
                    self.view?.loading.stopAnimating()
                }
            }
            
            success(true)
        })
        
        deleteAction.backgroundColor = .red
        editAction.backgroundColor = .blue
        
        return UISwipeActionsConfiguration(actions: [editAction, deleteAction])
    }
}
