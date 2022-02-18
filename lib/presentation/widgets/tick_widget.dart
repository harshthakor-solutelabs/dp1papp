import 'package:dp2papp/presentation/states/tick_subs/tick_cub_state.dart';
import 'package:dp2papp/presentation/states/tick_subs/tick_subs_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_api/api/common/tick/tick.dart';
import 'package:flutter_deriv_bloc_manager/bloc_managers/bloc_manager.dart';

class TickWidget extends StatefulWidget {
  const TickWidget({Key? key}) : super(key: key);

  @override
  _TickWidgetState createState() => _TickWidgetState();
}

class _TickWidgetState extends State<TickWidget> {

  late final TickSubsCubit _tickSubsCubit;

  @override
  void initState() {
    _tickSubsCubit = BlocManager.instance.fetch<TickSubsCubit>();
    super.initState();
  }

  @override
  void dispose() {
    BlocManager.instance.dispose<TickSubsCubit>();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) => BlocBuilder<TickSubsCubit, TickSubState>(
    bloc: _tickSubsCubit,
    key: const Key('selected_symbol_tick'),
    builder: (BuildContext context, TickSubState state) {
      if (state is TicksLoaded) {
        Tick? tick = state.tick;
        return Column(
          key: const Key('detail_column'),
          children: [
            const SizedBox(height: 10),
            Text(
              "Symbol : ${tick?.symbol}",
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Text(
              "Price : ${tick?.quote}",
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
          ],
        );
      } else if (state is TicksError) {
        return const Text('Market is Closed');
      } else {
        return const Text('Loading..');
      }
    },
  );
}
