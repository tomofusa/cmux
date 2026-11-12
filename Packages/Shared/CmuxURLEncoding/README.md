# CmuxURLEncoding

URL text encoding shared by the macOS and iOS apps. It has no dependencies.

`URL(string:)` and `URLComponents(string:)` (swift-foundation, macOS 15+ and
iOS 18+) percent-encode a component that holds characters a URL can't carry,
such as raw Unicode. They treat the whole component as unencoded text, so an
escape already in it is encoded again: `会議_2026%2F11` loads as
`…_2026%252F11` (manaflow-ai/cmux#40300).

`URLEscapePreservingEncoder` encodes those characters first, the way a browser
does, and keeps valid `%XX` escapes. Foundation then finds nothing left to
encode. Parse user or terminal URL text through it:

```swift
import CmuxURLEncoding

let url = URL(string: URLEscapePreservingEncoder().encode(text))
let components = URLComponents(string: URLEscapePreservingEncoder().encode(text))
```

All-ASCII text comes back unchanged. The authority is left as written, so
Foundation still converts an internationalized host to its IDNA form.

Consumers: the macOS omnibar (`CmuxBrowser`), the macOS terminal link router
(`CmuxTerminalCore`) and the iOS address bar (`CmuxMobileBrowser`).

## Tests

The encoder is a value type with no state or I/O. Tests construct it directly:

```swift
@testable import CmuxURLEncoding

let encoder = URLEscapePreservingEncoder()
#expect(encoder.encode("https://example.com/メモ%2F") == "https://example.com/%E3%83%A1%E3%83%A2%2F")
```

```bash
swift test --package-path Packages/Shared/CmuxURLEncoding
```
