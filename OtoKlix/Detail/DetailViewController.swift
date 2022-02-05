//
//  DetailViewController.swift
//  OtoKlix
//
//  Created by Phincon on 04/02/22.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titlePosts: UILabel!
    @IBOutlet weak var contentPosts: UILabel!
    @IBOutlet weak var postCreateUpdatePosts: UILabel!
    
    var detail: GetPostsListModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titlePosts.text = detail?.title
        contentPosts.text = detail?.content
        postCreateUpdatePosts.text = "Create : \(detail?.createAt ?? "")\nUpdate At: \(detail?.updateAt ?? "")"
    }
}
