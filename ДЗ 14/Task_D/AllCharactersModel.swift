//
//  AllCharactersModel.swift
//  ДЗ 14
//
//  Created by Yggdrasil on 02.02.2023.
//

import Foundation

struct AllCharactersModel: Codable {
    var info: Info
    var results: [CharacterModel]
}
struct Info: Codable {
    var count, pages: Int
    var next: String?
    var prev: String?
}

public struct CharacterModel: Codable {
    public let id: Int
    public let name: String
    public let status: String
    public let species: String
    public let type: String
    public let gender: String
    public let origin: CharacterOriginModel
    public let location: CharacterLocationModel
    public let image: String
    public let episode: [String]
    public let url: String
    public let created: String
}

public struct CharacterOriginModel: Codable {
    public let name: String
    public let url: String
}

public struct CharacterLocationModel: Codable {
    public let name: String
    public let url: String
}
