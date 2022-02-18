import 'package:dp2papp/bloc/state_emitter/selected_symbol_state_emitter.dart';
import 'package:dp2papp/presentation/screen/splashscreen.dart';
import 'package:dp2papp/presentation/states/active_symbol/active_symbol_cubit.dart';
import 'package:dp2papp/presentation/states/selected_symbol/selected_symbol_cubit.dart';
import 'package:dp2papp/presentation/states/tick_subs/tick_subs_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_api/services/connection/api_manager/connection_information.dart';
import 'package:flutter_deriv_api/state/connection/connection_cubit.dart';
import 'package:flutter_deriv_bloc_manager/bloc_managers/base_bloc_manager.dart';
import 'package:flutter_deriv_bloc_manager/bloc_managers/bloc_manager.dart';
import 'package:flutter_deriv_bloc_manager/bloc_observer.dart';
import 'package:flutter_deriv_bloc_manager/event_dispatcher.dart';

import 'bloc/state_emitter/active_symbol_state_emmiter.dart';
import 'bloc/state_emitter/connection_state_emitter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = CubitObserver();
  registerBlocs();
  initializeEventDispatcher();
  runApp(MyApp());
}
void registerBlocs() {
  BlocManager.instance
    ..register(
      ConnectionCubit(
        ConnectionInformation(
          appId: '1089',
          brand: 'binary',
          endpoint: 'frontend.binaryws.com',
        ),
      ),
    )
    ..register(ActiveSymbolCubit())
    ..register(SelectedSymbolCubit())
    ..register(TickSubsCubit());

}


void initializeEventDispatcher() => EventDispatcher(BlocManager.instance)
  ..register<ConnectionCubit, ConnectionStateEmitter>(
        (BaseBlocManager blocManager) => ConnectionStateEmitter(blocManager),
  )
  ..register<ActiveSymbolCubit, ActiveSymbolsStateEmitter>(
        (BaseBlocManager blocManager) => ActiveSymbolsStateEmitter(blocManager),
  )
  ..register<SelectedSymbolCubit, SelectedSymbolStateEmitter>(
        (BaseBlocManager blocManager) => SelectedSymbolStateEmitter(blocManager),
  );



/// mainApp widget.
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => const MaterialApp(home: SplashScreen());
}