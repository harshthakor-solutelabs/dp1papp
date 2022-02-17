import 'package:flutter/material.dart';
import 'package:flutter_deriv_api/api/common/active_symbols/active_symbols.dart';


class DropdownWidget extends StatefulWidget {

  const DropdownWidget({
    required this.items,
    required this.initialItem,
    this.title = '',
    required this.onItemSelected,
    Key? key,
  }) : super(key: key);


  final String title;


  final List<ActiveSymbol>? items;


  final ActiveSymbol initialItem;


  final void Function(ActiveSymbol item) onItemSelected;

  @override
  _DropdownWidgetState createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  ActiveSymbol? _item;

  @override
  void initState() {
    super.initState();
    _item = widget.initialItem;
  }

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8)),
        child: DropdownButton<ActiveSymbol>(
          key: const Key('drop_down_button'),
          isExpanded: true,
          value: _item,
          icon: const Icon(Icons.keyboard_arrow_down),
          underline: Container(),
          onChanged: (ActiveSymbol? newValue) {
            widget.onItemSelected(newValue as ActiveSymbol);
            setState(() {
              _item = newValue;
            });
          },
          items: widget.items
              ?.map<DropdownMenuItem<ActiveSymbol>>(
                  (ActiveSymbol value) => DropdownMenuItem<ActiveSymbol>(
                        key: Key('${value.displayName}'),
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text('${value.displayName}'),
                        ),
                      ))
              .toList(),
        ),
      );
}
