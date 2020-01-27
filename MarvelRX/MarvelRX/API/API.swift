//
//  API.swift
//  MarvelRX
//
//  Created by Илья Глущук on 18.01.2020.
//  Copyright © 2020 Илья Глущук. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class API {
    private let session: URLSession = .shared
    private let cache: URLCache = .shared

    func characters(offset: Int) -> Observable<CharacterDataWrapper> {
        let response = Observable.from([APIConstants.charactersURL(offset: offset)])
        return response.map {
            URLRequest(url: $0)
        }.flatMap { [unowned self] in
            self.session.rx.data(request: $0)
        }.map {
            try JSONDecoder().decode(CharacterDataWrapper.self, from: $0)
        }
    }

    var characters: Observable<CharacterDataWrapper> {
        characters(offset: 0)
    }

    func loadImage(with url: URL) -> Observable<UIImage?> {
        let request = URLRequest(url: url)

        if let cachedResponse = cache.cachedResponse(for: request) {
            let image = UIImage(data: cachedResponse.data)
            return Observable<UIImage?>.just(image)
        }

        return Observable.from([request]).flatMap { [unowned self] in
            self.session.rx.response(request: $0)
        }.do(onNext: { [weak self] in
            let cachedResponse = CachedURLResponse(response: $0.response, data: $0.data)
            self?.cache.storeCachedResponse(cachedResponse, for: request)
        }).map {
            UIImage(data: $0.data)
        }
    }
}
