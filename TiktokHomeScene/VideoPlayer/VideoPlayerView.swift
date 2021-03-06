//
//  VideoPlayerView.swift
//  TiktokHomeScene
//
//  Created by Alchemist on 16/12/2020.
//  Copyright © 2020 Nejmo. All rights reserved.
//

import Foundation
import UIKit
import AVKit
class VideoPlayerView : UIView {
    var player: AVPlayer?
    var playerLayer : AVPlayerLayer?
    lazy var controlsContainerView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var indicatorView: UIActivityIndicatorView = {
        var view = UIActivityIndicatorView(style: .large)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.startAnimating()
        return view
    }()
    lazy var videoReactsView : VideoReactsView = {
        var view = VideoReactsView()
        view.delegete = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    lazy var videoInfoView : VideoInfoView = {
        var view = VideoInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var playPauseView : PlayPauseView  = {
        var view = PlayPauseView()
        view.layer.cornerRadius = 14
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var isVideoPlaying: Bool = true
    override init(frame:CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .black
        self.clipsToBounds = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupPlayer(url:URL) {
        self.player = AVPlayer(url: url)
        self.playerLayer = AVPlayerLayer(player: player)
        self.layer.addSublayer(playerLayer!)
        playerLayer!.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        playerLayer?.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        playerLayer?.videoGravity = .resizeAspectFill
        self.player?.addObserver(self, forKeyPath: "timeControlStatus", options: [.old, .new], context: nil)
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: .main) { [weak self] (notification) in
            guard let self = self else {return}
            self.finishedPlayingVideo()
        }
        self.playVideo()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.layoutUserInterFace()
            self.setupGradientLayer()
            self.setupVideoReactsView()
            self.setupVideoInfoView()
            self.setupPlayPauseView()
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didTappedPlayOrPause))
            self.addGestureRecognizer(tapGesture)
        }
        
    }
    @objc func didTappedPlayOrPause(gesture:UIGestureRecognizer) {
        self.isVideoPlaying ? self.pauseVideo() : self.playVideo()
        self.isVideoPlaying ? self.playPauseView.setupImage(systemName: "play") : self.playPauseView.setupImage(systemName: "pause")
        self.isVideoPlaying.toggle()
        self.animatePausePlayButton()
        print("isVideoPlaying : \(self.isVideoPlaying)")
    }
    private func playVideo() {
        guard player != nil else {return}
        self.player?.play()
    }
    private func pauseVideo() {
        guard player != nil else {return}
        self.player?.pause()
        self.videoInfoView.stopAnimation()
        self.videoReactsView.hideAnimation()
    }
    private func layoutUserInterFace() {
        self.setupControlsViewContainer()
        self.addIndicatorView()
    }
    private func setupControlsViewContainer() {
        self.addSubview(controlsContainerView)
        NSLayoutConstraint.activate([
            self.controlsContainerView.topAnchor.constraint(equalTo: self.topAnchor),
            self.controlsContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.controlsContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.controlsContainerView.trailingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }
    private func addIndicatorView() {
        self.controlsContainerView.addSubview(self.indicatorView)
        self.indicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.indicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.name = "Gradient"
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor.clear.cgColor , UIColor.black.cgColor]
        gradientLayer.locations = [0.7 , 1.2]
        self.controlsContainerView.layer.addSublayer(gradientLayer)
    }
    private func setupVideoReactsView() {
        self.addSubview(self.videoReactsView)
        NSLayoutConstraint.activate([
            self.videoReactsView.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: -60),
            self.videoReactsView.trailingAnchor.constraint(equalTo: self.trailingAnchor , constant: -12),
            self.videoReactsView.heightAnchor.constraint(equalToConstant: ((3 * 40) + 60) + (4*10))
        ])
    }
    private func setupVideoInfoView() {
        self.addSubview(self.videoInfoView)
        NSLayoutConstraint.activate([
            videoInfoView.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: -20),
            videoInfoView.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: 10),
            videoInfoView.widthAnchor.constraint(equalTo: self.widthAnchor , multiplier: 0.6),
            videoInfoView.heightAnchor.constraint(equalToConstant: 80)
            
        ])
    }
    private func setupPlayPauseView() {
        self.addSubview(self.playPauseView)
        NSLayoutConstraint.activate([
            self.playPauseView.widthAnchor.constraint(equalToConstant: 100),
            self.playPauseView.heightAnchor.constraint(equalToConstant: 100),
            self.playPauseView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            self.playPauseView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0)
        ])
        self.playPauseView.transform = CGAffineTransform(scaleX: 0, y: 0)
    }
    private func animatePausePlayButton() {
        UIView.animate(withDuration: 0.3, animations: {
            self.playPauseView.transform = .identity
        }) { (done) in
            DispatchQueue.main.asyncAfter(deadline: .now() ) {
                self.playPauseView.transform = CGAffineTransform(scaleX: 0, y: 0)
            }
        }
    }
    deinit {
        print("De init")
    }
}
//MARK:- Observers
extension VideoPlayerView  {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "timeControlStatus", let change = change, let newValue = change[NSKeyValueChangeKey.newKey] as? Int, let oldValue = change[NSKeyValueChangeKey.oldKey] as? Int {
            let oldStatus = AVPlayer.TimeControlStatus(rawValue: oldValue)
            let newStatus = AVPlayer.TimeControlStatus(rawValue: newValue)
            if newStatus != oldStatus {
                DispatchQueue.main.async {[weak self] in
                    guard let self = self else {return}
                    if newStatus == .playing || newStatus == .paused {
                        self.indicatorView.stopAnimating()
                        self.videoInfoView.playAnimation()
                        self.videoReactsView.showAnimation()
                    } else {
                        self.indicatorView.startAnimating()
                        self.videoInfoView.stopAnimation()
                        self.videoReactsView.hideAnimation()
                    }
                }
            }
        }
    }
    @objc func finishedPlayingVideo() {
        print("Finished Playing Video")
        if let player = self.player {
            player.seek(to: CMTime.zero)
            player.play()
        }
    }
}
//MARK:- Reactions Taps
extension VideoPlayerView : ReactsViewTaps {
    func didTapProfileImage() {
        print("Did Tap Profile Image")
    }
    func didTapUpVote() {
        print("Did Tap Up Vote")
    }
     func didTappedDownVote() {
        print("Did Tap Down Vote")
    }
    func onTappedComment() {
        print("Did Tap Comment")
    }
}

