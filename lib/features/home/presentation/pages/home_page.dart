import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recepify/features/category_list/presentation/bloc/category_list_bloc.dart';

import '../../../../injection_container.dart';
import 'home_layout.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F5F8),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<CategoryListBloc>(
            create: (_) => sl<CategoryListBloc>(),
          )
        ],
        child: const HomeLayout(),
      ),
    );
  }
}
