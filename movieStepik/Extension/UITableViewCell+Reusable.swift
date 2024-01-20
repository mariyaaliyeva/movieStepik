//
//  UITableViewCell+Reusable.swift
//  movieStepik
//
//  Created by Rustam Aliyev on 20.01.2024.
//

import Foundation
import UIKit

protocol Reusable {}

extension UITableViewCell: Reusable {}

extension Reusable where Self: UITableViewCell {
	
	static var reuseID: String {
		return String(describing: self)
	}
}
