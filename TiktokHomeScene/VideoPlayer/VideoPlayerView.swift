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
    lazy var videoReactsView : VideoReactsView = {
        var view = VideoReactsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
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
            self.setupVideoReactsView()
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
    private func setupVideoReactsView() {
        self.addSubview(self.videoReactsView)
        NSLayoutConstraint.activate([
            self.videoReactsView.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: -20),
            self.videoReactsView.trailingAnchor.constraint(equalTo: self.trailingAnchor , constant: -12),
//            self.videoReactsView.widthAnchor.constraint(equalToConstant: 60),
            self.videoReactsView.heightAnchor.constraint(equalToConstant: (3 * 40) + (2*10))
        
        
        ])
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

class VideoReactsView: UIView {
    lazy var verticalStackView: UIStackView = {
        var stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.spacing = 10
        return stack
    }()
    lazy var reactButton:ReactsSingleView = {
       var bu = ReactsSingleView()
        bu.translatesAutoresizingMaskIntoConstraints  = false
        bu.backgroundColor = .clear
        bu.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return bu
    }()
    lazy var seenButton:ReactsSingleView = {
       var bu = ReactsSingleView()
        bu.translatesAutoresizingMaskIntoConstraints  = false
        bu.backgroundColor = .clear
        bu.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return bu
    }()
    lazy var durationButton:ReactsSingleView = {
       var bu = ReactsSingleView()
        bu.translatesAutoresizingMaskIntoConstraints  = false
        bu.backgroundColor = .clear
        bu.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return bu
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layoutUserInterFace()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func layoutUserInterFace() {
        self.AddSubViews()
        self.setupStackView()
    }
    private func AddSubViews() {
        self.addSubview(self.verticalStackView)
        
    }
    private func setupStackView() {
        NSLayoutConstraint.activate([
            self.verticalStackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.verticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.verticalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        self.verticalStackView.addArrangedSubview(self.seenButton)
        self.verticalStackView.addArrangedSubview(self.reactButton)
        self.verticalStackView.addArrangedSubview(self.durationButton)

    }
    
}

class ReactsSingleView: UIView {
    lazy var verticalStackView: UIStackView = {
        var stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.spacing = 1
        return stack
    }()
    lazy var reactButton:UIButton = {
       var bu = UIButton()
        bu.translatesAutoresizingMaskIntoConstraints  = false
        bu.backgroundColor = .white
        bu.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return bu
    }()
    lazy var reactImage: UIImageView = {
       var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .clear
        image.image = #imageLiteral(resourceName: "basic_eye-512")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    lazy var reactLabel: UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "24K"
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.backgroundColor = .clear
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layoutUserInterFace()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func layoutUserInterFace() {
        self.AddSubViews()
        self.setupStackView()
    }
    private func AddSubViews() {
        self.addSubview(self.verticalStackView)
    }
    private func setupStackView() {
        NSLayoutConstraint.activate([
            self.verticalStackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.verticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.verticalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        self.verticalStackView.addArrangedSubview(self.reactImage)
        self.verticalStackView.addArrangedSubview(self.reactLabel)


    }
}
