//
//  ViewController.swift
//  DispatchGroup
//
//  Created by Daniel Maia dos Passos on 31/03/22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
  
  let tableView: UITableView!
  var viewModel: MainViewModelProtocol!
  
  init() {
    tableView = UITableView()
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    viewModel.loadData()
  }
  
  func configureUI() {
    
    view.addSubview(tableView)
    tableView.delegate = self
    tableView.dataSource = self
    
    viewModel.configureTableView(tableView: tableView)
    
    tableView.snp.makeConstraints { make in
      make.left.right.top.bottom.equalToSuperview()
    }
  }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRowsInSection()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return viewModel.cellForRowAt(tableView: tableView, row: indexPath.row)
  }
}

extension ViewController: MainViewProtocol {
  func updateTableView() {
    tableView.reloadData()
  }
}
