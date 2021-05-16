//
//  ViewController.swift
//  NewsApp
//
//  Created by Cengizhan DUMLU on 11.05.2021.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    
    var viewModel = NewsListViewModel()
    
    private lazy var headerView : HeaderView = {
        let v = HeaderView(fontSize: 32)
        return v
    }()
    
    private lazy var tabelView : UITableView = {
        let v = UITableView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.tableFooterView = UIView()
        v.register(NewsTableViewCell.self, forCellReuseIdentifier: viewModel.reuseID)
        v.delegate = self
        v.dataSource = self
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchNews()
        
    }

    func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(headerView)
        view.addSubview(tabelView)
        setupConstraints()
    }
    
    func setupConstraints(){
        //header
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
        
        //tableview
        NSLayoutConstraint.activate([
            tabelView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabelView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabelView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8),
            tabelView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
            
        ])
    }
    
    func fetchNews(){
        viewModel.getNews { _ in
            self.tabelView.reloadData()
        }
    }


}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.newsVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.reuseID, for: indexPath) as? NewsTableViewCell
        let news = viewModel.newsVM[indexPath.row]
        cell?.newsVM = news
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = viewModel.newsVM[indexPath.row]
        guard let url = URL(string: news.url) else { return }
        
        let config = SFSafariViewController.Configuration()
        let safariViewController = SFSafariViewController(url: url, configuration: config)
        safariViewController.modalPresentationStyle = .fullScreen
        present(safariViewController, animated: true)
        
        
    }
}


