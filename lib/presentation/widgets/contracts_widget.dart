import 'package:dp2papp/presentation/states/available_contract/available_contract_cubit.dart';
import 'package:dp2papp/presentation/states/available_contract/available_contract_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_api/api/contract/models/available_contract_model.dart';
import 'package:flutter_deriv_bloc_manager/bloc_managers/bloc_manager.dart';

/// ContractsTypeWidget
class ContractsWidget extends StatefulWidget {
  const ContractsWidget({
    Key? key,
  }) : super(key: key);

  @override
  _ContractsWidgetState createState() => _ContractsWidgetState();
}

class _ContractsWidgetState extends State<ContractsWidget> {
  late final AvailableContractCubit _availableContractsCubit;

  @override
  void initState() {
    BlocManager.instance.register(AvailableContractCubit());
    _availableContractsCubit =
        BlocManager.instance.fetch<AvailableContractCubit>();

    super.initState();
  }

  @override
  void dispose() {
    BlocManager.instance.dispose<AvailableContractCubit>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(5),
        child: Card(
          elevation: 5,
          child: BlocBuilder<AvailableContractCubit, AvailableContractState>(
            bloc: _availableContractsCubit,
            key: const Key('builder'),
            builder: (BuildContext context, AvailableContractState state) {
              if (state is AvailableContractLoadedState) {
                final List<AvailableContractModel?>? contracts =
                    state.contractsForSymbol?.availableContracts ??
                        <AvailableContractModel>[];
                return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.black,
                  ),
                  padding: const EdgeInsets.all(5),
                  itemCount: contracts!.length,
                  itemBuilder: (BuildContext context, int index) {
                    final AvailableContractModel contract = contracts[index]!;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          "Category : ${contract.contractCategory!}",
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Name : ${contract.contractDisplay!}",
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Market : ${contract.market!}",
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Sub Market : ${contract.submarket!}",
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  },
                );
              } else if (state is AvailableContractError) {
                return Text('An error occurred');
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      );
}
