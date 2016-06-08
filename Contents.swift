//: Playground - noun: a place where people can play

import UIKit
import XCPlayground


import Foundation

//let addr = "192.9.200.125"
let addr = "localhost"
let port = 50000

var buffer = [UInt8](count: 255, repeatedValue: 0)

var inp : NSInputStream?
var out : NSOutputStream?

NSStream.getStreamsToHostWithName(addr, port: port, inputStream: &inp, outputStream: &out)

if inp != nil && out != nil {
    let inputStream : NSInputStream = inp!
    let outputStream : NSOutputStream = out!
    inputStream.open()
    outputStream.open()

    if outputStream.streamError == nil && inputStream.streamError == nil {
        let queryString: String = ">"
        let queryData: NSData = queryString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
        while true {
//            outputStream.write(UnsafePointer(queryData.bytes),maxLength:queryData.length)
            var readChars: Int = inputStream.read(&buffer, maxLength: buffer.count)
            print(readChars)
            if (readChars > 0) {
                let readString: String = NSString(data: NSData(bytes:buffer, length:readChars), encoding: NSUTF8StringEncoding)! as String
                print(readString)
            } else {
                print ("server closed connection")
                inputStream.close()
                outputStream.close()
                break
            }
        }
    } else {
        print ("could not create socket")
    }
} else {
    print ("could not initialize stream")
}
