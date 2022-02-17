import 'package:flutter_deriv_api/api/common/active_symbols/active_symbols.dart';
import 'package:flutter_deriv_bloc_manager/base_event_listener.dart';

abstract class ActiveSymbolsEventListener implements BaseEventListener {

  void onActiveSymbolsLoaded(final List<ActiveSymbol>? activeSymbols);

  void onActiveSymbolsLoading();

  void onActiveSymbolsError(String error);
}