# rethought
Rethought is an application designed to help keep track of your thoughts, and continue those thoughts.  Adding entries for images, text, links,  and audio recordings (more in the works!).  Written in Swift, rethought takes advantage of a few cocoa pods, and the MVVM application structure. 


> Rethought uses MVVM, and core data to present thoughts.  Thought entities have a subentity called Entry, that can be text, an image, a link or an audio recording.  

## Instilation requirements 
> Requirements:  [cocoapods](https://cocoapods.org) and [xcode](https://apple.com/developer)
* Clone repo
* cd into the directory you saved the project
* run `pod install` to install dependancies 
* open the .xcworkspace file, NOT the .xcodeproj file

## usage 
* /Resources - All fonts, and images
* /Replicator - When a user opens the app for the first time, load a few thoughts into core data
* /Core - Thought, Entry, Persistant service, and several mutations of data types. 
  * /DataModel - All core data objects + helper functions
* /Objects - ThoughtCard, EmojiDisplay, EntryBar, ReText and ReTextField, NewEntryButton, EntryCountView
* /ViewModel
  * /Dashboard - Connect to Core data to mutate objects into DashboardThoughts, retrieve specific thoughts and Entries, and save them
  * /ThoughtDetail - Handles injection, editing, deletion, addition of new entries and updating for a single thought
* Helpers - Application constants(sizing, fonts, colors), styling assistants
* Extensions - Apples UIKit object conveniance extensions
* /ViewController - All views and controllers programmatically laid out
  * /Root = Views, controller and delegate for rootView
  * /createEntry - Views and controllers to create Text, Image, Link, and Audio Entries
  * /Dashboard - View, Controller, and Delegate for The main Homepage of rethought
  * /Thought - View, Controller, and Delegate for display of thoughts and related thoughts
  * /Entry - View, Controller, and Delegate for display of individual Entries
  * /Cell - UICollectionViewCell's, UITableViewCell's, and UICollectionView supplimentary views
  

## Road map: 
- [ ] UIColor protocol for users to customize colors in application
- [ ] Rethought needs a backend! Currently all data is stored locally. 
- [ ] Share extension.  Let users save links from within other applications like safari
- [ ] Thought card refactoring.  The thoughtcard object can be moved to a cocoapod (possibly)

## Contributing
> If you're looking to contribute to rethought, please take a look at the roadmap to see how you can help!

Happy thinking! 

![Image of app - 2](https://s3-us-west-2.amazonaws.com/gifton/rethoughtImage2.png)
![Image of app](https://s3-us-west-2.amazonaws.com/gifton/rethoughtImage1.png)

