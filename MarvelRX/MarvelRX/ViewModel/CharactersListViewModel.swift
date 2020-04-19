//
//  CharactersListViewModel.swift
//  MarvelRX
//
//  Created by Илья Глущук on 22.01.2020.
//  Copyright © 2020 Илья Глущук. All rights reserved.
//

import RxSwift
import RxCocoa

protocol CharactersListViewModelProtocol {
    var characters: Driver<[CharacterModel]> { get }
    var loadCharacters: PublishSubject<Int> { get }
    var saveCharacter: PublishSubject<CharacterModel> { get }
}

final class CharactersListViewModel: CharactersListViewModelProtocol {
    private let api = API()
    let bag = DisposeBag()

    private var charactersSubject = BehaviorRelay<[CharacterModel]>(value: [])
    var characters: Driver<[CharacterModel]> {
        charactersSubject.asDriver()
    }

    private(set) var loadCharacters = PublishSubject<Int>()
    private(set) var saveCharacter = PublishSubject<CharacterModel>()

    init() {
        saveCharacter.subscribe(onNext: { (character) in
            // TODO: save to storage
        }).disposed(by: bag)

        loadCharacters.subscribe(onNext: { [unowned self] (offset) in
            self.api.characters(offset: offset).map { [unowned self] in
                $0.data.results.map {
                    CharacterModel(name: $0.name,
                                   description: $0.description,
                                   image: self.api.loadImage(with: $0.thumbnail.url))
                }
            }.subscribe({ [unowned self] event in
                if case .next(let characters) = event {
                    self.charactersSubject.accept(self.charactersSubject.value + characters)
                }
            }).disposed(by: self.bag)
        }).disposed(by: bag)
    }
}
