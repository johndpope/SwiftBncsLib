import XCTest
@testable import SwiftBncsLib

class CdKeyDecodeTests: XCTestCase {

    typealias TestCase = (
        key: String,
        product: UInt32,
        value1: UInt32,
        value2: [UInt8],
        clientToken: UInt32,
        serverToken: UInt32,
        hash: [UInt8]
    )

    func test() {
        var testCases = [TestCase]()
        testCases.append((
            key: "YKY7EPR664G6DWG7CV8REKVEGK",
            product: 0x0E,
            value1: 0x005A8478,
            value2: [0x52, 0x15, 0x16, 0x88, 0xC6, 0x78, 0x90, 0x49, 0x6D, 0x5F],
            clientToken: 1234,
            serverToken: 5678,
            hash: [0x8B, 0x86, 0x44, 0x84, 0x00, 0xFD, 0x2F, 0xC0, 0x03, 0x7F, 0xDD, 0xE2, 0x4F, 0xEB, 0x34, 0xFC, 0xCD, 0x3A, 0x56, 0x79]
        ))
        testCases.append((
            key: "ZJEMBXPXZ4NFJDRTK2E2899RH9",
            product: 0x0E,
            value1: 0x000F298C,
            value2: [0xFC, 0x7F, 0xE8, 0xD0, 0x72, 0x37, 0x39, 0xAC, 0xC8, 0x53],
            clientToken: 1234,
            serverToken: 5678,
            hash: [0xB7, 0x30, 0x42, 0xE1, 0xA7, 0xD1, 0xAB, 0x7C, 0x5C, 0x02, 0x71, 0x87, 0x5B, 0x79, 0x23, 0x64, 0xF3, 0x64, 0xF7, 0xA8]
        ))

        for tc in testCases {
            let x = CdKeyDecode(cdkey: tc.key)
            XCTAssertEqual(x.productValue, tc.product)
            XCTAssertEqual(x.value1, tc.value1)
            XCTAssertEqual(x.value2, tc.value2)

            let hash = x.hashForAuthCheck(clientToken: tc.clientToken, serverToken: tc.serverToken)
//            print(hash.hexDescription)
            XCTAssertEqual(hash, Data(tc.hash))
        }

    }

}
