import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/category_list_bloc.dart';
import 'category_list_loaded_widget.dart';

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryListBloc, CategoryListState>(
      builder: (context, state) {
        if (state is CategoryListLoaded) {
          return const CategoryListLoadedWidget();
        } else {
          return Container(); // Placeholder widget jika state tidak sesuai
        }
      },
    );
  }
}