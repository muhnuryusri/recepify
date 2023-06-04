import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recepify/features/category_list/domain/entities/category_list.dart';

import '../bloc/category_list_bloc.dart';

class CategoryListItem extends StatelessWidget {

  final CategoryData category;

  const CategoryListItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final bloc = context.read<CategoryListBloc>();
        bloc.add(SelectCategory(categorySelected: category.category));
      },
      child: BlocBuilder<CategoryListBloc, CategoryListState>(
        builder: (context, state) {
          final isSelected = (state is CategorySelected) &&
              (state.categorySelected == category.category);
          return Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOutCirc,
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                alignment: Alignment.center,
                height: isSelected ? 70.0 : 60.0,
                width: isSelected ? 70.0 : 60.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      isSelected ? Colors.deepOrangeAccent : Colors.amberAccent,
                ),
                child: const Icon(
                  Icons.gamepad_outlined,
                ),
              ),
              const SizedBox(height: 4.0),
              SizedBox(
                width: 60,
                child: Text(
                  category.category,
                  style: const TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
