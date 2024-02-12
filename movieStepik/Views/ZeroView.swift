//
//  ZeroView.swift
//  movieStepik
//
//  Created by Mariya Aliyeva on 09.02.2024.
//

import UIKit

protocol ZeroViewOutput: AnyObject {
	func zeroViewCheckNetwork()
}

class ZeroView: UIView {
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var tryLabel: UIButton!
	
	weak var delegate: ZeroViewOutput?
	
	@IBAction func checkNetworkAction(_ sender: UIButton) {
		delegate?.zeroViewCheckNetwork()
	}
}
