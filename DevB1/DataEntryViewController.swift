//
//  DataEntryViewController.swift
//  DevB1
//
//  Created by Don Mag on 7/27/20.
//  Copyright © 2020 DonMag. All rights reserved.
//

import UIKit

// MARK: Field element with textfield:

class NewEditableFuelSheetField: UIView {
	
	var titleText: String?
	
	var textFieldText: String?
	
	init(titleText: String, textFieldText: String) {
		
		super.init(frame: .zero)
		self.titleText = titleText
		self.textFieldText = textFieldText
		
		self.addSubview(editableField)
		
		// this was missing from the code in your question
		configureAutoLayout()
		
		// so we can see the frames at run-time
		self.backgroundColor = .red
		
		// set clipsToBounds
		self.clipsToBounds = true
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private lazy var editableField: UIStackView = {
		let title = UILabel()
		title.text = self.titleText
		
		let textField = UITextField()
		textField.isEnabled = false
		
		// so we can see the frames at run-time
		title.backgroundColor = .yellow
		textField.backgroundColor = .green
		//
		
		let stack = UIStackView(arrangedSubviews: [title, textField])
		stack.axis = .vertical
		stack.distribution = .fillEqually
		stack.translatesAutoresizingMaskIntoConstraints = false
		
		return stack
	}()
	
	private func configureAutoLayout() {
		NSLayoutConstraint.activate([
			editableField.heightAnchor.constraint(equalToConstant: 50),
			
			// constraints relative to superview (self)
			editableField.topAnchor.constraint(equalTo: topAnchor),
			editableField.leadingAnchor.constraint(equalTo: leadingAnchor),
			editableField.bottomAnchor.constraint(equalTo: bottomAnchor),
		])
	}
}

// MARK: Field with fixed values:

class NewFixedFuelSheetField: UIView {
	
	var title: String?
	
	var detail: String?
	
	init(title: String, detail: String) {
		
		super.init(frame: .zero)
		
		self.title = title
		
		self.detail = detail
		configureAutoLayout()
		
		self.addSubview(fixedField)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private lazy var fixedField: UIStackView = {
		
		let title = UILabel()
		let detail = UILabel()
		
		title.text = self.title
		detail.text = self.detail
		
		let stack = UIStackView(arrangedSubviews: [title, detail])
		stack.axis = .vertical
		stack.distribution = .fillEqually
		
		stack.translatesAutoresizingMaskIntoConstraints = false
		
		self.addSubview(stack)
		
		return stack
	}()
	
	private func configureAutoLayout() {
		NSLayoutConstraint.activate([
			fixedField.heightAnchor.constraint(equalToConstant: 50)
		])
	}
}

// MARK: Header view containing a stack of non editable fields:

class NewFuelSheetHeaderView: UIView {
	
	// MARK:  Init
	
	override init(frame: CGRect) {
		super.init(frame: .zero)
		self.addSubview(fuelSheetHeaderStack)
		configureAutoLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK:  Properties
	
	// 'detail' text will be brought in from API in next ticket
	
	private lazy var flightNumber: NewFixedFuelSheetField = {
		return NewFixedFuelSheetField(title: "Flight number", detail: "VS0101")
	}()
	
	private lazy var aircraftReg: NewFixedFuelSheetField = {
		return NewFixedFuelSheetField(title: "Aircraft reg", detail: "GAAAA")
	}()
	
	private lazy var date: NewFixedFuelSheetField = {
		return NewFixedFuelSheetField(title: "Date", detail: "01.01.21")
	}()
	
	private lazy var time: NewFixedFuelSheetField = {
		return NewFixedFuelSheetField(title: "Time", detail: "12:01")
	}()
	
	private let supplier: NewFixedFuelSheetField = {
		return NewFixedFuelSheetField(title: "Supplier", detail: "i6Staging, BAPCO")
	}()
	
	private let fuelGrade: NewFixedFuelSheetField = {
		return NewFixedFuelSheetField(title: "Fuel grade", detail: "Jet A")
	}()
	
	private let freezePoint: NewFixedFuelSheetField = {
		return NewFixedFuelSheetField(title: "Freeze point", detail: "-40")
	}()
	
	private let specificGravity: NewFixedFuelSheetField = {
		return NewFixedFuelSheetField(title: "Specific gravity", detail: "0.793")
	}()
	
	private lazy var fuelSheetHeaderFirstRow: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [
			flightNumber,
			aircraftReg,
			date,
			time
		])
		
		stack.axis = .horizontal
		stack.distribution = .fillEqually
		return stack
	}()
	
	private lazy var fuelSheetHeaderSecondRow: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [
			supplier,
			fuelGrade,
			freezePoint,
			specificGravity
		])
		
		stack.axis = .horizontal
		stack.distribution = .fillEqually
		return stack
	}()
	
	private lazy var fuelSheetHeaderStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [fuelSheetHeaderFirstRow, fuelSheetHeaderSecondRow])
		stack.axis = .vertical
		stack.distribution = .fillEqually
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
	}()
	
	// MARK:  Configuration
	
	private func configureAutoLayout() {
		NSLayoutConstraint.activate([
			fuelSheetHeaderStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
			fuelSheetHeaderStack.leftAnchor.constraint(equalTo: leftAnchor),
			fuelSheetHeaderStack.rightAnchor.constraint(equalTo: rightAnchor),
			fuelSheetHeaderStack.heightAnchor.constraint(equalToConstant: 200)
		])
	}
}

// MARK: Second view which ultimately needs to be placed beneath the header:

class NewFuelSheetRefuelInfoView: UIView {
	
	// MARK:  Init
	
	override init(frame: CGRect) {
		super.init(frame: .zero)
		self.addSubview(refuelStackView)
		configureAutoLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK:  Properties
	
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
	
	// MARK:  Config
	
	private func configureAutoLayout() {
		NSLayoutConstraint.activate([
			refuelStackView.topAnchor.constraint(equalTo: topAnchor, constant: 50),
			refuelStackView.leftAnchor.constraint(equalTo: leftAnchor),
			refuelStackView.rightAnchor.constraint(equalTo: rightAnchor),
			refuelStackView.heightAnchor.constraint(equalToConstant: 300)
		])
	}
}

// MARK: Then I have a main view to bring these elements together:

class NewFuelSheetMainView: UIView {
	
	override init(frame: CGRect) {
		super.init(frame: .zero)
		self.addSubview(mainStack)
		configureAutoLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private lazy var flightDetailsHeader: NewFuelSheetHeaderView = {
		return NewFuelSheetHeaderView()
	}()
	
	private lazy var refuelView: NewFuelSheetRefuelInfoView = {
		return NewFuelSheetRefuelInfoView()
	}()
	
	private lazy var mainStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [flightDetailsHeader, refuelView])
		stack.axis = .vertical
		stack.distribution = .fillEqually
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
	}()
	
	private func configureAutoLayout() {
		NSLayoutConstraint.activate([
			mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 30),
			mainStack.leftAnchor.constraint(equalTo: leftAnchor),
			mainStack.rightAnchor.constraint(equalTo: rightAnchor),
			mainStack.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
}

// MARK: And finally a VC to display the main view:

//class DataEntryViewController: I6ViewController {

class DataEntryViewController: UIViewController {
	
	// MARK:  Init
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nil, bundle: nil)
//		configureAutoLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK:  Lifecycle
	
	override func viewDidLoad() {
		view.backgroundColor = .white
		
		let v = NewEditableFuelSheetField(titleText: "A. Pre-refuel FOB", textFieldText: "")
		v.backgroundColor = .red
		v.clipsToBounds = true
		view.addSubview(v)
		v.translatesAutoresizingMaskIntoConstraints = false
		let g = view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			v.topAnchor.constraint(equalTo: g.topAnchor, constant: 20.0),
			v.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 20.0),
			v.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -20.0),
			//v.heightAnchor.constraint(equalToConstant: 100.0),
		])

	}
	
	// MARK:  Properties
	
	private lazy var mainView: NewFuelSheetMainView = {
		let mainView = NewFuelSheetMainView()
		mainView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(mainView)
		return mainView
	}()
	
	// MARK:  Configuration
	
	private func configureAutoLayout() {
		NSLayoutConstraint.activate([
			mainView.leftAnchor.constraint(equalTo: view.leftAnchor),
			mainView.rightAnchor.constraint(equalTo: view.rightAnchor),
		])
	}
}

