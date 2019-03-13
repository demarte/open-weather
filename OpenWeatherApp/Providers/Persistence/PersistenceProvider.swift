//
//  PersistenceProvider.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 3/5/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation
import CoreData

final class PersistenceProvider: PersistenceProviderType {
  // MARK: - Core Data context

  lazy var context = persistentContainer.viewContext

  // MARK: - Core Data stack

  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Model")
    container.loadPersistentStores(completionHandler: { (_, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()

  // MARK: - fetch

  func fetch<T: NSManagedObject>(_ objectType: T.Type) -> Result<[T]> {
    let entityName = String(describing: objectType)
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    do {
      if let fetchedObjects = try context.fetch(fetchRequest) as? [T] {
        return Result.success(fetchedObjects)
      } else {
        return Result.failure(PersistenceError.failToFetchData)
      }
    } catch {
      let nserror = error as NSError
      return Result.failure(nserror)
    }
  }

  // MARK: - delete

  func delete<T: NSManagedObject>(_ object: T) throws {
    context.delete(object)
    do {
      try saveContext()
    } catch {
      let nserror = error as NSError
      throw nserror
    }
  }

  // MARK: - Core Data save

  func saveContext() throws {
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        throw nserror
      }
    }
  }
}
