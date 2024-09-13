import 'package:flutter/material.dart';

class DefaultDropdownItem extends StatelessWidget {
  final Function() onTap;
  final String name;
  final int? maxLines;
  const DefaultDropdownItem(
      {super.key, required this.onTap, required this.name, this.maxLines});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            name,
            maxLines: maxLines ?? 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: theme.textTheme.bodyLarge?.color, fontSize: 12),
          ),
        ));
  }
}
