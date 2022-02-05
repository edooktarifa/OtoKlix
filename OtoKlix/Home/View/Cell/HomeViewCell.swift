//
//  HomeViewCell.swift
//  OtoKlix
//
//  Created by Phincon on 04/02/22.
//

import UIKit
import SkeletonView

class HomeViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var publishLbl: UILabel!
    @IBOutlet weak var updateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setContent(with data: GetPostsListModel?){
        if let data = data {
            titleLbl.text = data.title
            contentLbl.text = data.content
            if let update = data.updateAt, let publish = data.publishedAt {
                updateLbl.text = "Update : " + update
                publishLbl.text = "Publish : " + publish
            }
        }
    }
}
