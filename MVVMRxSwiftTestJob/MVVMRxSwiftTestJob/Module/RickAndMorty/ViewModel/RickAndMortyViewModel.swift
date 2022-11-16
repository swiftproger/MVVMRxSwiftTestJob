//
//  RickAndMortyViewModel.swift
//  MVVMRxSwiftTestJob
//
//  Created by Александр Новиков on 15.11.2022.
//

import Foundation
import RxSwift
import RxCocoa

final class RickAndMortyViewModel {
    var characters = BehaviorSubject(value: [Characters]())
    
    func fetchCharacters() {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(CharactersResultRequest.self, from: data)
                self.characters.on(.next(response.getCharacters()))
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
