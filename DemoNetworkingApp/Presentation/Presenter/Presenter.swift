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
    func willDisplayForRowAt(indexPath: IndexPath)
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
    
    func willDisplayForRowAt(indexPath: IndexPath) {
        if indexPath.row == dataSource.count - 1 {
            page += 1
            obtainData()
        }
    }
    
    // MARK: - Private
    
    func obtainData() {
        guard !isLoading else { return }
        isLoading = true
        networkService.getCharacters(page: page) { [weak self] (models: [Character]) in
            let viewModels = models.map { (character) -> CharacterCell.Model in
                return CharacterCell.Model(imageUrl: character.image,
                                           name: character.name,
                                           gender: character.gender.rawValue,
                                           location: character.location.name)
            }
            self?.dataSource += viewModels
            self?.view?.reloadData()
            self?.isLoading = false
        }
    }
}
