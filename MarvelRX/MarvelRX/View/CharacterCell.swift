//
//  CharacterCell.swift
//  MarvelRX
//
//  Created by Илья Глущук on 19.01.2020.
//  Copyright © 2020 Илья Глущук. All rights reserved.
//

import UIKit
import SnapKit

final class CharacterCell: UITableViewCell {
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)

        return label
    }()

    private let descLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 5

        return label
    }()

    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(nameLabel)
        contentView.addSubview(descLabel)
        contentView.addSubview(characterImageView)

        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(10)
            make.left.equalTo(characterImageView).offset(5)
            make.right.equalTo(contentView).offset(15)
        }

        characterImageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.top.equalTo(contentView).offset(10)
            make.left.equalTo(contentView).offset(15)
        }

        descLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.left.equalTo(nameLabel.snp.left)
            make.right.equalTo(nameLabel.snp.right)
        }
    }

    func configure(with model: CharacterModel) {
        nameLabel.text = model.name
        descLabel.text = model.description
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
