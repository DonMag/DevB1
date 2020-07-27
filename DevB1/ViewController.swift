//
//  ViewController.swift
//  DevB1
//
//  Created by Don Mag on 7/27/20.
//  Copyright © 2020 DonMag. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	@IBAction func pushToDataEntryVC(_ sender: Any) {
		let vc = DataEntryViewController()
		self.navigationController?.pushViewController(vc, animated: true)
	}
	
}

