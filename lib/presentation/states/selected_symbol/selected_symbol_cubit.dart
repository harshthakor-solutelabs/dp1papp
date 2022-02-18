import 'package:dp2papp/bloc/event_listner/active_symbol_event_listner.dart';
import 'package:dp2papp/presentation/states/selected_symbol/selected_symbol_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_api/api/common/active_symbols/active_symbols.dart';

class SelectedSymbolCubit extends Cubit<SelectedSymbolState>
    implements ActiveSymbolsEventListener{

  SelectedSymbolCubit() : super(SelectedSymbolInitState());

  void selectedSymbol(ActiveSymbol activeSymbol){
    emit(SelectedSymbolChengedState(seletedSymbol: activeSymbol));
  }

  @override
  void onActiveSymbolsError(String error) {
    // TODO: implement onActiveSymbolsError
  }

  @override
  void onActiveSymbolsLoaded(List<ActiveSymbol>? activeSymbols) {
    selectedSymbol(activeSymbols![0]);
    // emit(SelectedSymbolChengedState(seletedSymbol: activeSymbols![0]));
  }

  @override
  void onActiveSymbolsLoading() {
    // TODO: implement onActiveSymbolsLoading
  }

}