# GenerateI18NConstants    
Script, written in Swift 2.0, which generates a constants file to enable compile time checking and a more Swift way of localizing strings.

#### Also available: [Fonts](https://github.com/4eleven7/GenerateFontConstants)

## What it does
👍 Requires no changes to your existing Localizable.strings.    
👏 Generates a Swift enum of your string keys.    
✊ Allows compile time checking of your strings.    
🙏 More Swifty syntax. `Localized.AppTesting` instead of `NSLocalizedString("app.testing", "app testing")`.    
💪 Allows parameters using the `.with(...)` method.    

## What it doesn't do
❌ Run [genstrings](https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man1/genstrings.1.html).    
🚫 Allow language switching via code (still have to change languages in Settings.app).   
❗️ Currently doesn't support 'Localizable.stringsdict'

### Usage
Returns a localized version of the string.   
``Localized.DemoTesting``

Returns a localized version of the string, with the parameter 'Dan'.   
``Localized.DemoWelcomeMessage.with("Dan")``

Use the built in localisation methods, but with a compile time checked identifier.
``NSLocalizedString(Localized.DemoGoodbyeMessage.key, comment: "Cya!")``

### Installation
* Open your project, select your **Target** and select **Build Phases**
* Add a new **Run Script Phase**. Maybe name it something like "Generate Localization"
* Copy and paste the build script below into the your new build phase.
* Add your Localizable.strings (or Base.lproj/Localizable.strings if you're localized) to the **Input Files** section of the build phase script. Example: `$(SRCROOT)/${TARGETNAME}/Base.lproj/Localizable.strings`
* Add the Templates/LocalizedTemplate.swift to the **Input Files** section of the build phase script. Example: `$(SRCROOT)/../Scripts/Templates/LocalizedTemplate.swift`
* Add Localized.swift to the **Output Files** for where your constants will be generated. Example: `$(SRCROOT)/${TARGETNAME}/Classes/Constants/Localized.swift`
* Build your project.

Note: The order of your input files does not matter. Just ensure that the template has the word 'template' in its filename. And you maintain the file extensions (.strings, .swift).

### Build Script
````
SCRIPT_FILE="${SRCROOT}/Scripts/Generate-Swift-L18N-Constants.swift"
echo "Running a custom build phase script: $SCRIPT_FILE"

${SCRIPT_FILE} "${SCRIPT_INPUT_FILE_0}" "${SCRIPT_INPUT_FILE_1}" "${SCRIPT_OUTPUT_FILE_0}"
echo "End of script"

scriptExitStatus=$?
echo "DONE with script: ${SCRIPT_FILE} (exitStatus=${scriptExitStatus})\n\n"
exit "${scriptExitStatus}"
````

### Authors
[David Casserly](https://github.com/devedup) - [@devedup](https://twitter.com/devedup)    
[Daniel Love](https://github.com/4eleven7) - [@4eleven7](https://twitter.com/4eleven7)

### Contribute
1. Fork
1. Create your feature branch (git checkout -b my-new-feature)
1. Commit your changes (git commit -am 'Add some feature')
1. Push to the branch (git push origin my-new-feature)
1. Create new Pull Request

### License
GenerateI18NConstants is available under the MIT license. See the LICENSE file for more info.
