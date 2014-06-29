//
//  PBDBSync.swift
//  Playback
//
//  Created by Nick Babenko on 29/06/2014.
//  Copyright (c) 2014 Playback. All rights reserved.
//

import UIKit

class PBDBSyncManager: NSObject {
		
	var accountManager:DBAccountManager!
	var dataStore:DBDatastore?
	var watchedEntities = String[]()
	
	init() {
		// TODO: Load values from configuration
		self.accountManager = DBAccountManager(appKey:"", secret:"")
		
		if(self.accountManager.linkedAccount) {
			self.dataStore = DBDatastore.openDefaultStoreForAccount(self.accountManager.linkedAccount, error: nil)
		}
	}
 
	func watchEntityWithName(name:String!) {
		self.watchedEntities.append(name)
	}
	
	func startObserving() {
		if(!self.dataStore) {
			return;
		}
		
		self.dataStore?.addObserver(self, block: {
			if(self.dataStore?.status.incoming) {
				self.syncDataStore()
			}
		})
	}
	
	func stopObserving() {
		self.dataStore?.removeObserver(self)
	}
	
	func syncDataStore() {
		var error:DBError
		var changes:NSDictionary = self.dataStore?.sync(error: error)
		
		if(changes) {
			self.updateCoreDataWithDatastoreChanges(changes)
		}
	}
	
	func updateCoreDataWithDatastoreChanges(changes:NSDictionary) {
		changes.enumerateKeysAndObjectsUsingBlock({ (tableId:NSString.self, records:NSArray.self, stop:Boolean.self)
			for(DBRecord record in records) {
				
			}
		})
	}
	
}