//
//  ViewController.swift
//  GenerateI18NConstantsDemo
//
//  Created by David Casserly on 15/12/2015.
//  Copyright © 2015 DevedUpLtd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		print(Localized.AppTesting)
		print(Localized.AppWelcomeMessage.with("Dan"))
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
		
	}


}

