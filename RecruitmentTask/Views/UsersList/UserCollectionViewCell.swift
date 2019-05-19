//
//  UserCollectionViewCell.swift
//  RecruitmentTask
//
//  Created by Adam Kędzia on 18/05/2019.
//  Copyright © 2019 Adam Kędzia. All rights reserved.
//

import UIKit

class UserCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    var thumbnailTask: URLSessionTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailTask?.cancel()
        thumbnail.image = nil
    }

}
