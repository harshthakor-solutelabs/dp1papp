import 'package:flutter_deriv_bloc_manager/base_event_listener.dart';

import '../../enums.dart';


abstract class ConnectionEventListener implements BaseEventListener {

  void onConnected();

  void onDisconnect(DisconnectSource source);

  void onConnectionError(String error);
}