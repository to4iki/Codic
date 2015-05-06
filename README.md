Codic
=====

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)][carthage]
[![CocoaPods version](https://img.shields.io/cocoapods/v/Codic.svg?style=flat)][cocoapods]
[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)][license]
[![Platform](https://img.shields.io/cocoapods/p/Codic.svg?style=flat)][platform]

[carthage]: https://github.com/Carthage/Carthage
[cocoapods]: http://cocoadocs.org/docsets/Codic
[license]: https://github.com/to4iki/Codic/master/LICENSE
[platform]: http://cocoadocs.org/docsets/Codic

[API Reference - codic](https://next.codic.jp/docs/api).

## Description
codic API v1 client for Swift.

## Requirements

- Built for Swift 1.2
- Runs on iOS 8 / OS X 10.10 and above

## Usage

```swift
let client = Codic.Client(accessKey: "your api access_key")

let request = client.getItems(parameters: parameters)
let request = client.lookup("term")
request.onComplete(
    resolve: {
      // success handler
    },
    reject: {
      // failure handler
    }
)
request.resume()
```

## Installation
### [CocoaPods](http://cocoapods.org/)
Version 0.36 or higher is required. Add the following to your [Podfile](http://guides.cocoapods.org/using/the-podfile.html):

```rb
pod 'Codic'
```

Make sure that you are integrating your dependencies using frameworks: add `use_frameworks!` to your Podfile. Then run `pod install`.

### [Carthage](https://github.com/Carthage/Carthage)
Add the following to your [Cartfile](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#cartfile):

```
github "to4iki/Codic"
```

Run `carthage update` and follow the steps as described in Carthage's [README](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application).

## Documentation
- API documentation is available at the wonderful [cocoadocs.org](http://cocoadocs.org/docsets/Codic)
- This README covers almost all features of Codic
- The [tests](CodicTests) contain (trivial) usage examples for every feature

## TODO

Error JSON mapping([エラー](https://next.codic.jp/docs/api))

## Licence

[MIT](https://github.com/to4iki/Codic/master/LICENSE)

## Author

[to4iki](https://github.com/to4iki)
