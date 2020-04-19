//
//  CharacterCell.swift
//  MarvelRX
//
//  Created by Илья Глущук on 19.01.2020.
//  Copyright © 2020 Илья Глущук. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class CharacterCell: UITableViewCell {
    static let reuseIdentifier = String(describing: CharacterCell.self)
    private(set) var bag = DisposeBag()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)

        return label
    }()

    private let descLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 5

        return label
    }()

    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true

        return imageView
    }()

    private(set) var favoritesButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Star"), for: .normal)
        button.setImage(UIImage(named: "StarFilled"), for: .highlighted)

        return button
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        descLabel.preferredMaxLayoutWidth = descLabel.frame.width
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(nameLabel)
        contentView.addSubview(descLabel)
        contentView.addSubview(characterImageView)
        contentView.addSubview(favoritesButton)

        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(characterImageView.snp.right).offset(10)
            make.right.equalTo(favoritesButton.snp.left)
        }

        characterImageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(15)
        }

        descLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.left.equalTo(nameLabel.snp.left)
            make.right.equalTo(nameLabel.snp.right)
        }

        favoritesButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.size.equalTo(CGSize(width: 44, height: 44))
        }
    }

    func configure(with model: CharacterModel) {
        nameLabel.text = model.name
        descLabel.text = model.description
        model.image.asDriver(onErrorJustReturn: nil)
                    .drive(characterImageView.rx.image).disposed(by: bag)

    }

    override func prepareForReuse() {
        super.prepareForReuse()
        characterImageView.image = nil
        bag = DisposeBag()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
