//
//  CharacterModel.swift
//  MarvelRX
//
//  Created by Илья Глущук on 19.01.2020.
//  Copyright © 2020 Илья Глущук. All rights reserved.
//

import UIKit
import RxSwift

struct CharacterModel {
    let name: String
    let description: String?
    let image: Observable<UIImage?>
}
