//
//  City+CoreDataProperties.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 3/5/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//
//

import Foundation
import CoreData

extension CityTest {

  @NSManaged public var name: String

  @nonobjc public class func fetchRequest() -> NSFetchRequest<CityTest> {
    return NSFetchRequest<CityTest>(entityName: "City")
  }
}
