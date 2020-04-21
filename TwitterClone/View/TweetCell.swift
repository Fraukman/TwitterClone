//
//  TweetCell.swift
//  TwitterClone
//
//  Created by Juan Souza on 17/04/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import UIKit

protocol TweetCellDelegate: class {
    func handleProfileImageTapped(_ cell: TweetCell)
}

class TweetCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    var tweet: Tweet? {
        didSet{
            configure()
        }
    }
    
    weak var delegate: TweetCellDelegate?
    
    private lazy var profileImageView: UIImageView = {
           let iv = UIImageView()
           iv.contentMode = .scaleAspectFit
           iv.clipsToBounds = true
           iv.setDimensions(width: 48, height: 48)
           iv.layer.cornerRadius = 48/2
           iv.backgroundColor = .mainBlue
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped))
        iv.addGestureRecognizer(tap)
        iv.isUserInteractionEnabled = true
           return iv
       }()
    
    private let captionLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.text = "Some text caption"
        return label
    }()
    
    private lazy var commentButtom: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "comment"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(handleCommentTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var retweetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "retweet"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(handleRetweetTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "like"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(handleLikeTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "share"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(self, action: #selector(handleShareTapped), for: .touchUpInside)
        return button
    }()
    
    private let infoLabel = UILabel()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor,left: leftAnchor, paddingTop: 8, paddingLeft: 8)
        
        let stack = UIStackView(arrangedSubviews: [infoLabel,captionLabel])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 4
        
        addSubview(stack)
        stack.anchor(top: profileImageView.topAnchor, left: profileImageView.rightAnchor, right: rightAnchor, paddingLeft: 12, paddingRight: 12)
        
        infoLabel.text = "Bruce Wayne @batima"
        infoLabel.font = UIFont.systemFont(ofSize: 14)
        
        let actionStack = UIStackView(arrangedSubviews: [commentButtom,retweetButton,likeButton,shareButton])
        actionStack.axis = .horizontal
        actionStack.spacing = 72
        
        addSubview(actionStack)
        actionStack.centerX(inView: self)
        actionStack.anchor( bottom: bottomAnchor, paddingBottom: 8)
        
        let underlineView = UIView()
        underlineView.backgroundColor = .systemGroupedBackground
        addSubview(underlineView)
        underlineView.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 1)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc func handleProfileImageTapped(){
        delegate?.handleProfileImageTapped(self)
    }
    
    @objc func handleCommentTapped(){
        print("DEBUG: handle Comment")
    }
    
    @objc func handleRetweetTapped(){
        print("DEBUG: handle retweet")
    }
    
    @objc func handleLikeTapped(){
        print("DEBUG: handle like")
    }
    
    @objc func handleShareTapped(){
        print("DEBUG: handle share")
    }
    
    //MARK: - HelperFunctions
    func configure(){
        guard let tweet = tweet else {return}
        let viewModel = TweetViewModel(tweet: tweet)
        captionLabel.text = tweet.caption
         
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        infoLabel.attributedText = viewModel.userInfoText
    }
}


