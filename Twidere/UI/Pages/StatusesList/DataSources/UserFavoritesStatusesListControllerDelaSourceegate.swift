//
//  UserFavoritesStatusesListControllerDelegate.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/20.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import PromiseKit

class UserFavoritesStatusesListControllerDataSource: SingleAccountStatusesListControllerDataSource {
    
    var userKey: UserKey?
    var screenName: String?
    
    init(account: Account, userKey: UserKey?, screenName: String?) {
        self.userKey = userKey
        self.screenName = screenName
        super.init(account: account)
    }
    
    override func getStatusesRequest(microBlog: MicroBlogService, paging: Paging) -> Promise<[Status]> {
        if let userKey = self.userKey {
            return microBlog.getFavorites(id: userKey.id, paging: paging)
        } else if let screenName = self.screenName {
            return microBlog.getFavorites(screenName: screenName, paging: paging)
        }
        return Promise(error: MicroBlogError.argumentError(message: "Invalid parameter"))
    }
}
