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
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true

        return imageView
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

        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(characterImageView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-15)
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
    }

    private let disposeBag = DisposeBag()

    func configure(with model: CharacterModel) {
        nameLabel.text = model.name
        descLabel.text = model.description
        model.image.observeOn(MainScheduler.instance).bind { [weak self] in
            self?.characterImageView.image = $0
        }.disposed(by: disposeBag)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        characterImageView.image = nil
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
