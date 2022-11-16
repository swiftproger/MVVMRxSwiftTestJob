//
//  LoginViewModel.swift
//  MVVMRxSwiftTestJob
//
//  Created by Александр Новиков on 15.11.2022.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    
    var login: BehaviorSubject<String> = BehaviorSubject(value: "")
    var password: BehaviorSubject<String> = BehaviorSubject(value: "")
    
    var isValidLogin: Observable<Bool> {
        login.map { login in
            return login.count < 5 ? false : true
        }
    }
    
    var isValidPassword: Observable<Bool> {
        password.map { password in
            return password.count < 5 ? false : true
        }
    }
    
    var isValidInput: Observable<Bool> {
        return Observable.combineLatest(isValidLogin, isValidPassword).map({ $0 && $1 })
    }
}
