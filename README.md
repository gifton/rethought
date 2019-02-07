# rethought
Rethought is an application designed to help keep track of your thoughts, and continue those thoughts.  Adding entries for images, text, links,  and audio recordings (more in the works!).  Written in Swift, rethought takes advantage of a few cocoa pods, and the MVVM application structure. 


> Rethought uses MVVM, and core data to present thoughts.  Thought entities have a subentity called Entry, that can be text, an image, a link or an audio recording.  

## Instilation requirements 
> Requirements:  [cocoapods](https://cocoapods.org) and [xcode](https://apple.com/developer)
* Clone repo
* cd into the directory you saved the project
* run `pod install` to install dependancies 
* open the .xcworkspace file, NOT the .xcodeproj file

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

