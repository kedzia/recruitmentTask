//
//  UserCollectionViewCell.swift
//  RecruitmentTask
//
//  Created by Adam Kędzia on 18/05/2019.
//  Copyright © 2019 Adam Kędzia. All rights reserved.
//

import UIKit

class UserCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var username: UILabel?
    @IBOutlet weak var api: UILabel?
    @IBOutlet weak var avatar: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
