//
//  PBMedia.swift
//  Playback
//
//  Created by Nick Babenko on 12/09/2014.
//  Copyright (c) 2014 Playback. All rights reserved.
//

import Foundation
import CoreData

class PBMedia: PBSyncableModel {

    @NSManaged var availableDate: NSDate
    @NSManaged var name: String
    @NSManaged var number: NSNumber
    @NSManaged var overview: String
    @NSManaged var state: String
    @NSManaged var title: String
    @NSManaged var type: String
    @NSManaged var watchStatus: String
    @NSManaged var poster: PBPoster
    @NSManaged var season: PBSeason
    @NSManaged var still: PBPoster
    @NSManaged var torrents: NSSet
	@NSManaged var remoteId: String
	
	override func syncWithRemoteId(remoteId: String!) {
		
	}

}
