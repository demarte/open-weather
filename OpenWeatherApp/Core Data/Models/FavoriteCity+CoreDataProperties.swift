//
//  FavoriteCity+CoreDataProperties.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 5/14/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//
//

import Foundation
import CoreData

extension FavoriteCity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteCity> {
        return NSFetchRequest<FavoriteCity>(entityName: "FavoriteCity")
    }

    @NSManaged public var name: String
}
