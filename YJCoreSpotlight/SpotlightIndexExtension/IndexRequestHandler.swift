//
//  IndexRequestHandler.swift
//  SpotlightIndexExtension
//
//  Created by yangjun on 16/1/28.
//  Copyright © 2016年 阳君. All rights reserved.
//

import CoreSpotlight

class IndexRequestHandler: CSIndexExtensionRequestHandler {

    override func searchableIndex(searchableIndex: CSSearchableIndex, reindexAllSearchableItemsWithAcknowledgementHandler acknowledgementHandler: () -> Void) {
        // Reindex all data with the provided index
        print(__FUNCTION__)
        acknowledgementHandler()
    }

    override func searchableIndex(searchableIndex: CSSearchableIndex, reindexSearchableItemsWithIdentifiers identifiers: [String], acknowledgementHandler: () -> Void) {
        // Reindex any items with the given identifiers and the provided index
        print(__FUNCTION__)
        acknowledgementHandler()
    }

}
