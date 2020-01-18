//
//  StringExtension.swift
//  MarvelRX
//
//  Created by Илья Глущук on 18.01.2020.
//  Copyright © 2020 Илья Глущук. All rights reserved.
//

import Foundation
import CryptoKit

private protocol ByteCountable {
  static var byteCount: Int { get }
}

extension Insecure.MD5: ByteCountable { }
extension Insecure.SHA1: ByteCountable { }

extension String {
  func insecureMD5Hash(using encoding: String.Encoding = .utf8) -> String? {
    return self.hash(algo: Insecure.MD5.self, using: encoding)
  }

  func insecureSHA1Hash(using encoding: String.Encoding = .utf8) -> String? {
    return self.hash(algo: Insecure.SHA1.self, using: encoding)
  }

  private func hash<Hash: HashFunction & ByteCountable>(algo: Hash.Type, using encoding: String.Encoding = .utf8) -> String? {
    guard let data = self.data(using: encoding) else {
      return nil
    }

    return algo.hash(data: data).prefix(algo.byteCount).map {
      String(format: "%02hhx", $0)
    }.joined()
  }
}
