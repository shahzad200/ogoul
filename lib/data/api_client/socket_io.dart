
import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketServer{

 static late String url;
  // 'https://mcu.mizdah.com:9000?user_id=422&session_id=7867';
  //     'https://nodeapi.ogoullms.com/socket.io/socket.io/?user_id=';

  static late IO.Socket socket;


     static connectSocket(String s) {
       url = 'https://nodeapi.ogoullms.com/?user_id='+s;
    log('socket url: $url');
    // socket = IO.io('https://nodeapi.ogoullms.com/socket.io/?user_id=683&EIO=3&transport=polling');
       socket = IO.io( url);
    log('going to connect');
    //socket.connect();

    log('result: ${socket.connected}');
    if(!socket.connected){
      socket.onConnect((data) {
        log('connect=======>');
        log('result: ${socket.connected}');
      });
    }
       socket.onConnect((data) {
         log('result: ${'CONNECTED'}');
       });
    socket.onDisconnect((data) => log('disconnected.......'));
    socket.onReconnect((data) {

    });
  }


}