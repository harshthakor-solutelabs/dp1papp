import 'package:dp2papp/bloc/event_listner/selected_symbol_event_listner.dart';
import 'package:dp2papp/presentation/states/available_contract/available_contract_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_api/api/common/active_symbols/active_symbols.dart';
import 'package:flutter_deriv_api/api/contract/contracts_for/contracts_for_symbol.dart';
import 'package:flutter_deriv_api/basic_api/generated/contracts_for_send.dart';

class AvailableContractCubit extends Cubit<AvailableContractState> implements SelectedSymbolEventListner{
  AvailableContractCubit() : super(AvailableContractLoadingState());

  @override
  void onSelectedSymbol(ActiveSymbol activeSymbol) {
    fetchAvailableContract(selectedSymbol: activeSymbol);
  }

  Future<void> fetchAvailableContract(
      {required ActiveSymbol selectedSymbol,
        bool showLoadingIndicator = true}) async {
    try {
      if (showLoadingIndicator) {
        emit(AvailableContractLoadingState());
      }

      final ContractsForSymbol contracts =
      await _fetchAvailableContracts(selectedSymbol);
      emit(
        AvailableContractLoadedState(contractsForSymbol: contracts),
      );
    } on Exception catch (e) {
      emit(AvailableContractError('$e'));
    }
  }

  Future<ContractsForSymbol> _fetchAvailableContracts(
      ActiveSymbol selectedSymbol,
      ) async {
    return ContractsForSymbol.fetchContractsForSymbol(
      ContractsForRequest(contractsFor: selectedSymbol.symbol),
    );
  }


}