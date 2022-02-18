import 'package:dp2papp/bloc/event_listner/selected_symbol_event_listner.dart';
import 'package:dp2papp/presentation/states/tick_subs/tick_cub_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_api/api/common/active_symbols/active_symbols.dart';
import 'package:flutter_deriv_api/api/common/forget/forget_all.dart';
import 'package:flutter_deriv_api/api/common/tick/tick.dart';
import 'package:flutter_deriv_api/basic_api/generated/api.dart';

class TickSubsCubit extends Cubit<TickSubState>
    implements SelectedSymbolEventListner {
  TickSubsCubit() : super(TicksLoading());

  Future<void> subscribeTicks({required ActiveSymbol selectedSymbol}) async {
    try {
      emit(TicksLoading());

      await _unsubscribeTick();

      _subscribeTick(selectedSymbol).listen((Tick? tick) {
        emit(TicksLoaded(tick: tick));
      });
    } on Exception catch (e) {
      emit(TicksError('$e'));
    }
  }

  Stream<Tick?> _subscribeTick(ActiveSymbol? selectedSymbol) =>
      Tick.subscribeTick(
        TicksRequest(ticks: selectedSymbol?.symbol),
      );

  Future<ForgetAll> _unsubscribeTick() => Tick.unsubscribeAllTicks();

  @override
  Future<void> close() async {
    await _unsubscribeTick();
    await super.close();
  }

  @override
  void onSelectedSymbol(ActiveSymbol activeSymbol) {
    subscribeTicks(selectedSymbol: activeSymbol);
  }
}
