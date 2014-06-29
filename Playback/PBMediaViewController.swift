//
//  PBMediaViewController.swift
//  Playback
//
//  Created by Nick Babenko on 29/06/2014.
//  Copyright (c) 2014 Playback. All rights reserved.
//

import UIKit

class PBMediaViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
	
	@IBOutlet var collectionView:UICollectionView!
	
	let PBMediaCollectionViewCellIdentifier:String = "PBMediaCollectionViewCell"

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		
		
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	
	/// UICollectionViewDataSource
	func collectionView(collectionView:UICollectionView!, numberOfItemsInSection section:Int) -> Int {
		return 1;
	}
	
	func collectionView(collectionView:UICollectionView!, cellForItemAtIndexPath indexPath:NSIndexPath!) -> UICollectionViewCell {
		return collectionView.dequeueReusableCellWithReuseIdentifier(PBMediaCollectionViewCellIdentifier, forIndexPath: indexPath) as UICollectionViewCell
	}

}
