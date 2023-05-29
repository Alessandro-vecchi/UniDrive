import 'package:flutter/material.dart';

class LabeledFloatingActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const LabeledFloatingActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.centerRight,
      children: [
        Container(
          padding: const EdgeInsets.all(16)
              .copyWith(right: kMinInteractiveDimension + 16),
          height: kMinInteractiveDimension,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(kMinInteractiveDimension),
          ),
          child: Text(
            label,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.white),
          ),
        ),
        FloatingActionButton(
          onPressed: onPressed,
          child: Icon(icon),
        ),
      ],
    );
  }
}
