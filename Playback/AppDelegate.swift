//
//  AppDelegate.swift
//  Playback
//
//  Created by Nick Babenko on 29/06/2014.
//  Copyright (c) 2014 Playback. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
	var window: UIWindow?
	var syncManager:PBDBSyncManager?
	var theMovieDb:TMDB?
	
	
	// AppDelegate
	
	private func configureMagicalRecord() {
		MagicalRecord.setupCoreDataStackWithAutoMigratingSqliteStoreNamed(
			"Playback")
	}
	
	private func configureSyncManager() {
		syncManager = PBDBSyncManager()
	}
	
	private func configureMovieDb() {
		
	}

	
	// UIApplicationDelegate

	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
		self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
		
		self.window!.backgroundColor = UIColor.whiteColor()
		
		self.window!.makeKeyAndVisible()
		
		configureMagicalRecord()
		configureSyncManager()
		configureMovieDb()
		
		return true
	}

	func applicationWillResignActive(application: UIApplication) {

	}

	func applicationDidEnterBackground(application: UIApplication) {

	}

	func applicationWillEnterForeground(application: UIApplication) {

	}

	func applicationDidBecomeActive(application: UIApplication) {

	}

	func applicationWillTerminate(application: UIApplication) {
		NSManagedObjectContext.MR_defaultContext().save(nil)
	}

}

