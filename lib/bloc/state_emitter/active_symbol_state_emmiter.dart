import 'package:flutter_deriv_bloc_manager/base_state_emitter.dart';
import 'package:flutter_deriv_bloc_manager/bloc_managers/base_bloc_manager.dart';

import '../../presentation/states/active_symbol/active_symbol_cubit.dart';
import '../../presentation/states/active_symbol/active_symbol_state.dart';
import '../event_listner/active_symbol_event_listner.dart';

/// Active symbols state emitter.
class ActiveSymbolsStateEmitter
    extends BaseStateEmitter<ActiveSymbolsEventListener, ActiveSymbolCubit> {

  /// Initializes Active symbols state emitter.
  ActiveSymbolsStateEmitter(BaseBlocManager blocManager) : super(blocManager);

  @override
  void handleStates({required ActiveSymbolsEventListener eventListener, required Object state}) {
    if (state is ActiveSymbolLoadedState) {
      eventListener.onActiveSymbolsLoaded(state.activeSymbols);
    } else if (state is ActiveSymbolLoadingState) {
      eventListener.onActiveSymbolsLoading();
    } else if (state is ActiveSymbolErrorState) {
      eventListener.onActiveSymbolsError(state.errorMessage.toString());
    }
  }
  
}