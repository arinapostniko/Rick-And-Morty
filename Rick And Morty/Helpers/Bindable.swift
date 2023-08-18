//
//  Bindable.swift
//  Rick And Morty
//
//  Created by Arina Postnikova on 18.08.23.
//

import Foundation

class Bindable<T> {
    var value: T? {
        didSet { valueChanged?(value) }
    }
    private var valueChanged: ((T?) -> Void)?
    
    init(_ value: T?) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T?) -> Void) {
        valueChanged = closure
        closure(value)
    }
}
