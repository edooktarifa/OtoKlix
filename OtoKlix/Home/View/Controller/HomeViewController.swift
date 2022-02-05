//
//  ViewController.swift
//  OtoKlix
//
//  Created by Phincon on 04/02/22.
//

import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataView: UIView!
    
    var vm = HomeViewModel()
    
    private var dataSource: HomeDataSource = HomeDataSource()
    private var router: Router = Router()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func configView() {
        tableView.register(UINib(nibName: "HomeViewCell", bundle: nil), forCellReuseIdentifier: "HomeViewCell")
        dataSource = HomeDataSource(vm: vm, tableView: tableView, view: self)
        dataSource.delegate = self
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.tableFooterView = UIView()
        router = Router(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loading.startAnimating()
        
        vm.showLoading.bind { [weak self] loading in
            
            guard let self = self else { return }
            
            if loading != true {
                self.loading.stopAnimating()
            }
        }
        
        vm.listPosts.bind { [weak self] listPosts in
            
            guard let self = self else { return }
            self.tableView.reloadData()
        }
        
        vm.emptyList.bind { [weak self] empty in
            guard let self = self else { return }
            
            if empty != true {
                self.tableView.isHidden = false
                self.noDataView.isHidden = true
            } else {
                self.tableView.isHidden = true
                self.noDataView.isHidden = false
            }
        }
        
        vm.showAlert.bind { [weak self] alert in
            guard let self = self else { return }
            
            if let alert = alert {
                self.showError(with: alert)
            }
        }
        
        vm.showListPost()
        
    }
    
    @IBAction func addNewPosts(){
        router.moveToPost()
    }
}

extension HomeViewController : HomeDataSourceDelegate {
    func moveToUpdateScreen(withIndex: GetPostsListModel) {
        router.moveToUpdate(withData: withIndex)
    }
    
    func moveToDetail(withData: GetPostsListModel) {
        router.moveToDetail(withData: withData)
    }
}
