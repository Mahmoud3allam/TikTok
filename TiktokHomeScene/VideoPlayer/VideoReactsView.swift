//
//  VideoReactsView.swift
//  TiktokHomeScene
//
//  Created by Alchemist on 17/12/2020.
//  Copyright © 2020 Nejmo. All rights reserved.
//

import Foundation
import UIKit
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
        bu.reactImage.image = UIImage(systemName: "play")
        bu.reactImage.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        bu.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return bu
    }()
    lazy var seenButton:ReactsSingleView = {
       var bu = ReactsSingleView()
        bu.translatesAutoresizingMaskIntoConstraints  = false
        bu.backgroundColor = .clear
        bu.reactImage.image = UIImage(systemName: "play")
        bu.reactImage.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        bu.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return bu
    }()
    lazy var durationButton:ReactsSingleView = {
       var bu = ReactsSingleView()
        bu.translatesAutoresizingMaskIntoConstraints  = false
        bu.backgroundColor = .clear
        bu.reactImage.image = UIImage(systemName: "play")
        bu.reactImage.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
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
