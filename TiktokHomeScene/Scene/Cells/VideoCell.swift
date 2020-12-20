//
//  VideoCell.swift
//  TiktokHomeScene
//
//  Created by Alchemist on 16/12/2020.
//  Copyright © 2020 Nejmo. All rights reserved.
//

import Foundation
import AVKit
import UIKit
class VideoCell: UICollectionViewCell {
    lazy var containerView : UIView = {
        var container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .lightGray
        return container
    }()
    lazy var playerContainer:VideoPlayerView = {
        var player = VideoPlayerView()
        player.translatesAutoresizingMaskIntoConstraints  = false
        return player
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layoutUserInterFace()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func layoutUserInterFace() {
        self.addSubViews()
        self.setupContainer()
        self.setupVideoPlayerView()
    }
    private func addSubViews() {
        self.addSubview(self.containerView)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.playerContainer.player?.pause()
        self.playerContainer.player = nil
        self.playerContainer.playerLayer?.removeFromSuperlayer()
        playerContainer.controlsContainerView.layer.sublayers?.filter{ $0 is CAGradientLayer }.forEach{ $0.removeFromSuperlayer() }
    }
    private func setupContainer() {
        NSLayoutConstraint.activate([
            self.containerView.topAnchor.constraint(equalTo: self.topAnchor),
            self.containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    private func setupVideoPlayerView() {
        self.containerView.addSubview(self.playerContainer)
        NSLayoutConstraint.activate([
            self.playerContainer.topAnchor.constraint(equalTo: self.containerView.topAnchor),
            self.playerContainer.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
            self.playerContainer.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor),
            self.playerContainer.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor)
        ])
    }
    func configureCell(withVideo  url:URL , isMuted:Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            if let cachedItemCount = CacheManager.shared.getNumberOfCachedItems() {
                if cachedItemCount >= 10 {
                    CacheManager.shared.clearCache()
                    print("Cache Cleared")
                }
            }
            CacheManager.shared.isFileCashed(stringUrl: url.absoluteString) {[weak self] (isFileCashed) in
                guard let self = self else {return}
                switch isFileCashed {
                case .success(let filePathURL):
                    self.playerContainer.setupPlayer(url: filePathURL)
                case .failure(let err):
                    self.playerContainer.setupPlayer(url: url)
                    CacheManager.shared.cachFile(stringUrl: url.absoluteString) { [weak self] (result) in
                        guard let self = self else {return}
                        switch result {
                        case .success(let _) :
                            print("cached")
                        case .failure(let _) :
                            print("can't cach")
                        }
                    }
                }
                if isMuted {
                    self.playerContainer.player?.isMuted = true
                }else{
                    self.playerContainer.player?.isMuted = false
                }
            }
        }
    }
    
}

