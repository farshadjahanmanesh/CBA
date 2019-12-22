//
//  KnownForCollectionViewCell.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/21/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import UIKit

class KnownForCollectionViewCell: UICollectionViewCell, ModelFillable {
	typealias Model = KnownFor
	func fill(_ model: KnownFor) {
		self.posterImage.fromURL(string: model.posterFullPath)
	}
	@IBOutlet var posterImage: UIImageView!
	override func prepareForReuse() {
		self.posterImage.image = .placeholder
	}
    override func awakeFromNib() {
        super.awakeFromNib()
		self.posterImage.layer.cornerRadius = 5
        // Initialization code
    }

}
