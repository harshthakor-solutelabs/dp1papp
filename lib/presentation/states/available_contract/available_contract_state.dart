import 'package:flutter_deriv_api/api/contract/contracts_for/contracts_for_symbol.dart';

abstract class AvailableContractState {}

class AvailableContractInitState extends AvailableContractState {}

class AvailableContractLoadingState extends AvailableContractState {}

class AvailableContractLoadedState extends AvailableContractState{
  final ContractsForSymbol? contractsForSymbol;
  AvailableContractLoadedState({this.contractsForSymbol});
}

class AvailableContractError extends AvailableContractState {
  final String errorMessage;
  AvailableContractError(this.errorMessage);
}