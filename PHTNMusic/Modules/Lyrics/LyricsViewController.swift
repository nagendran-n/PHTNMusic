//
//  DetailsViewController.swift
//  Articles
//
//  Created by Pedro Henrique Prates Peralta on 3/26/16.
//  Copyright © 2017 Pedro Peralta. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire
import PHTNNetwork

class LyricsViewController : UIViewController {
  @IBOutlet weak var songLabel: UILabel!
  @IBOutlet weak var artistLabel: UILabel!
  @IBOutlet weak var albumLabel: UILabel!
  @IBOutlet weak var albumView: UIImageView!
  @IBOutlet weak var playButton: UIButton!
  @IBOutlet weak var lyricTextView: UITextView!

  var presenter: LyricsPresentation!

  var audioPlayer: AVPlayer!
  var previewUrl: String!
  var lyricUrl: String!

  var song: Song! {
    didSet {
      presenter.search(for: song.trackName, by: song.artistName)
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    presenter.viewDidLoad()
  }
}

extension LyricsViewController: LyricsView {
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

  @IBAction func showFullLyrics() {
    if UIApplication.shared.canOpenURL(URL(string: self.lyricUrl)!) {
      UIApplication.shared.open(URL(string: self.lyricUrl)!, options: [:], completionHandler: nil)
    }
  }

  func showLyrics(forSong song: Song, with lyric: Lyric) {
    self.lyricUrl = lyric.url
    self.previewUrl = song.previewUrl

    // Setup the view.
    self.setup(song, lyric)
  }
  
  func setup(_ song: Song, _ lyric: Lyric) {
    // Set the lyric.
    lyricTextView.text = lyric.lyrics

    // Set the song attributes.
    songLabel?.text = song.trackName
    artistLabel?.text = song.artistName

    // Set the album name.
    albumLabel.numberOfLines = 0
    albumLabel.lineBreakMode = .byWordWrapping
    albumLabel?.text = song.collectionName
    
    // Set the album image.
    albumView.contentMode = .scaleAspectFit
    Alamofire.request("\(song.artworkUrl100)").responseImage { response in
      if let image = response.result.value {
        self.albumView.image = image
        
        // Check if the image has an average dark color or light color, so that we can display a contrasting Play Button on top of the Album image.
        let color: UIColor = image.areaAverage()
        if color.isLight() {
          self.playButton.tintColor = UIColor.blue
        } else {
          self.playButton.tintColor = UIColor.white
        }
      }
    }
    
    // Set appearance attributes of the album image.
    albumView.layer.cornerRadius = 4.0
    albumView.layer.masksToBounds = true
    albumView.layer.borderColor = UIColor.white.cgColor
    albumView.layer.borderWidth = 0.5
  }
}
