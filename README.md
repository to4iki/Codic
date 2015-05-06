Codic
=====

[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)][license]

[license]: https://github.com/to4iki/Codic/master/LICENSE

[API Reference - codic](https://next.codic.jp/docs/api).

## Description
codic API v1 client for Swift.

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

### Codic.Client
- `translate(text: String, dictionaryId: String, casing: Codic.Casing? = nil, acronymStyle: Codic.AcronymStyle? = nil, decoding: Bool = true) -> Request<Codic.Translation>`
- `fetchUserDictionaries() -> Request<[Codic.UserDictionary]>`
- `fetchUserDictionary(id: Int) -> Request<Codic.UserDictionary>`
- `lookup(query: String, count: Int = Codic.Client.defaultLookupCount) -> Request<[Codic.CodicEnglishDictionary.HeadWord]>`
- `fetchCEDEntry(id: Int) -> Request<Codic.CodicEnglishDictionary.Entry>`

## Installation

## Licence

[MIT](https://github.com/to4iki/Codic/master/LICENSE)

## Author

[to4iki](https://github.com/to4iki)
