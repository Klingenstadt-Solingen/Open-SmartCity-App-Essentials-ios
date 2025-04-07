fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios signing

```sh
[bundle exec] fastlane ios signing
```

before all

before each lane

after each lane

error

Sync signing

### ios build

```sh
[bundle exec] fastlane ios build
```

Build binary

### ios export

```sh
[bundle exec] fastlane ios export
```

export module in a xcframework

### ios test

```sh
[bundle exec] fastlane ios test
```

Run UNIT Tests

### ios beta_for_internal_tester

```sh
[bundle exec] fastlane ios beta_for_internal_tester
```

Release to Testflight Internal Tester

### ios beta_for_external_tester

```sh
[bundle exec] fastlane ios beta_for_external_tester
```

Release to Testflight External Tester

### ios release

```sh
[bundle exec] fastlane ios release
```

Release binary

### ios development

```sh
[bundle exec] fastlane ios development
```

Gets dev certs

### ios spm_build

```sh
[bundle exec] fastlane ios spm_build
```

build Swift Package

### ios xcode_build

```sh
[bundle exec] fastlane ios xcode_build
```

xcode build

### ios screenshots

```sh
[bundle exec] fastlane ios screenshots
```

capture screen shots

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
