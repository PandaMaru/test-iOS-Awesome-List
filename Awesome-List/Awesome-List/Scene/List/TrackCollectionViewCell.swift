//
//  TrackCollectionViewCell.swift
//  Awesome-List
//
//  Created by PandaMaru on 7/21/2560 BE.
//  Copyright © 2560 amuse. All rights reserved.
//

import UIKit

class TrackCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var img_cover: UIImageView!
    @IBOutlet weak var lbl_name: UILabel!
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        // note: don't change the width
        newFrame.size.height = ceil(size.height)
        layoutAttributes.frame = newFrame
        return layoutAttributes
    }
}
