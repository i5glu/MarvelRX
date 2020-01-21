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
        let request = URLRequest(url: APIConstants.charactersURL(offset: offset))
        return session.rx.data(request: request).map {
            try JSONDecoder().decode(CharacterDataWrapper.self, from: $0)
        }
    }

    var characters: Observable<CharacterDataWrapper> {
        characters(offset: 0)
    }

    func loadImage(with url: URL) -> Observable<UIImage?> {
        let request = URLRequest(url: url)

        if let cachedResponse = cache.cachedResponse(for: request) {
            return Observable<UIImage?>.create { observer -> Disposable in
                observer.on(.next(UIImage(data: cachedResponse.data)))
                observer.on(.completed)

                return Disposables.create()
            }
        }

        return session.rx.response(request: request).map { [weak self] (response, data) -> UIImage? in
            self?.cache.storeCachedResponse(CachedURLResponse(response: response, data: data), for: request)

            return UIImage(data: data)
        }
    }
}
