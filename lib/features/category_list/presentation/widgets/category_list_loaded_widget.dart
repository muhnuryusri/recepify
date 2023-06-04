import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recepify/features/category_list/presentation/widgets/category_list_item.dart';

import '../bloc/category_list_bloc.dart';

class CategoryListLoadedWidget extends StatelessWidget {
  const CategoryListLoadedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryListBloc, CategoryListState>(
      builder: (context, state) {
        if (state is CategoryListLoaded) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .15,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CategoryListItem(
                  key: ValueKey('${state.list.categoryList[index]}$index'),
                  category: state.list.categoryList[index],
                );
              },
              scrollDirection: Axis.horizontal,
              separatorBuilder: (_, __) => const SizedBox(
                width: 16.0,
              ),
              itemCount: state.list.categoryList.length,
            ),
          );
        } else {
          return Container(); // Placeholder widget jika state tidak sesuai
        }
      },
    );
  }
}