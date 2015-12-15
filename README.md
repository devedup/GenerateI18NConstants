# GenerateI18NConstants
Script, written in Swift 2.0, which generates a constants file to enable compile time checking and a more Swift way of localizing strings.

## What it does
👍 Keep the Localizable.strings file your app already uses.    
👏 Generates a Swift enum of your string keys.    
✊ Allows compile time checking of your strings.    
🙏 More Swifty syntax. `Localized.AppTesting` instead of `NSLocalizedString("app.testing", "app testing")`.    
💪 Allows parameters using the `.with(...)` method.    

## What it doesn't do
❌ Run [genstrings](https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man1/genstrings.1.html).    
🚫 Allow language switching.

## Usage

Returns a localized version of the string.   
``Localized.AppTesting``

Returns a localized version of the string, with the parameter 'Dan'.   
``Localized.AppWelcomeMessage.with("Dan")``

## Installation
* Add a run script in 'Build Phases' to the target that executes the script below.
* Add the Localizable.strings (or Base.lproj/Localizable.strings if you're localized) to the input files section of the build phase script.
* Add the Templates/LocalizedTemplate.swift to the input files section of the build phase script.
* Add Localized.swift to the output file location for where your constants will be generated.
* Build your project.


## Build Script
````
SCRIPT_FILE="${SRCROOT}/Scripts/Generate-Swift-L18N-Constants.swift"
echo "Running a custom build phase script: $SCRIPT_FILE"

${SCRIPT_FILE} "${SCRIPT_INPUT_FILE_0}" "${SCRIPT_INPUT_FILE_1}" "${SCRIPT_OUTPUT_FILE_0}"
echo "End of script"

#"${SCRIPT_OUTPUT_FILE_0}" "${SCRIPT_OUTPUT_FILE_1}"
scriptExitStatus=$?
echo "DONE with script: ${SCRIPT_FILE} (exitStatus=${scriptExitStatus})\n\n"
exit "${scriptExitStatus}"
````

### Authors
[David Casserly](https://github.com/devedup)    
[Daniel Love](https://github.com/4eleven7)

### Contribute
* Fork
* Create your feature branch (git checkout -b my-new-feature)
* Commit your changes (git commit -am 'Add some feature')
* Push to the branch (git push origin my-new-feature)
* Create new Pull Request
