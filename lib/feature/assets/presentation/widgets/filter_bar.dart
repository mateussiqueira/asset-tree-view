import 'package:flutter/material.dart';

class FilterBar extends StatelessWidget {
  final Function(String) onSearch;
  final VoidCallback onFilterCritical;
  final VoidCallback onFilterEnergy;
  const FilterBar({
    super.key,
    required this.onSearch,
    required this.onFilterCritical,
    required this.onFilterEnergy,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            onChanged: onSearch,
            decoration: const InputDecoration(
              labelText: 'Search',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.warning),
          onPressed: onFilterCritical,
        ),
        IconButton(
          icon: const Icon(Icons.flash_on),
          onPressed: onFilterEnergy,
        ),
      ],
    );
  }
}