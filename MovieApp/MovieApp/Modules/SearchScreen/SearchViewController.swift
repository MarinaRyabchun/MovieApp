//
//  ViewController.swift
//  MovieApp
//
//  Created by Марина Рябчун on 04.06.2023.
//

import UIKit

protocol SearchViewProtocol {
    var searchBarText: String? { get set}
}

class SearchViewController: UIViewController , SearchViewProtocol {
    // MARK: - Properties
    var searchBarText: String?
    private var viewModel: MovieListViewModelProtocol = MovieListViewModel()
    private let searchController = UISearchController(searchResultsController: nil)
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.backgroundColor = Constants.Colors.black
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Colors.black
        setupViews()
        setupSearchBar()
        setupTableView()
        setupConstraints()
        searchBarSearchButtonClicked(searchController.searchBar)
        setupNavigationBar()
        viewModel.users.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    // MARK: - View Methods
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellWithContent.self, forCellReuseIdentifier: "cell")
    }
    
    private func setupNavigationBar() {
        title = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.searchTextField.backgroundColor = .white
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movie"
        searchController.searchBar.setShowsCancelButton(false, animated: false)
    }
    
    private func setupViews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        let margins = view.safeAreaLayoutGuide
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 0).isActive = true
        tableView.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: 0).isActive = true
    }
}
// MARK: - Extension
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.value?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CellWithContent
        let contentForCell = viewModel.users.value?[indexPath.row]
        cell?.configure(contentForCell!)
        
        cell?.backgroundColor = .black
        cell?.backgroundConfiguration = .clear()
        
        return cell ?? UITableViewCell()
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.users.value?[indexPath.row]
        let detailViewController = DetailViewController()
        detailViewController.movie = movie
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBarText = searchBar.text
        viewModel.fetchData(searchBarText ?? "")
    }
}

