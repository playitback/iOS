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
	var watchedEntities = [String]()
	
	override init() {
		// TODO: Load values from configuration
		accountManager = DBAccountManager(appKey: "", secret: "")
		
		if(accountManager.linkedAccount != nil) {
			dataStore = DBDatastore.openDefaultStoreForAccount(
				self.accountManager.linkedAccount, error: nil)
		}
	}
 
	private func watchEntityWithName(name:String!) {
		watchedEntities.append(name)
	}
	
	private func startObserving() {
		if(dataStore == nil) {
			return;
		}
		
		dataStore?.addObserver(self, block: {
			if(self.dataStore?.status.incoming != false) {
				self.syncDataStore()
			}
		})
	}
	
	private func stopObserving() {
		self.dataStore?.removeObserver(self)
	}
	
	private func syncDataStore() {
		var changes = dataStore?.sync(nil)
		
		if(changes != nil) {
			updateCoreDataWithDatastoreChanges(changes!)
		}
	}
	
	private func updateCoreDataWithDatastoreChanges(changes:NSDictionary) {
		for (tableName, dbRecord) in changes {
			updateModelWithRecord(tableName as NSString, record:
				dbRecord as DBRecord)
		}
	}
	
	private func updateModelWithRecord(tableName:NSString, record:DBRecord) {
		let remoteId:NSString = record.objectForKey("remoteId") as NSString
		
		let modelClass:NSObject.Type = NSClassFromString(
			NSString(format: "PB%@", tableName)) as NSObject.Type
		
		if(modelClass.isSubclassOfClass(PBSyncableModel)) {
			let modelInstance:PBSyncableModel = modelClass() as PBSyncableModel
			
			modelInstance.syncWithRemoteId(remoteId)
		}
	}
	
}