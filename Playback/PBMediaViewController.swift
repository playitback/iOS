//
//  PBMediaViewController.swift
//  Playback
//
//  Created by Nick Babenko on 29/06/2014.
//  Copyright (c) 2014 Playback. All rights reserved.
//

import UIKit

class PBMediaViewController: UIViewController, UICollectionViewDataSource,
	UICollectionViewDelegate {
	
	@IBOutlet var collectionView:UICollectionView!
	
	let PBMediaCollectionViewCellIdentifier:String = "PBMediaCollectionViewCell"
 
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		initializeCollectionView()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	
	/** PBMediaViewController */
	
	func initializeCollectionView() {
		collectionView.registerNib(UINib(
				nibName: PBMediaCollectionViewCellIdentifier,
				bundle: nil),
			forCellWithReuseIdentifier: PBMediaCollectionViewCellIdentifier)
	}


	/** UICollectionViewDataSource */
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 1
	}

	func collectionView(collectionView:UICollectionView, cellForItemAtIndexPath
		indexPath:NSIndexPath) -> UICollectionViewCell {
		return collectionView.dequeueReusableCellWithReuseIdentifier(
			PBMediaCollectionViewCellIdentifier, forIndexPath: indexPath)
				as UICollectionViewCell
	}

}
