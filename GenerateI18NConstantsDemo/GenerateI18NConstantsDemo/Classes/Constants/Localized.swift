/* Generated by 'Generate-Swift-L18N-Constants.swift' DO NOT CHANGE */

import Foundation

/**
Usage:

Localized.loadError
Localized.welcomeMessage.with("Dan")
*/

enum Localized: CustomStringConvertible {
    
	class Bundles {
		static let framework = Bundle(for: Localized.Bundles.self)
	}

	case appWelcomeMessage
	case appTesting

	var key : String {
		switch self {
			case .appWelcomeMessage:
					return "app.welcome.message"
			case .appTesting:
					return "app.testing"
		}
	}
	
	var description : String {
		return NSLocalizedString(self.key, tableName: nil, bundle: Localized.Bundles.framework, value: self.key, comment: self.key)
	}
	
	func with(_ args: CVarArg...) -> String {
		let format = description
		return String(format: format, arguments: args)
	}
}
