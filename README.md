# CBA
### Architecture
we are using `Coordinator + MVVM`, currently there is one coordinator that starts the app and helps the popular view controller to navigate easly (`AppCoordinator`). we are using a custom reactive approach to bind our view models to viewcontrollers, this approach is one night thinking and it defenetly needs some refactors.

### Network
we have a generic service that we use it to talk to server and backend. every requests are async and can be use on reactive way with `asObseravble` and in adition each request can be mockable with `Mockable` protocl, if that so, the service will answer the api call with propesed mock json. all requestes are cachable(if they succeed).
images will be cached as soon as the api is answered and they will be filled from cache after that.

### DataStore
we have two types of data stores to store user's data. Secure and UserDefault which both of them are confomed to `DataStore` protocol. Secure Data Store saves the data in keychain and userDefault store as it's name tells, saves the data in user defaults

### Tests
tests have written.

### Controllers
there are 4 controllers, `WatchList`, `PopularPeople`, `PeopleDetails` and `MovieDetails`. we can add or remove an actor to our favorites from her details view controller, if an actor is favorited, it has a orange border in popular list and also we can add or remove a movie to our WatchList by using it's details view controller and it will have a green border if it is in our watch list. by navigating to our watchlist controller we can see our favorite movies and by `left swiping` we can remove them from our list.

### TODO
i know there are alot of room for improvement and what you are seeing is a 3Day job (because of our release plan i had'nt enough time), some improvements could be in our reactive approach i think.
