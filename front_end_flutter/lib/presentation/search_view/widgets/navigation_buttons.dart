import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../models/search_model.dart';
import '../../rides_view/rides_view.dart';

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
            onPressed: () {
              final form = ReactiveForm.of(context);
              if(form?.invalid ?? true) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please fill in all the fields', style: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }
              FocusScope.of(context).unfocus();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => RidesView(
                    SearchModel.fromForm(form?.value as Map<String, dynamic>),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(8),
            ),
            child: const Icon(Icons.check),
          )
      ],
    );
  }
}
