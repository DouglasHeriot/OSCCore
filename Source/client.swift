import UDP
import struct Foundation.Data

public class UDPClient {

  public let socket : UDPSendingSocket

  public init(socket : UDPSendingSocket) {
    self.socket = socket
  }

  public convenience init?( port : Int, remotePort serverPort : Int) throws {
    guard
      let clientIP = try? IP(port : port),
      let serverIP = try? IP(port : serverPort),
      let sock = try? UDPSocket(ip: clientIP).sending(to: serverIP)
    else {
      return nil
    }

    self.init(socket: sock)
  }
}
