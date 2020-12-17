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
        var view = UIActivityIndicatorView(style: .whiteLarge)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.startAnimating()
        return view
    }()
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
        playerLayer!.frame = self.bounds
        playerLayer?.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        playerLayer?.videoGravity = .resizeAspectFill
        self.player?.addObserver(self, forKeyPath: "timeControlStatus", options: [.old, .new], context: nil)
        self.playVideo()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.layoutUserInterFace()
            self.setupGradientLayer()
        }
    }
    private func playVideo() {
        guard player != nil else {return}
        self.player?.play()
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
                    if newStatus == .playing || newStatus == .paused {
                        self?.indicatorView.stopAnimating()
                    } else {
                        self?.indicatorView.startAnimating()
                    }
                }
            }
        }
    }
}
