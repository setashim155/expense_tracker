import 'package:expense_tracker/shared/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/app_colors.dart';
import '../providers/common_providers.dart';

class AppSearchBar extends ConsumerStatefulWidget {
  final void Function(String) onSearch;

  const AppSearchBar({
    super.key,
    required this.onSearch,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends ConsumerState<AppSearchBar> {
  final searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isEditing = ref.watch(editStatusProvider(id: 'searchBar'));

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.only(left: 10),
      decoration: const BoxDecoration(
        color: AppColors.bgColor2,
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: SizedBox(
              height: 55,
              child: TextFormField(
                controller: searchTextController,
                style: const TextStyle(color: AppColors.textColor1),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusColor: Colors.white70,
                  hintText: 'Search',
                  hintStyle: const TextStyle(color: AppColors.textColor1),

                  // Clear icon
                  suffixIcon: isEditing
                      ? IconButton(
                          onPressed: () => searchTextController.clear(),
                          icon: const Icon(
                            Icons.cancel,
                            color: AppColors.textColor2,
                          ),
                        )
                      : null,
                ),
                onTap: () => ref.read(editStatusProvider(id: 'searchBar').notifier).change(true),
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                  ref.read(editStatusProvider(id: 'searchBar').notifier).change(false);
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 55,
              child: IconButton(
                onPressed: () => widget.onSearch(Helper.trim(searchTextController.text)),
                icon: const Icon(
                  Icons.search_rounded,
                  color: AppColors.textColor1,
                  size: 28,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.buttonColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchTextController.dispose();

    super.dispose();
  }
}
