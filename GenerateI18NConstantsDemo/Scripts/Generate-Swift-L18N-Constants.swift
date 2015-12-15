#!/usr/bin/env xcrun swift

import Foundation

// Input and Output
var inputPath: String?
var outputPath: String?

// Process the arguments
print("Process.arguments gave args:")
guard Process.arguments.count == 3 else {
	fatalError()
}
inputPath = Process.arguments[1]
outputPath = Process.arguments[2]

// Read the strings file
guard let localizedInputPath = inputPath else {
	fatalError()
}
if let stringsData = NSData(contentsOfFile: localizedInputPath) {
	var datastring = NSString(data:stringsData, encoding:NSUTF8StringEncoding) as String?
	print("Strings data \(datastring)")
}





