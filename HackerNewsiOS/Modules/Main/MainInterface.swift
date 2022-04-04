//
//  MainInterface.swift
//  DispatchGroup
//
//  Created by Daniel Maia dos Passos on 31/03/22.
//

import Foundation
import UIKit

protocol MainViewProtocol: AnyObject {
  func updateTableView()
}

protocol MainViewModelProtocol: AnyObject {
  func loadData()
  func configureTableView(tableView: UITableView)
  func numberOfRowsInSection() -> Int
  func cellForRowAt(tableView: UITableView, row: Int) -> UITableViewCell
}
