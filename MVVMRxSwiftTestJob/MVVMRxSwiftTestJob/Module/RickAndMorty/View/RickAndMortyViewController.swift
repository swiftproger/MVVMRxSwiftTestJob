//
//  RickAndMortyViewController.swift
//  MVVMRxSwiftTestJob
//
//  Created by Александр Новиков on 15.11.2022.
//

import UIKit
import RxSwift
import RxCocoa

final class RickAndMortyViewController: UIViewController {
    
    private var viewModel = RickAndMortyViewModel()
    private var bag = DisposeBag()
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView(frame: self.view.frame, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RickAndMortyTableViewCell.self, forCellReuseIdentifier: "RickAndMortyTableViewCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getData()
        bindTibleView()
    }
    
    private func setupUI() {
        self.view.addSubview(tableView)
    }
    
    private func getData() {
        viewModel.fetchCharacters()
    }
    
    private func bindTibleView() {
        tableView.rx.setDelegate(self).disposed(by: bag)
        viewModel.characters.bind(to: tableView.rx.items(cellIdentifier: "RickAndMortyTableViewCell", cellType: RickAndMortyTableViewCell.self)) { (row, item, cell) in
            cell.textLabel?.text = item.getName()
        }.disposed(by: bag)
    }
}

extension RickAndMortyViewController: UITableViewDelegate {}
