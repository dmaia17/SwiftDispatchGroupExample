//
//  MainViewModel.swift
//  DispatchGroup
//
//  Created by Daniel Maia dos Passos on 31/03/22.
//

import Foundation
import UIKit

class MainViewModel {
  let cellIdentifier = "cell"
  
  private var idList: [Int] = []
  private var newsList: [NewsModel] = []
  var provider: MainProviderProtocol?
  weak var view: MainViewProtocol?
  
  private func handleIdsSuccess(ids: [Int]) {
    idList = ids
    let group = DispatchGroup()
    
    for id in idList {
      group.enter()
      provider?.getNews(id: id, successCallback: { news in
        self.newsList.append(news)
        group.leave()
      }, failureCallback: {
        group.leave()
      })
    }
    
    group.notify(queue: .main) {
      self.view?.updateTableView()
    }
  }
}

extension MainViewModel: MainViewModelProtocol {
  func loadData() {
    provider?.getIds(successCallback: { ids in
      self.handleIdsSuccess(ids: ids)
    }, failureCallback: {
      // TODO: Handle error
    })
  }
  
  func configureTableView(tableView: UITableView) {
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
  }
  
  func numberOfRowsInSection() -> Int {
    return newsList.count
  }
  
  func cellForRowAt(tableView: UITableView, row: Int) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
    cell?.textLabel?.text = newsList[row].title
    
    return cell ?? UITableViewCell()
  }
}
