//
//  Presenter.swift
//  DemoNetworkingApp
//
//  Created by r.a.gazizov on 04.05.2023.
//

import Foundation

protocol IPresenter: AnyObject {
    var dataSource: [CharacterCell.Model] { get }
    func viewDidLoad()
    func willDisplayCell(at indexPath: IndexPath)
}

final class Presenter: IPresenter {
    
    // Dependencies
    weak var view: IView?
    private let networkService: INetworkService
    
    // Properties
    var dataSource: [CharacterCell.Model] = []
    private var page = 1
    private var isLoading = false
    
    // MARK: - Initialization
    
    init(networkService: INetworkService) {
        self.networkService = networkService
    }
    
    // MARK: - IPresenter
    
    func viewDidLoad() {
        obtainData()
    }
    
    func willDisplayCell(at indexPath: IndexPath) {
        if indexPath.row == dataSource.count - 2 {
            page += 1
            obtainData()
        }
    }
    
    // MARK: - Private
    
    private func obtainData() {
        guard !isLoading else { return }
        isLoading = true
        networkService.getCharacters(page: page) { [weak self] characters in
            guard let self else { return }
            self.dataSource += self.makeViewModels(from: characters)
            self.view?.reloadData()
            self.isLoading = false
        }
    }

    private func makeViewModels(from characters: [Character]) -> [CharacterCell.Model] {
        return characters.map { character in
            CharacterCell.Model(imageUrl: character.image,
                                name: character.name,
                                gender: character.gender.rawValue,
                                location: character.location.name)
        }
    }
}
