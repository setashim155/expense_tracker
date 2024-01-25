import 'package:expense_tracker/shared/helper.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/gaps.dart';

class ItemTile extends StatelessWidget {
  final String imageUrl;
  final String description;
  final String date;
  final double amount;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ItemTile({
    super.key,
    required this.imageUrl,
    required this.description,
    required this.date,
    required this.amount,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 6),
      child: Card(
        color: AppColors.bgColor2,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),

          // Icon
          leading: Image.asset(
            imageUrl,
            height: 60,
            fit: BoxFit.fill,
          ),

          // Description
          title: SizedBox(
            height: 32,
            child: Text(
              description,
              maxLines: 1,
              style: const TextStyle(
                color: AppColors.textColor1,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          subtitle: SizedBox(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Amount
                Expanded(
                  flex: 5,
                  child: Text(
                    Helper.formatCurrency(amount),
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                  ),
                ),

                // Date
                Expanded(
                  flex: 3,
                  child: Text(
                    date,
                    style: const TextStyle(
                      color: AppColors.textColor2,
                      fontSize: 11,
                    ),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),

          // More button
          trailing: _buildPopupMenu(),
        ),
      ),
    );
  }

  Widget _buildPopupMenu() {
    return SizedBox(
      width: 30,
      child: PopupMenuButton(
        icon: const Icon(
          Icons.more_vert_rounded,
          color: AppColors.textColor1,
        ),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              onTap: onEdit,
              child: const Row(
                children: [
                  Icon(Icons.edit_rounded),
                  Gaps.hGap5,
                  Text('Edit'),
                ],
              ),
            ),
            PopupMenuItem(
              onTap: onDelete,
              child: const Row(
                children: [
                  Icon(Icons.delete_rounded),
                  Gaps.hGap5,
                  Text('Delete'),
                ],
              ),
            ),
          ];
        },
      ),
    );
  }
}
