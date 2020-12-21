//
//  ReactsSingleView.swift
//  TiktokHomeScene
//
//  Created by Alchemist on 17/12/2020.
//  Copyright © 2020 Nejmo. All rights reserved.
//

import Foundation
import UIKit
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
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.widthAnchor.constraint(equalToConstant: 60).isActive = true
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

