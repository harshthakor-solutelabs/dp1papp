
import 'package:dp2papp/presentation/states/selected_symbol/selected_symbol_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_api/api/common/active_symbols/active_symbols.dart';
import 'package:flutter_deriv_bloc_manager/bloc_managers/bloc_manager.dart';

import '../states/active_symbol/active_symbol_cubit.dart';
import '../states/active_symbol/active_symbol_state.dart';
import 'dropdown_widget.dart';



class ActiveSymbolsWidget extends StatefulWidget {
  const ActiveSymbolsWidget({
    Key? key,
  }) : super(key: key);



  @override
  _ActiveSymbolsWidgetState createState() => _ActiveSymbolsWidgetState();
}

class _ActiveSymbolsWidgetState extends State<ActiveSymbolsWidget> {
  late final ActiveSymbolCubit _activeSymbolCubit;
  late final SelectedSymbolCubit _selectedSymbolCubit;

  @override
  void initState() {
    _activeSymbolCubit = BlocManager.instance.fetch<ActiveSymbolCubit>();
    _selectedSymbolCubit = BlocManager.instance.fetch<SelectedSymbolCubit>();
    _activeSymbolCubit.fetchActiveSymbols();
    super.initState();
  }

  @override
  void dispose() {
    BlocManager.instance.dispose<ActiveSymbolCubit>();
    BlocManager.instance.dispose<SelectedSymbolCubit>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.all(8),
        child: BlocBuilder<ActiveSymbolCubit, ActiveSymbolState>(
            bloc: _activeSymbolCubit,
            builder: (BuildContext context, ActiveSymbolState state) {
              if (state is ActiveSymbolLoadedState) {
                return Column(
                  key: const Key('active_symbol'),
                  children: <Widget>[
                    DropdownWidget(
                      key: const Key('drop_down'),
                      items: state.activeSymbols,
                      initialItem: state.activeSymbols[0],
                      onItemSelected: (ActiveSymbol item) {
                        print(item.marketDisplayName);
                        _selectedSymbolCubit.selectedSymbol(item);
                      },
                    )
                  ],
                );
              } else if (state is ActiveSymbolErrorState) {
                return Center(child: Text(state.errorMessage));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      );
}
