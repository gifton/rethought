import CoreData

// container for loading aplpication into Core data context
func createThoughtContainer(completion: @escaping (NSPersistentContainer) -> Void) {
    let container = NSPersistentContainer(name: "rt-DB2")
    container.loadPersistentStores { (_, error) in
        guard error == nil else { fatalError("failed to load store: \(error!)")}
        DispatchQueue.main.async {
            completion(container)
        }
    }
}
