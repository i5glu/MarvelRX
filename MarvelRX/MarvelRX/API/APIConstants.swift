//
//  APIConstants.swift
//  MarvelRX
//
//  Created by Илья Глущук on 18.01.2020.
//  Copyright © 2020 Илья Глущук. All rights reserved.
//

import Foundation

enum APIConstants {
    static var charactersURL: URL {
        let ts = timestamp
        return URL(string:baseURL + "/characters?apikey=\(publicKey)&hash=\(hash(with: ts))&ts=\(ts)")!
    }

    private static var timestamp: Int {
        Int(Date().timeIntervalSince1970)
    }

    private static var baseURL: String {
        "https://gateway.marvel.com:443/v1/public"
    }

    private static var publicKey: String {
        ProcessInfo.processInfo.environment["public_key"]!
    }

    private static var privateKey: String {
        ProcessInfo.processInfo.environment["private_key"]!
    }

    private static func hash(with timestamp: Int) -> String {
        let ts = String(timestamp)
        let hash = (ts + privateKey + publicKey).insecureMD5Hash() ?? ""

        return hash
    }
}

