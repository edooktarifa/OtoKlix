//
//  Router.swift
//  OtoKlix
//
//  Created by Phincon on 04/02/22.
//

import Foundation
import UIKit

class Router: NSObject {
    var view: UIViewController?
    
    init(view: UIViewController? = nil) {
        self.view = view
    }
    
    func moveToDetail(withData: GetPostsListModel){
        let vc = DetailViewController()
        vc.detail = withData
        self.view?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveToUpdate(withData: GetPostsListModel){
        let vc = UpdatePostViewController()
        vc.detail = withData
        vc.checkScreen = .update
        self.view?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveToPost(){
        let vc = UpdatePostViewController()
        vc.checkScreen = .post
        self.view?.navigationController?.pushViewController(vc, animated: true)
    }
}
