import Foundation

public extension OutputStream {

    public func write(byte: UInt8) {
        var copy = byte
        write(&copy, maxLength: 1)
    }

    public func write(bytes: [UInt8]) {
        var copy = bytes
        write(&copy, maxLength: bytes.count)
    }

    public func write(data: Foundation.Data) {
        write(bytes: data.arrayOfBytes())
    }

}
