//
//  AlertError.swift
//  OtoKlix
//
//  Created by Phincon on 04/02/22.
//

import Foundation

struct AlertError {
    let title: String?
    let description: String?
    let action: AlertAction
}

struct AlertAction {
    let title: String?
    let handle: (() -> Void)?
}
