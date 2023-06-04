import 'package:flutter/cupertino.dart';

import '../../../category_list/presentation/widgets/category_list_widget.dart';
import '../widgets/header_title.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderTitle(),
          SizedBox(height: 40.0),
          CategoryListWidget(),
        ],
      ),
    );
  }
}
