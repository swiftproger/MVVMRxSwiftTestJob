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
        bindImageLoader()
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
        
        tableView.rx
            .willDisplayCell
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { cell, indexPath in
                self.viewModel.loadImageFromGivenItem(with: indexPath.row)
            })
            .disposed(by: bag)
    }
    
    private func bindImageLoader() {
        viewModel.imageDownloaded
            .observe(on: MainScheduler.instance)
            .filter({ $0.1 != nil })
            .map({ ($0.0, $0.1!) })
            .subscribe(onNext: { [unowned self] index, image in
                guard let cell = self.tableView.cellForRow(at: IndexPath(item: index, section: 0)) as? RickAndMortyTableViewCell else {
                    return
                }
                cell.imageView?.image = image
            })
            .disposed(by: bag)
    }
}

extension RickAndMortyViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}
