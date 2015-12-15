# GenerateI18NConstants
Script, written in Swift, which generates a constants file to enable compile time checking and a more Swift way of localizing strings.

## What it does
* Generates a Swift enum of your string keys
* Allows compile time checking of your strings
* More concise API call
* Allows parameters using the `.with(...)` method

## What it doesn't do
* Allow language switching
* Run [genstrings](https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man1/genstrings.1.html)

## Usage

Returns a localized version of the string.   
``Localized.AppTesting``

Returns a localized version of the string, with the parameter 'Dan'.   
``Localized.AppWelcomeMessage.with("Dan")``
