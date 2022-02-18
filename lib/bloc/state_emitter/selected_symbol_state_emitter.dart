import 'package:dp2papp/bloc/event_listner/selected_symbol_event_listner.dart';
import 'package:dp2papp/presentation/states/selected_symbol/selected_symbol_cubit.dart';
import 'package:dp2papp/presentation/states/selected_symbol/selected_symbol_state.dart';
import 'package:flutter_deriv_bloc_manager/base_state_emitter.dart';
import 'package:flutter_deriv_bloc_manager/bloc_managers/base_bloc_manager.dart';

class SelectedSymbolStateEmitter extends BaseStateEmitter<SelectedSymbolEventListner
,SelectedSymbolCubit>{

  SelectedSymbolStateEmitter(BaseBlocManager blocManager) : super(blocManager);

  @override
  void handleStates({required SelectedSymbolEventListner eventListener, required Object state}) {
    if(state is SelectedSymbolChengedState){
      eventListener.onSelectedSymbol(state.seletedSymbol);
    }
  }

}