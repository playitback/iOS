//
//  PBSyncableModel.swift
//  Playback
//
//  Created by Nick Babenko on 12/09/2014.
//  Copyright (c) 2014 Playback. All rights reserved.
//

import UIKit

class PBSyncableModel: NSManagedObject {
	
	internal func syncWithRemoteId(remoteId:String!) {
		NSException(name: "SyncRemoteFailedException",
			reason: "Failed to sync model. syncWithRemoteId not implemented.",
			userInfo: nil).raise()
	}
	
}