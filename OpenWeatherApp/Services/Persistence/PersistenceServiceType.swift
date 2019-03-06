//
//  PersistenceServiceType.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 3/5/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation
import CoreData

protocol PersistenceServiceType {
  var context: NSManagedObjectContext { get }
  func saveContext()
  func fetch<T: NSManagedObject>(_ objectType: T.Type) -> [T]?
  func delete<T: NSManagedObject>(_ object: T)
}
