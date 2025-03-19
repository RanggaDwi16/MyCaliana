import 'package:flutter/material.dart';
import 'package:my_caliana/src/core/utils/constant/app_colors.dart';

class CustomExpansionTile extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const CustomExpansionTile({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: ExpansionTile(
        iconColor: AppColor.primaryColor,
        collapsedIconColor: AppColor.primaryColor,
        title: Text(
          title,
          style: const TextStyle(
            color: AppColor.primaryColor,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }
}
