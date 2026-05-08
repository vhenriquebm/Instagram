//
//  Localization.swift
//  InstaClone
//
//  Created by Vitor Henrique Barreiro Marinho on 08/05/26.
//

import Foundation

private func localized(_ key: String) -> String {
    NSLocalizedString(key, comment: "")
}

enum Button {
    static var back: String {
        localized("button.back")
    }

    static var logout: String {
        localized("button.logout")
    }
}

enum Feed {
    static var title: String {
        localized("feed.title")
    }
}
