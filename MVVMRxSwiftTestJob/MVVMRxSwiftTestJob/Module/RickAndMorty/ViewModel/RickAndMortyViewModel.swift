//
//  RickAndMortyViewModel.swift
//  MVVMRxSwiftTestJob
//
//  Created by Александр Новиков on 15.11.2022.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

final class RickAndMortyViewModel {
    var characters = BehaviorSubject(value: [Characters]())
    var imageDownloaded = PublishRelay<(Int, UIImage?)>()
    
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
    
    func loadImageFromGivenItem(with index: Int) {
        guard let url = try? characters.value()[index].getImage() else { return }
        ReceiveImage.shared.downloadImage(urlString: url) { [weak self] image in
            self?.imageDownloaded.accept((index, image))
        }
    }
    
    func getCharacters(index: IndexPath) -> Characters {
        guard let characters = try? characters.value()[index.row] else { return Characters() }
        return characters
    }
}
