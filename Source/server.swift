import UDP


public class OSCServer: MessageDispatcher {
  public typealias Message = OSCMessage

  let socket: UDPSocket
  let dispatcher = OSCMessageDispatcher

  public init(port: Int) throws {
    socket = try UDPSocket(ip: IP(port: port))
  }

  // override
  public func register(pattern: String, _ listener: @escaping (OSCMessage) -> Void) {
    dispatcher.register(pattern: pattern, listener)
  }

  // override
  public func unregister(pattern: String) {
    dispatcher.unregister(pattern: pattern)
  }

  // override
  public func dispatch(message: OSCMessage) {
    dispatcher.dispatch(message: message)
  }

  public func listen() {
    while true {
      do {
        let (buffer, _) = try socket.read(upTo: 1536, deadline: .never)

        /// FIXME global parser
        if let msg = OSCMessage(data: buffer.bytes ) {
          /// might crash during dispatch if message is garbled
          dispatcher.dispatch(message: msg)
        }
      } catch {
        print("Failed to read message \(error)")
        break
      }
    }
  }
}
