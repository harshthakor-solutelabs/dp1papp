import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_api/state/connection/connection_cubit.dart'
as connection_cubit;
import 'package:flutter_deriv_bloc_manager/bloc_managers/bloc_manager.dart';

import 'dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final connection_cubit.ConnectionCubit _connectionCubit;
  @override
  void initState() {
    super.initState();
    _initializeBlocs();
  }

  @override
  void dispose() {
    BlocManager.instance.dispose<connection_cubit.ConnectionCubit>();
    super.dispose();
  }

  void _initializeBlocs() {
    _connectionCubit =
        BlocManager.instance.fetch<connection_cubit.ConnectionCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<connection_cubit.ConnectionCubit,connection_cubit.ConnectionState>(
        bloc: _connectionCubit,
        builder: (context,state){
          if (state is connection_cubit.ConnectionConnectedState) {
            return Dashboard();
          } else if (state is connection_cubit.ConnectionConnectingState) {
            return _buildCenterText('Connecting...');
          } else if (state is connection_cubit.ConnectionErrorState) {
            return _buildCenterText(state.error);
          } else {
            return _buildCenterText('connection lost');
          }
        },
      ),
    );
  }
  Widget _buildCenterText(String text) => Center(
    child: Text(text),
  );
}
