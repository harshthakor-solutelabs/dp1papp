import 'package:dp2papp/bloc/event_listner/connection_event_listner.dart';
import 'package:flutter_deriv_api/services/connection/connection_service.dart';
import 'package:flutter_deriv_api/state/connection/connection_cubit.dart';
import 'package:flutter_deriv_bloc_manager/base_state_emitter.dart';
import 'package:flutter_deriv_bloc_manager/bloc_managers/base_bloc_manager.dart';

import '../../enums.dart';

class ConnectionStateEmitter extends BaseStateEmitter<ConnectionEventListener,ConnectionCubit>{

  ConnectionStateEmitter(BaseBlocManager blocManager) : super(blocManager);

  @override
  void handleStates({required ConnectionEventListener eventListener, required Object state}) {
    if (state is ConnectionConnectedState) {
      eventListener.onConnected();
    } else if (state is ConnectionDisconnectedState) {
      ConnectionService().isConnectedToInternet.then(
            (bool isConnectedToInternet) => eventListener.onDisconnect(
          isConnectedToInternet
              ? DisconnectSource.websocket
              : DisconnectSource.internet,
        ),
      );
    } else if (state is ConnectionErrorState) {
      eventListener.onConnectionError(state.error);
    }
  }

}