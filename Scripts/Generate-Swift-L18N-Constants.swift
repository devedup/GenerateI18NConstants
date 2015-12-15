#!/usr/bin/env xcrun swift

import Foundation

let DECLARATIONS = "// %CASE_DECLARATIONS%"
let DESCRIPTIONS = "// %CASE_DESCRIPTIONS%"

// Input and Output
var inputPath: String?
var outputPath: String?
var templatePath: String?

// Process the arguments
print("Process.arguments gave args:")
guard Process.arguments.count == 4 else {
	fatalError("We should have 3 arguments into the script")
}

// Arguments
func parseArguments(arguments: [String]) {
	for argument in arguments {
		if argument.lowercaseString.rangeOfString("template") != nil {
			templatePath = argument
		}
		else if argument.rangeOfString(".strings") != nil {
			inputPath = argument
		}
		else if argument.rangeOfString(".swift") != nil {
			outputPath = argument
		}
	}
}

// First argument is always the current script, discard it
var arguments = Process.arguments
arguments.removeAtIndex(0)
parseArguments(arguments)

guard inputPath != nil else {
	fatalError("Please supply string input path")
}

guard outputPath != nil else {
	fatalError("Please supply Localize swift file output path")
}

guard templatePath != nil else {
	fatalError("Please supply template input path")
}

// Read the strings file
var stringsDict: [NSObject: AnyObject]?
guard let localizedInputPath = inputPath else {
	fatalError("We should have the input path of the Localizable.strings")
}
if let localizedData = NSData(contentsOfFile: localizedInputPath),
	let localizedString = NSString(data:localizedData, encoding:NSUTF8StringEncoding) as String?
{
	stringsDict = localizedString.propertyListFromStringsFileFormat()
}

// We now have all the strings in stringsDict
guard let stringsDict = stringsDict else {
	fatalError("We should have a dictionary of strings")
}

// Build case statements
func buildCaseStatements() -> [(casename: String, description: String)] {
	var templateReplacements = [(casename: String, description: String)]()
	for key in stringsDict.keys {
		let camelCaseKey = camelCase(key as! String)
		let casename = "case \(camelCaseKey)\n"
		let description = "case .\(camelCaseKey):\n\t\t\t\t\treturn \"\(key)\""
		templateReplacements += [(casename, description)]
	}
	return templateReplacements
}

func camelCase(key: String) -> String {
	let words = key.componentsSeparatedByString(".")
	let camelCase = words.map({$0.capitalizedString})
	
	return camelCase.joinWithSeparator("")
}

let caseStatements = buildCaseStatements()
print("\(caseStatements)")

func caseDeclarations() -> String {
	var outputString = ""
	for caseStatement in caseStatements
	{
		if outputString == "" {
			outputString = caseStatement.casename
			continue
		}
		
		outputString += "\t\(caseStatement.casename)"
	}
	return outputString
}

func caseDescriptions() -> String {
	var outputString = ""
	for caseStatement in caseStatements
	{
		if outputString == "" {
			outputString = caseStatement.description
			continue
		}
		
		outputString += "\n\t\t\t\(caseStatement.description)"
	}
	return outputString
}

// Write to file
func writeOutputToFile() {
	guard let templatePath = templatePath,
		let outputPath = outputPath else {
		fatalError("We should have the outputPath and templatePath of the Localizable.strings")
	}
	
	if let templateData = NSData(contentsOfFile: templatePath),
		var templateString = NSString(data:templateData, encoding:NSUTF8StringEncoding) as String?
	{
		templateString = templateString.stringByReplacingOccurrencesOfString(DECLARATIONS, withString: caseDeclarations())
		
		templateString = templateString.stringByReplacingOccurrencesOfString(DESCRIPTIONS, withString: caseDescriptions())

		if let data = templateString.dataUsingEncoding(NSUTF8StringEncoding) {
			data.writeToFile(outputPath, atomically: true)
		}
		
	}
}

writeOutputToFile()
