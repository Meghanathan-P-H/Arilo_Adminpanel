import 'package:flutter/material.dart';

// Widget for displaying action buttons for table rows
class TableActionButtons extends StatelessWidget {
  const TableActionButtons({
    super.key,
    this.view = false,
    this.edit = true,
    this.delete = true,
    this.onViewPressed,
    this.onEditPressed,
    this.onDeletePressed,
  });

  
  final bool view;

  
  final bool edit;

  
  final bool delete;

  
  final VoidCallback? onViewPressed;

  
  final VoidCallback? onEditPressed;

 
  final VoidCallback? onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (view)
          IconButton(
            onPressed: onViewPressed,
            icon: const Icon(Icons.visibility_outlined, color: Colors.grey),
            tooltip: 'View',
          ),
        if (edit)
          IconButton(
            onPressed: onEditPressed,
            icon: const Icon(Icons.edit_outlined, color: Colors.blue),
            tooltip: 'Edit',
          ),
        if (delete)
          IconButton(
            onPressed: onDeletePressed,
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            tooltip: 'Delete',
          ),
      ],
    );
  }
}