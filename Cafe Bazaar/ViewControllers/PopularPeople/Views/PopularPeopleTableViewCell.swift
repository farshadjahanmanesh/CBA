//
//  PopularPeopleTableViewCell.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/21/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import UIKit

protocol ModelFillable {
	associatedtype Model
	func fill(_ model: Model)
}
class PopularPeopleTableViewCell: UITableViewCell, ModelFillable {
	typealias Model = People
	
	let disposeBag = DisposeBag()
	@IBOutlet private var collectionView: UICollectionView! {
		didSet {
			self.collectionView.register(UINib(nibName: "KnownForCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "KnownForCollectionViewCell")
		}
	}
	@IBOutlet var posterImage: UIImageView!
	@IBOutlet var nameLabel: UILabel!
	@IBOutlet var overviewLabel: UILabel!
	private var model: Model!
	override func awakeFromNib() {
        super.awakeFromNib()
		self.collectionView.dataSource = self
		self.collectionView.delegate = self
		self.collectionView.reloadData()
        // Initialization code
    }
	override func prepareForReuse() {
		super.prepareForReuse()
		self.posterImage.image = .placeholder
		self.collectionView.reloadData()
	}
	func fill(_ model: People) {
		self.model = model
		self.nameLabel.text = model.name
		
		self.posterImage.fromURL(string: model.profileFullPath)
		self.collectionView.reloadData()
	}
}

extension PopularPeopleTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return model.knownFor.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KnownForCollectionViewCell", for: indexPath) as? KnownForCollectionViewCell else {
			return UICollectionViewCell()
		}
		cell.fill(model.knownFor[indexPath.row])
		return cell
	}
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let square = UIScreen.main.bounds.size.width * 0.31
		return .init(width: square, height: square)
	}
}
