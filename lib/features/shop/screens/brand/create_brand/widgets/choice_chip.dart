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
    return Colors.blue; 
  }

  @override
  Widget build(BuildContext context) {
    final color = getChipColor();
    return ChoiceChip(
      avatar: CircleAvatar(
        backgroundColor: color,
        child: Text(
          text[0],
          style: TextStyle(color: Colors.white),
        ),
      ),
      label: Text(text),
      selected: selected,
      selectedColor: color, 
      onSelected: onSelected,
      backgroundColor: Colors.grey[200], 
      labelStyle: TextStyle(
        color: selected ? Colors.white : Colors.black,
      ),
      shape: StadiumBorder(),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }
}
