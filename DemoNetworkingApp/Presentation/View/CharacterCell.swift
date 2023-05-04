//
//  CharacterCell.swift
//  DemoNetworkingApp
//
//  Created by r.a.gazizov on 04.05.2023.
//

import UIKit
import SnapKit

final class CharacterCell: UITableViewCell {
    
    // UI
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 40
        imageView.image = UIImage(named: "avatar-placeholder")
        return imageView
    }()
    private lazy var nameLabel = UILabel()
    private lazy var genderLabel = UILabel()
    private lazy var locationLabel = UILabel()
    private lazy var labelsStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [nameLabel, genderLabel, locationLabel])
        view.axis = .vertical
        view.distribution = .equalSpacing
        return view
    }()
    private lazy var contentStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [logoImageView, labelsStackView])
        view.axis = .horizontal
        view.spacing = 16
        return view
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(contentStackView)
        contentStackView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(80)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        logoImageView.image = UIImage(named: "avatar-placeholder")
        nameLabel.text = nil
        genderLabel.text = nil
        locationLabel.text = nil
    }
}

// MARK: - Configuration

extension CharacterCell {
    
    struct Model {
        let imageUrl: String
        let name: String
        let gender: String
        let location: String
    }
    
    func configure(with model: Model) {
        logoImageView.downloadImage(from: model.imageUrl)
        nameLabel.text = model.name
        genderLabel.text = model.gender
        locationLabel.text = model.location
    }
}
