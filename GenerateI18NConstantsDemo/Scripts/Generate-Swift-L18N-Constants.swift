#!/usr/bin/env xcrun swift

import Foundation

// Input and Output
var inputPath: String?
var outputPath: String?
var templatePath: String?

// Process the arguments
print("Process.arguments gave args:")
guard Process.arguments.count == 4 else {
	fatalError("We should have 3 arguments into the script")
}
//for arg in Process.arguments {
//	print("Arg: \(arg)")
//}
//print("Arg count is \(Process.arguments.count) ")

inputPath = Process.arguments[1]
templatePath = Process.arguments[2]
outputPath = Process.arguments[3]

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

func camelCase(key: String) -> String
{
	let words = key.componentsSeparatedByString(".")
	let camelCase = words.map({$0.capitalizedString})
	
	return camelCase.joinWithSeparator("")
}

let caseStatements = buildCaseStatements()
print("\(caseStatements)")

func caseDeclarations() -> String {
	var outputString = ""
	for caseStatement in caseStatements {
		outputString += caseStatement.casename
	}
	return outputString
}

func caseDescriptions() -> String {
	var outputString = ""
	for caseStatement in caseStatements {
		outputString += caseStatement.description
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
		templateString = templateString.stringByReplacingOccurrencesOfString("// %CASE_DECLARATIONS%", withString: caseDeclarations())
		
		templateString = templateString.stringByReplacingOccurrencesOfString("// %CASE_DESCRIPTIONS%", withString: caseDescriptions())

		if let data = templateString.dataUsingEncoding(NSUTF8StringEncoding) {
			data.writeToFile(outputPath, atomically: true)
		}
		
	}
}

writeOutputToFile()