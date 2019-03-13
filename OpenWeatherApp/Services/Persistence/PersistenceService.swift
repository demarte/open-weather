//
//  PersistenceService.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 3/5/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation
import CoreData

final class PersistenceService: PersistenceServiceType {
  private var persistenceProvider: PersistenceProviderType

  init(persistenceProvider: PersistenceProviderType = PersistenceProvider()) {
    self.persistenceProvider = persistenceProvider
  }

  func fetch<T: NSManagedObject>(_ objectType: T.Type) -> Result<[T]> {
    return persistenceProvider.fetch(objectType)
  }

  func delete<T: NSManagedObject>(_ object: T) throws {
    do {
      try persistenceProvider.delete(object)
    } catch {
      throw error
    }
  }

  func saveContext() throws {
    do {
      try persistenceProvider.saveContext()
    } catch {
      throw error
    }
  }
}
