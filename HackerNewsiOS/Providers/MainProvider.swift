//
//  MainProvider.swift
//  DispatchGroup
//
//  Created by Daniel Maia dos Passos on 31/03/22.
//

import Foundation
import Alamofire

protocol MainProviderProtocol: AnyObject {
  func getIds(successCallback: @escaping ([Int]) -> Void, failureCallback: @escaping () -> Void)
  func getNews(id: Int, successCallback: @escaping (NewsModel) -> Void, failureCallback: @escaping () -> Void)
}

class MainProvider: MainProviderProtocol {
  
  func getIds(successCallback: @escaping ([Int]) -> Void, failureCallback: @escaping () -> Void) {
    AF.request("https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty")
      .validate()
      .responseDecodable(of: [Int].self) { response in
        guard let ids = response.value else {
          failureCallback()
          return
        }
        successCallback(ids)
      }
  }
  
  func getNews(id: Int, successCallback: @escaping (NewsModel) -> Void, failureCallback: @escaping () -> Void) {
    AF.request("https://hacker-news.firebaseio.com/v0/item/\(id).json?print=pretty")
      .validate()
      .responseDecodable(of: NewsModel.self) { response in
        guard let news = response.value else {
          failureCallback()
          return
        }
        successCallback(news)
      }
  }
}
