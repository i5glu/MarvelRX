//
//  CharactersListViewModel.swift
//  MarvelRX
//
//  Created by Илья Глущук on 22.01.2020.
//  Copyright © 2020 Илья Глущук. All rights reserved.
//

import RxSwift
import RxCocoa

class CharactersListViewModel {
    private let api = API()
    private let bag = DisposeBag()

    private var charactersSubject = BehaviorRelay<[CharacterModel]>(value: [])
    var characters: Driver<[CharacterModel]> {
        charactersSubject.asDriver()
    }

    func loadNextPage() {
        let offset = charactersSubject.value.count
        api.characters(offset: offset).map { [unowned self] in
            $0.data.results.map {
                CharacterModel(name: $0.name,
                               description: $0.description,
                               image: self.api.loadImage(with: $0.thumbnail.url))
            }
        }.subscribe({ [unowned self] event in
            if case .next(let characters) = event {
                self.charactersSubject.accept(self.charactersSubject.value + characters)
            }
        }).disposed(by: bag)
    }
}
