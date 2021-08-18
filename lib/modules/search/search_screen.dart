import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopin/modules/search/search_widget.dart';
import 'package:shopin/shared/bloc/app_bloc/app_bloc.dart';
import 'package:shopin/shared/bloc/app_bloc/app_states.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {


        var cubit = AppCubit.get(context);


        return bodyWidget(state, cubit, size);
      },
    );
  }
}
