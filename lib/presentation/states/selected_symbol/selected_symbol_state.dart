import 'package:flutter_deriv_api/api/common/active_symbols/active_symbols.dart';

abstract class SelectedSymbolState{}

class SelectedSymbolInitState extends SelectedSymbolState{}

class SelectedSymbolChengedState extends SelectedSymbolState{
  final ActiveSymbol seletedSymbol;

  SelectedSymbolChengedState({required this.seletedSymbol});
}