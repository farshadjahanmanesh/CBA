//
//  WatchListViewController.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/23/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import UIKit
class WatchListViewController: UIViewController, ViewModelHolder {
	var viewModel: WatchListViewModel!
	
	@IBOutlet private var tableView: UITableView! {
		didSet {
			self.tableView.tableFooterView = UIView()
			self.tableView.separatorStyle = .none
			self.tableView.dataSource = self
			self.tableView.delegate = self
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		validateViewModel()
		self.navigationItem.title = "WatchList"
		// Do any additional setup after loading the view.
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		self.tableView.reloadData()
	}
}

extension WatchListViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.watchList.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: .default, reuseIdentifier: "WatchListCell")
		let movie = viewModel.watchList[indexPath.row]
		cell.textLabel?.text = movie.title
		cell.imageView?.fromURL(string: movie.posterFullPath) {[weak cell] _ in
			cell?.setNeedsLayout()
		}
		
		return cell
	}
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UIScreen.main.bounds.size.width * 0.85
	}
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
		let delete = UITableViewRowAction(style: .destructive, title: "Remove") {[weak self] (action, index) in
			action.backgroundColor = .red
			guard let self = self else {return}
			self.viewModel.remove(movie: self.viewModel.watchList[indexPath.row])
			tableView.reloadData()
		}
		return [delete]
	}

}


