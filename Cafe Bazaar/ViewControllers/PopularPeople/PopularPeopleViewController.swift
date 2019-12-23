//
//  PopularPeopleViewController.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/21/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import UIKit

extension PersistentManager.Key {
	static let people: ((Int)->PersistentManager.Key) = {name in PersistentManager.Key.init(rawValue: "favorite_peoples_id_\(name)")}
}

class PopularPeopleViewController: UIViewController, ViewModelHolder {
	var viewModel: PopularPeopleViewModel!
	private let disposeBag = DisposeBag()
	
	@IBOutlet private  var tableView: UITableView! {
		didSet {
			self.tableView.register(UINib(nibName: "PopularPeopleTableViewCell", bundle: nil), forCellReuseIdentifier: "PopularPeopleTableViewCell")
			self.tableView.tableFooterView = UIView()
			self.tableView.separatorStyle = .none
			self.tableView.dataSource = self
			self.tableView.delegate = self
		}
	}
	@IBOutlet private var loadingView: UIActivityIndicatorView!
	@IBOutlet private var searchTextfield: UITextField! {
		didSet {
			searchTextfield.delegate = self
			searchTextfield.returnKeyType = .search
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		validateViewModel()
		bindReactive()
		getNextPeoples()
		styles()
		
		// Do any additional setup after loading the view.
	}
	private func styles() {
		self.navigationItem.title = "CBA"
		 addWatchListButton()
	}
	
	private func bindReactive(){
		self.viewModel.loading
			.subscribe {[weak self] (event) in
			guard let self = self else {return}
			switch event {
			case .next(let loading):
				DispatchQueue.main.async {
					if loading, self.viewModel.popularPeoples.value.isEmpty
					{self.loadingView.startAnimating()}
					else
					{self.loadingView.stopAnimating()}
				}
			default: return
			}
		}.disposed(by: disposeBag)
	}
	
	private func getNextPeoples(_ query: String? = nil, reset: Bool = false){
		guard !self.viewModel.loading.value else {return}
		var page = self.viewModel.popularPeoplePage + 1
		if reset {
			page = 1
			self.viewModel.popularPeoples.set([])
			tableView.reloadData()
		}
		var single: DisposeBag? = DisposeBag()
		let subscribe : (Event<Result<Container<[PopularPeople]>, RestError>?>)-> Void = {
			[unowned self] (event) in
			guard case let .next(result) = event else {return}
			switch result {
			case .success(let peoples):
				self.viewModel.popularPeoples.set(self.viewModel.popularPeoples.value  + peoples.results)
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
			default:
				self.viewModel.popularPeoplePage = page - 1
			}
			self.viewModel.loading.set(false)
			single = nil
		}
		
		if let query = query {
			self.viewModel
				.searchPopularPeoples(page: page, query: query)
				.subscribe(subscribe)
				.disposed(by: single!)
		} else {
			self.viewModel
				.getPopularPeoples(page: self.viewModel.popularPeoplePage + 1)
				.subscribe(subscribe)
				.disposed(by: single!)
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.tableView.reloadData()
	}
	
	private func addWatchListButton() {
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "WatchList", style: .plain, target: self, action: #selector(coordinateToWatchList))
	}
	
	@objc
	func coordinateToWatchList() {
		self.viewModel.coordinator.coordinateToWatchList()
	}
}

extension PopularPeopleViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.popularPeoples.value.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "PopularPeopleTableViewCell") as? PopularPeopleTableViewCell else {return UITableViewCell()}
		let people = viewModel.popularPeoples.value[indexPath.row]
		cell.fill(people)
		cell.dataStore = self.viewModel.store
		cell.isFavorite = (self.viewModel.store[.people(people.id)] as ID?) != nil
		cell.selectedMovie = { [weak self] movie in
			self?.viewModel.coordinator.coordinateToMovieDetails(for: movie)
		}
		if indexPath.row == viewModel.popularPeoples.value.count-2 {
			self.getNextPeoples()
		}
		return cell
	}
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UIScreen.main.bounds.size.width * 0.85
	}
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		(cell as? PopularPeopleTableViewCell)?.collectionView.reloadData()
		let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
		guard indexPath.row == lastRowIndex, self.viewModel.loading.value else  {return}
		let spinner = UIActivityIndicatorView(style: .gray)
		spinner.startAnimating()
		spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
		
		self.tableView.tableFooterView = spinner
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let people = viewModel.popularPeoples.value[indexPath.row]
		viewModel.coordinator.coordinateToPeopleDetails(for: people)
	}
}

extension PopularPeopleViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		self.getNextPeoples(textField.text!, reset: true)
		self.view.endEditing(true)
		return true
	}
}


