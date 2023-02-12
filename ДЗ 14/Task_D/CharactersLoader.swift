//
//  CharactersLoader.swift
//  ДЗ 14
//
//  Created by Yggdrasil on 02.02.2023.
//

import Foundation
import Alamofire
import AlamofireImage


class CharactersLoader {

    func loadCharacters(completion: @escaping (AllCharactersModel) -> Void){
          AF.request("https://rickandmortyapi.com/api/character")
    .responseDecodable(of: AllCharactersModel.self) { (response) in
        guard let characters = response.value else { return }
        
        completion(characters)
  }
 }
    func loadCharacterInfo(completion: @escaping ([CharacterModel]) -> Void){
          AF.request("https://rickandmortyapi.com/api/character/1")
    .responseDecodable(of: CharacterModel.self) { (response) in
        guard let character = response.value else { return }
        
        completion([character])
  }
 }
    
}
