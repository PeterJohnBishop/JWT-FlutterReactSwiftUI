import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'Api.dart';

class SocketService {
  static IO.Socket socket =
      IO.io('${Api.baseUrl}:4001', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': true,
  });


}


  