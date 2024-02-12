//
//  UIView+hide.swift
//  movieStepik
//
//  Created by Rustam Aliyev on 09.02.2024.
//

import Foundation
import UIKit

extension UIView {
	
	func hide() {
		guard !isHidden else { return }
		isHidden = true
	}
	
	func show() {
		guard isHidden else { return }
		isHidden = false
	}
}
