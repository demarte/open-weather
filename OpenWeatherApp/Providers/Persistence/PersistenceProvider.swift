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
      // TODO: - Tratar o erro
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()

  // MARK: - fetch

  func fetch<T: NSManagedObject>(_ objectType: T.Type) -> [T]? {
    let entityName = String(describing: objectType)
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    do {
      let fetchedObjects = try context.fetch(fetchRequest) as? [T]
      return fetchedObjects
    } catch {
      // TODO: - tratar o erro
      let nserror = error as NSError
      fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
    }
  }

  // MARK: - delete

  func delete<T: NSManagedObject>(_ object: T) {
    context.delete(object)
    saveContext()
  }

  // MARK: - Core Data save

  func saveContext() {
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        // TODO: - tratar o erro
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
}
