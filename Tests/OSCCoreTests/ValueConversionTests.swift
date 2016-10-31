@testable import OSCCore
import XCTest

class ValueConversionTests : XCTestCase {

    func testEmptyStringConversion() {
        // test value
        let str = ""
        // expected packet
        let packet : [Byte] = [0x00, 0x00, 0x00, 0x00]

        let value = str.oscValue

        XCTAssertNotNil(value, "Null value")
        XCTAssertEqual(value.count%4, 0, "Lenght must be divided by 4")
        XCTAssertEqual(value, packet, "Incorrect OSC Packet")
        XCTAssertEqual(str, String(data: packet), "Failed to convert OSC packet back to String value")
    }


    func testBasicStringConversion() {
        // test value
        let str = "hello"
        // expected packet
        let packet : [Byte] = [0x68, 0x65, 0x6c, 0x6c, 0x6f, 0x00, 0x00, 0x00]   

        let value = str.oscValue

        XCTAssertNotNil(value, "Null value")
        XCTAssertEqual(value.count%4, 0, "Lenght must be divided by 4")
        XCTAssertEqual(value, packet, "Incorrect OSC Packet")
        XCTAssertEqual(str, String(data: packet), "Failed to convert OSC packet back to String value")
    }


    func testInt32Conversion() {
        let value : Int32 = 0x12345678
        let pkt = value.oscValue
        XCTAssertEqual(pkt, [0x12, 0x34, 0x56, 0x78])
        XCTAssertEqual(value, Int32(data: pkt), "Value mismatch") 
    }


    func testInt64Conversion() {
        let value : Int64 = 0x123456789abcdef0
        let pkt = value.oscValue
        XCTAssertEqual(pkt, [0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc, 0xde, 0xf0])
        XCTAssertEqual(value, Int64(data: pkt), "Value mismatch")
    }


    func testIntConversion() {
        let value : Int = 0x12345678
        let pkt = value.oscValue
        XCTAssertEqual(pkt, [0x12, 0x34, 0x56, 0x78])
        XCTAssertEqual(value, Int(data: pkt), "Value mismatch")
    }


    func testFloat32Conversion() {
        let value : Float32 = Float32(1.234)
        let pkt = value.oscValue
        XCTAssertEqual(pkt, [0x3f, 0x9d, 0xf3, 0xb6])
        XCTAssertEqual(value, Float32(data: pkt), "Value mismatch")
    }


    func testTimeTagConversion() {
        let value = OSCTimeTag(timetag: TimeTag(integer: 0x78563412, fraction: 0xf0debc9a))
        let pkt = value.oscValue
        XCTAssertEqual(value.timetag.immediate, false)
        XCTAssertEqual(pkt, [0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc, 0xde, 0xf0])
        XCTAssertEqual(value, OSCTimeTag(data: pkt), "Value mismatch")
    }
}

#if os(Linux)
extension ValueConversionTests {
    static var allTests: [(String, (ValueConversionTests) -> () throws -> Void)] {
        return [
            ("testEmptyStringConversion", testEmptyStringConversion),
            ("testBasicStringConversion", testBasicStringConversion),
            ("testInt32Conversion", testInt32Conversion),
            ("testInt64Conversion", testInt64Conversion),
            ("testIntConversion", testIntConversion),
            ("testFloat32Conversion", testFloat32Conversion),
            ("testTimeTagConversion", testTimeTagConversion)
        ]
    }
}
#endif

