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
    private let viewModel = CharactersListViewModel()
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()

        viewModel.characters.drive(tableView.rx.items(cellIdentifier: CharacterCell.reuseIdentifier, cellType: CharacterCell.self)) { row, model, cell in
            cell.configure(with: model)
        }.disposed(by: bag)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }

    private func configureTableView() {
        tableView.dataSource = nil
        tableView.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell.reuseIdentifier)
    }
}

