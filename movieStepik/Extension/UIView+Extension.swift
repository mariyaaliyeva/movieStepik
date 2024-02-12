//
//  UIView+Extension.swift
//  movieStepik
//
//  Created by Mariya Aliyeva on 09.02.2024.
//

import Foundation
import UIKit

extension UIView {
	
	static func loadFromNib() -> Self {
		
		let selfClass: AnyClass = self as AnyClass
		var className = NSStringFromClass(selfClass)
		let bundle = Bundle(for: selfClass)
		
		if bundle.path(forResource: className, ofType: "nib") == nil {
			className = (className as NSString).pathExtension
			if bundle.path(forResource: className, ofType: "nib") == nil {
				fatalError("No xib file for view \(type(of: self))")
			}
		}
		
		return view(bundle, className: className)
	}
	
	private static func view<T: UIView>(_ bundle: Bundle, className: String) -> T {
		guard let nibContents = bundle.loadNibNamed(className, owner: nil, options: nil)
		else { fatalError("No xib file for view \(className)") }
		
		guard let view = nibContents.first(where: { ($0 as AnyObject).isKind(of: self) }) as? T
		else { fatalError("Xib doesn't have a view of such class \(self)") }
		return view
	}
}
