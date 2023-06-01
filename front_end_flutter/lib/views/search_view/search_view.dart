import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uni_drive/views/search_view/widgets/destination_view.dart';
import 'package:uni_drive/views/search_view/widgets/navigation_buttons.dart';

import 'widgets/date_time_view.dart';
import 'widgets/start_position_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final _controller = PageController(initialPage: 0);
  final _form = FormGroup({
    'destination': FormControl<String>(validators: [Validators.required]),
    'startingPosition': FormControl<String>(validators: [Validators.required]),
    'date': FormControl<DateTime>(validators: [Validators.required]),
    'time': FormControl<TimeOfDay>(validators: [Validators.required]),
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: _form,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            NavigationButtons(controller: _controller),
            ExpandablePageView(
              controller: _controller,
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              children: const [
                DestinationView(),
                StartPositionView(),
                DateTimeView(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
