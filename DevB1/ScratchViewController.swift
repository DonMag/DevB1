//
//  ScratchViewController.swift
//  DevB1
//
//  Created by Don Mag on 7/27/20.
//  Copyright © 2020 DonMag. All rights reserved.
//

import UIKit

class zScratchViewController: UIViewController {
	
	override func viewDidLoad() {
		view.backgroundColor = UIColor(red: 0.5, green: 0.75, blue: 1.0, alpha: 1.0)
		
		let v = NewEditableFuelSheetField(titleText: "A. Pre-refuel FOB", textFieldText: "")
		view.addSubview(v)
		v.translatesAutoresizingMaskIntoConstraints = false
		
		// respect safe-area
		let g = view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			v.topAnchor.constraint(equalTo: g.topAnchor, constant: 20.0),
			v.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 20.0),
			v.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -20.0),
		])
		
	}

}

class ScratchViewController: UIViewController {
	
	private lazy var preRefuel: NewEditableFuelSheetField = {
		return NewEditableFuelSheetField(titleText: "A. Pre-refuel FOB", textFieldText: "")
	}()
	
	private lazy var requiredDepartureFuel: NewEditableFuelSheetField = {
		return NewEditableFuelSheetField(titleText: "B. Required departure fuel", textFieldText: "")
	}()
	
	private lazy var requiredUplift: NewEditableFuelSheetField = {
		return NewEditableFuelSheetField(titleText: "C. Required uplift (B - A)", textFieldText: "")
	}()
	
	private lazy var actualUplift: NewEditableFuelSheetField = {
		return NewEditableFuelSheetField(titleText: "D. Actual uplift", textFieldText: "")
	}()
	
	private lazy var actualDepartureFuel: NewEditableFuelSheetField = {
		return NewEditableFuelSheetField(titleText: "E. Actual departure fuel", textFieldText: "")
	}()
	
	private lazy var refuelStackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [
			preRefuel,
			requiredDepartureFuel,
			requiredUplift,
			actualUplift,
			actualDepartureFuel
		])
		
		stack.axis = .vertical
		stack.distribution = .fillEqually
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
	}()
	
	override func viewDidLoad() {
		view.backgroundColor = UIColor(red: 0.5, green: 0.75, blue: 1.0, alpha: 1.0)
		
		view.addSubview(refuelStackView)
		
		// for visual example
		refuelStackView.spacing = 8
		
		// respect safe-area
		let g = view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			refuelStackView.topAnchor.constraint(equalTo: g.topAnchor, constant: 20.0),
			refuelStackView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 20.0),
			refuelStackView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -20.0),
		])
	
		let dView = DashedOutlineView()
		dView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(dView)
		NSLayoutConstraint.activate([
			dView.topAnchor.constraint(equalTo: refuelStackView.topAnchor, constant: -1.0),
			dView.leadingAnchor.constraint(equalTo: refuelStackView.leadingAnchor, constant: -1.0),
			dView.trailingAnchor.constraint(equalTo: refuelStackView.trailingAnchor, constant: 1.0),
			dView.bottomAnchor.constraint(equalTo: refuelStackView.bottomAnchor, constant: 1.0),
		])
	}

}

class DashedOutlineView: UIView {
	
	var shapeLayer: CAShapeLayer!
	
	override class var layerClass: AnyClass {
		return CAShapeLayer.self
	}
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	func commonInit() -> Void {
		shapeLayer = self.layer as? CAShapeLayer
		shapeLayer.fillColor = UIColor.clear.cgColor
		shapeLayer.strokeColor = UIColor.blue.cgColor // UIColor(red: 0.0, green: 0.75, blue: 0.0, alpha: 1.0).cgColor
		shapeLayer.lineWidth = 2.0
		shapeLayer.lineDashPattern = [10,10]
	}
	override func layoutSubviews() {
		super.layoutSubviews()
		shapeLayer.path = UIBezierPath(rect: bounds).cgPath
	}
}
