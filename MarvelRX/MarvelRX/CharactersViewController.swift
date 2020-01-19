//
//  ViewController.swift
//  MarvelRX
//
//  Created by Илья Глущук on 18.01.2020.
//  Copyright © 2020 Илья Глущук. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CharactersViewController: UITableViewController {

    let api = API()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = nil
        tableView.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell.reuseIdentifier)

        api.characters.subscribeOn(MainScheduler.instance).map {
            $0.data.results
        }.map {
            $0.map {
                CharacterModel(name: $0.name, imageURL: $0.thumbnail.url, description: $0.description)
            }
        }.bind(to: tableView.rx.items(cellIdentifier: CharacterCell.reuseIdentifier, cellType: CharacterCell.self)) { row, model, cell in
            cell.configure(with: model)
        }.disposed(by: disposeBag)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}

