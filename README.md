# Countries_SwiftUI
<body>
  <div align="center">
    <img src="https://img.shields.io/static/v1?label=XCode%20Version&message=13.4.1&color=brightgreen&logo=xcode" alt="Xcode version 13">
    <img src="https://img.shields.io/static/v1?label=Swift%20Version&message=5.6&color=brightgreen&logo=swift" alt="Swift Version 5.5">
    <img src="https://img.shields.io/static/v1?label=Framework&message=SwiftUI&color=brightgreen&logo=Swift&logoColor=blue">
  </div>
  <p>This is a sample Project for fetching data from <a href="https://restcountries.com">RestCountries API</a> in Swift &amp; SwiftUI</p>
  <ul>
    <li>This Application is full written in Swift.</li>
    <li>UI has been implemented implemented with SwiftUI.</li>
    <li>Images are downloaded with caching using the new SwiftUI <a href="https://developer.apple.com/documentation/SwiftUI/AsyncImage">AsyncImage</a> view.</li>
    <li>The http client for API requests leverage the latest <a href="https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html">Swift Concurrency Features</a> (Async-Await/Actors) because of that, all async methods can potentially been suspended awaiting results, this implies better reading and reasoning compared to the traditional callbacks.</li>
    <li>CountryManager is marked with @MainActor this ensure that every model updated runs on the main actor (insted of using DispatchQueue every time) this is mandatory for UI.
    <li>Network Service in this case is an actor only because we want its work to be done on a different thread instead of using Task.Detached which is not recommended according to the docs.</li>
  </ul>
</body>
