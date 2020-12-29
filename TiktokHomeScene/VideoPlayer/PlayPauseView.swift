//
//  PlayPauseView.swift
//  TiktokHomeScene
//
//  Created by Alchemist on 22/12/2020.
//  Copyright © 2020 Nejmo. All rights reserved.
//

import Foundation
import UIKit
class PlayPauseView : UIView {
    lazy var visualEffectView: UIVisualEffectView = {
        var view = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        view.alpha = 0.8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var image : UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .clear
        image.image = UIImage(systemName: "play")
        image.tintColor = .white
        return image
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layoutUserInterFace()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func layoutUserInterFace(){
        self.addSubViews()
        self.setupViews()
    }
    private func addSubViews() {
        self.addSubview(self.visualEffectView)
        self.addSubview(self.image)
    }
    private func setupViews() {
        NSLayoutConstraint.activate([
            self.visualEffectView.topAnchor.constraint(equalTo: self.topAnchor),
            self.visualEffectView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.visualEffectView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.visualEffectView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.image.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.image.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.image.widthAnchor.constraint(equalToConstant: 60),
            self.image.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    func setupImage(systemName:String) {
        self.image.image = UIImage(systemName: systemName)
    }
    
}
