//
//  RickAndMortyTableViewCell.swift
//  MVVMRxSwiftTestJob
//
//  Created by Александр Новиков on 16.11.2022.
//

import UIKit

class RickAndMortyTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: "RickAndMortyTableViewCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
