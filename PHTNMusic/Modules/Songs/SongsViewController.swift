//
//  SongsViewController.swift
//  PHTNMusic
//
//  Created by Nags on 4/21/17.
//  Copyright © 2017 Nagendran Nagarajan. All rights reserved.
//

import UIKit
import PHTNNetwork

class SongsViewController: UIViewController {
  @IBOutlet weak var songsTableView: UITableView!
  @IBOutlet weak var songsSearchBar: UISearchBar!
  
  var presenter: SongsPresentation!
  var searchResult: SearchResult! {
    didSet {
      songsTableView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Dosis-Bold", size: 20)!]

    setupView()
  }
  
  fileprivate func setupView() {
    songsTableView.register(SongTableViewCell.self)
  }
}

extension SongsViewController: SongsView {
  func showNoContentScreen() {
  }
  
  func showSongsData(_ songs: SearchResult) {
    self.searchResult = songs
  }
}

extension SongsViewController: UITableViewDataSource, UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if searchResult == nil {
      return 0
    } else {
      return searchResult.songCount
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as SongTableViewCell
    cell.selectionStyle = .none

    if searchResult != nil {
      let song = searchResult.songs[indexPath.row]

      cell.setup(song)
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return UIView()
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return UIView()
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

    presenter.didSelectSong(searchResult.songs[indexPath.row])
  }
}

extension SongsViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    presenter.searchFor(keywords: searchBar.text!)
  }
}
