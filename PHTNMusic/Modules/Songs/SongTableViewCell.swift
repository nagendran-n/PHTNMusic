//
//  ArticleTableViewCell.swift
//  Articles
//
//  Created by Pedro Henrique Prates Peralta on 3/19/16.
//  Copyright © 2017 Pedro Peralta. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import Alamofire
import AlamofireImage
import PHTNNetwork

class SongTableViewCell: UITableViewCell {
  // Weak references to the basic information - Album Image, Song and Artist, including a Play/Pause button.
  @IBOutlet weak var albumView: UIImageView!
  @IBOutlet weak var songLabel: UILabel!
  @IBOutlet weak var artistLabel: UILabel!
//  @IBOutlet weak var albumLabel: UILabel!
  @IBOutlet weak var playButton: UIButton!

  // Defines the URL of the audio preview of the song.
  var previewUrl: String!
  
  // An AVPlayer instance variable, since AVPlayer does not work when used as a local variable.
  var audioPlayer: AVPlayer!
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: .default, reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  @IBAction func playTrack() {
    // Check if the audio player is already initialized and playing.
    if self.audioPlayer == nil {
      // We are using AVPlayer here instead of AVAudioPlayer since AVPlayer has better support for remote URLs.
      self.audioPlayer = AVPlayer(url: URL(string: self.previewUrl)!)
      
      // Set the play button to display as a pause button and start playback.
      self.playButton.isSelected = true
      self.audioPlayer.play()
    } else {
      // Set the play button to display as a play button and pause playback.
      self.playButton.isSelected = false
      self.audioPlayer.pause()
      
      // Reset the player so that we don't use resources.
      self.audioPlayer = nil
    }
  }
  
  func setup(_ song: Song) {
    songLabel?.text = song.trackName
    artistLabel?.text = song.artistName
//    albumLabel?.text = song.collectionName

    albumView.contentMode = .scaleAspectFit
    Alamofire.request("\(song.artworkUrl100)").responseImage { response in
      if let image = response.result.value {
        self.albumView.image = image
      }
    }
    
    albumView.layer.cornerRadius = 4.0
    albumView.layer.masksToBounds = true
    albumView.layer.borderColor = UIColor.white.cgColor
    albumView.layer.borderWidth = 0.5
  }
}
