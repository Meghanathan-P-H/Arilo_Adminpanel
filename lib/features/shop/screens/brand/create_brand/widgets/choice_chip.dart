import 'package:flutter/material.dart';

class AriloChoiceChips extends StatelessWidget {
  final String text;
  final bool selected;
  final ValueChanged<bool> onSelected;

  const AriloChoiceChips({
    super.key,
    required this.text,
    required this.selected,
    required this.onSelected,
  });

  Color getChipColor() {
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    final color = getChipColor();
    return ChoiceChip(
      avatar: CircleAvatar(
        backgroundColor: color,
        child: selected 
          ? const Icon(Icons.check, color: Colors.white, size: 18)
          : const Icon(Icons.add, color: Colors.white, size: 13),
      ),
      label: Text(text),
      selected: selected,
      selectedColor: color,
      onSelected: onSelected,
      backgroundColor: Colors.grey[200],
      labelStyle: TextStyle(
        color: selected ? Colors.white : Colors.black,
      ),
      shape: const StadiumBorder(),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }
}