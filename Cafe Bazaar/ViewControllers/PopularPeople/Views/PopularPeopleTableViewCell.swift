//
//  PopularPeopleTableViewCell.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/21/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import UIKit

extension PersistentManager.Key {
	static let movie: ((Int)->PersistentManager.Key) = {name in PersistentManager.Key.init(rawValue: "favorite_movies_id_\(name)")}
}

class PopularPeopleTableViewCell: UITableViewCell, ModelFillable, FavoritePresenetable {
	typealias Model = PopularPeople
	fileprivate let collectionCellID = "KnownForCollectionViewCell"
	
	private var model: Model!
	
	weak var dataStore : DataStore? = nil
	var selectedMovie: ((KnownFor)->Void)? = nil
	
	@IBOutlet private(set) var collectionView: UICollectionView! {
		didSet {
			self.collectionView.register(UINib(nibName: collectionCellID, bundle: nil), forCellWithReuseIdentifier: collectionCellID)
		}
	}
	@IBOutlet private var posterImage: UIImageView!
	@IBOutlet private var nameLabel: UILabel!
	@IBOutlet private var overviewLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
		self.collectionView.dataSource = self
		self.collectionView.delegate = self
    }
	
	override func prepareForReuse() {
		super.prepareForReuse()
		self.posterImage.image = .placeholder
	}
	
	func fill(_ model: PopularPeople) {
		self.model = model
		self.nameLabel.text = model.name
		self.posterImage.fromURL(string: model.profileFullPath)
	}
	
	var isFavorite: Bool = false {
		didSet {
			if isFavorite {
				self.posterImage.layer.cornerRadius = 5
				self.posterImage.layer.borderColor = UIColor.orange.cgColor
				self.posterImage.layer.borderWidth = 2
			} else {
				self.posterImage.layer.cornerRadius = 0
				self.posterImage.layer.borderWidth = 0
			}
		}
	}
}

extension PopularPeopleTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return model.knownFor.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath) as? KnownForCollectionViewCell else {
			return UICollectionViewCell()
		}
		cell.fill(model.knownFor[indexPath.row])
		cell.isFavorite = (self.dataStore?[.movie(model.knownFor[indexPath.row].id)] as ID?) != nil
		return cell
	}
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let square = UIScreen.main.bounds.size.width * 0.32
		return .init(width: square, height: square)
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		selectedMovie?(model.knownFor[indexPath.row])
	}
}

protocol FavoritePresenetable where Self: UIView {
	var isFavorite: Bool {set get}
}

