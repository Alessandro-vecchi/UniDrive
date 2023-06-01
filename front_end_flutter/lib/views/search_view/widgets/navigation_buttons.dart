import 'package:flutter/material.dart';

class NavigationButtons extends StatefulWidget {
  const NavigationButtons({
    super.key,
    required PageController controller,
  }) : _controller = controller;

  final PageController _controller;

  @override
  State<NavigationButtons> createState() => _NavigationButtonsState();
}

class _NavigationButtonsState extends State<NavigationButtons> {
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    widget._controller.addListener(() {
      setState(() {
        _currentPage = widget._controller.page?.toInt() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (_currentPage != 0)
          ElevatedButton(
            onPressed: () => widget._controller.previousPage(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(8),
            ),
            child: const Icon(Icons.arrow_back),
          ),
        const Expanded(child: SizedBox()),
        if (_currentPage != 2)
          ElevatedButton(
            onPressed: () => widget._controller.nextPage(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(8),
            ),
            child: const Icon(Icons.arrow_forward),
          ),
        if (_currentPage == 2)
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(8),
            ),
            child: const Icon(Icons.check),
          )
      ],
    );
  }
}
