# Custom Keyboard Extension Challenge

Custom Keyboard Extension Challenge demos some SwiftUI (& Combine) concepts. This application is a challenge proposed by [Keys](http://www.thekeysapp.io/) the goal is complete the custom keyboard extensions previously started, using a provided endpoint to load content from API and render it in the keyboard UI  and as well some other requirements.

## Requirements

* iOS 15.4+
* Xcode 13.4.1+

## Getting Started

This repository is divided into two directories, the **Starter** directory where the original project of the challenge is, and in the **Final** directory the version that contains the last changes made by me.

I've gone through the phase where I thought a good programmer is one who writes complex code, imports unnecessary dependencies, uses a framework just because I know how to work with it, without thinking about whether it will be good for the team, if the team will be able to understand the concepts with ease, well this is no longer part of my projects, and that's not what you'll find here.

For me, writing clean, small, light, robust and extremely easy to understand code is what sets us apart and gives a project the possibility to scale to millions of people. In this challenge you will face some good software engineering concepts from my point of view, and see how I like to code. Enjoy it! :blush:


## Architecture

* [Model-View-ViewModel (MVVM)](https://en.wikipedia.org/wiki/Model–view–viewmodel) - Custom Keyboard Extension Challenge uses Model-View-ViewModel (MVVM) as software design pattern, that way this project is structured to separate program logic and user interface controls
* [Combine](https://developer.apple.com/documentation/combine) - Combine framework was choosen because its provides a declarative Swift API for processing values over time, so I can connect the data layer with the view doing the necessary treatments automatically and above all it is a native framework, thus avoiding unnecessary dependencies
* [Dependency Injection](https://en.wikipedia.org/wiki/Dependency_injection) - To improve the reusability of the code, I created the modules using a famous design pattern (Dependency Injection) that makes a class independent of its dependencies. It achieves that by decoupling the usage of an object from its creation. This helps me to follow SOLID’s dependency inversion and single responsibility principles. Using [Factory](https://en.wikipedia.org/wiki/Factory_method_pattern) pattern, I could create my objects without exposing the Dependency Injection logic to the client and refer to newly created object using a common interface.
* [Clean Architecture](https://en.wikipedia.org/wiki/Hexagonal_architecture_(software)) - With clean architecture principle I'm able to create a system that is intrinsically testable, with all the benefits that implies. When any of the external parts of the system become obsolete, like the database, or the web framework, I can replace those obsolete elements with a minimum of fuss.
* [Protocol Oriented Programming](https://medium.com/swlh/introduction-to-protocol-oriented-programming-1ff3862f9a3c) - Unlike with class inheritance, in which the actual properties and methods are implemented, protocols only define requirements. This is still highly beneficial, because it enables me to expressively define types that are certain to have the expected state and behavior. This also aids in unit testing protocol-defined types, e.g., using mock objects that conform to the same protocols. Additionally, protocols can be extended to provide default implementations. This enables me to avoid duplicating code, and it keeps my model definitions flexible to be extended or modified later.
* [Network Layer](https://www.swiftbysundell.com/articles/creating-generic-networking-apis-in-swift/) - Creating abstraction layers helps improve my code drastically by providing three major benefits: centralization, simplicity and better testing. In my code, I want to expose the policy while hiding the detail. This decoupling between my policy and detail allows me to switch and easily refactor implementation, in my code using a Netwok Layer I can achieve the benefits below:
  * View controllers should never know about the networking APIs. They shouldn’t even care whether the data is coming from the API or the local database, e.g. Coredata or SQLite.
  * The only layer that should call the networking API is the service layer.
  * The view controllers should ask the service to provide the data.
  * The service should not know about the API server and the format of the data that is sent or received to or from the API server.
  * Only the network layer should know these details.

## Challenge Requirements

- [x] All of the UI work should be done in SwiftUI. I already setup the initial rendering of our root SwiftUI view in `RootView.swift`. You should be able to implement a typical SwifUI application from there.

You can send a `GET` request to `https://frontend-coding-challenge-api.herokuapp.com/getContent` to fetch the content.
  - [x] Remember to display a loading state while the content is being fetched.
  - [x] The API will randomly (about 1/5 times) return an error with status code `500` and json data `{ error: 'Random Error' }`. Make sure you handle this.

Tapping each button should output its content to the text input (see [resources](#resources) below).
  - [x] When you tap the first time, the app should output the first (`index == 0`) piece of attached content. When you tap the second time, it should output the second piece, etc
  - [x] When you've reached the last piece of content, tapping again should cycle back to the beginning

TIP: inspect the data coming back from the api to figure out the structure of the extra content.
  - [x] Match Apple's keyboard styling as best you can.
  - [x] Make sure to include a button to exit your custom keyboard and take the user back to the default keyboard
  - [ ] Long-press delete functionality that mimics Apple's
  - [x] Long-press on a button show's a popup list with all of the content options.
     * Selecting one should output it to the text input
  - [x] Use some sort of frontend caching/storage to avoid showing a loading state every time the user toggles in and out of the keyboard.

Other fun or useful UI improvements. This is up to you! Some examples:
  - [ ] A moving progress bar on each button that shows how far the user has progressed in the content
  - [ ] Animate the text moving from the button up to the text input
  - [x] Transitions between different states (loading, error, rendering the content)
  - [x] Dark mode

## Where to Go From Here?

Clone this repo and check the final directory with all the implementations we discuss above, you can also check the original challenge requirements below as well the starter project from the start directory.

https://github.com/charmedapp/keysCustomKeyboardChallenge

If you find any mistakes or you can't figure out something, raise a question. I will get back to you asap.
