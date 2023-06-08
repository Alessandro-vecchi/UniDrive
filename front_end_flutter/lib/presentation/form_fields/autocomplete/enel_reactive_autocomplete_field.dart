// Dart imports:
import 'dart:async';
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:persistent_header_adaptive/size_reporting_widget.dart';

// Package imports:
import 'package:reactive_forms/reactive_forms.dart';

// Project imports:
import 'autocomplete_state.dart';

typedef SuggestionToString<T> = String Function(T item);
typedef SuggestionItemsBuilder<T> = Widget Function(T item);
typedef SuggestionItemsSearch<T> = Future<List<T>> Function(String searchText);

class ReactiveAutocompleteField<T> extends StatefulWidget {
  final FormControl<String>? formControl;
  final String? formControlName;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final int? maxLength;
  final String? hint;
  final Map<String, ValidationMessageFunction>? validationMessages;
  final ShowErrorsFunction? showErrors;
  final ValueChanged<T?>? onChanged;
  final SuggestionToString<T> suggestionToString;
  final SuggestionItemsBuilder<T> suggestionItemsBuilder;
  final SuggestionItemsSearch<T> suggestionItemsSearch;

  const ReactiveAutocompleteField({
    Key? key,
    this.formControl,
    this.formControlName,
    this.hint,
    this.validationMessages,
    this.showErrors,
    this.onChanged,
    required this.suggestionToString,
    required this.suggestionItemsBuilder,
    required this.suggestionItemsSearch,
    this.suffixIcon,
    this.textInputAction,
    this.keyboardType,
    this.maxLength,
  }) : super(key: key);

  @override
  State<ReactiveAutocompleteField<T>> createState() =>
      _ReactiveAutocompleteFieldState<T>();
}

class _ReactiveAutocompleteFieldState<T>
    extends State<ReactiveAutocompleteField<T>> {
  double _height = kMinInteractiveDimension;
  Timer? _timer;
  StreamSubscription? _ssValue;
  StreamSubscription? _ssFocus;
  AutocompleteState _state = AutocompleteState.closed;
  List<T> _items = const [];

  @override
  void initState() {
    super.initState();
    _ssValue = _resolveFormControl(context).valueChanges.listen((value) {
      if (value != null && value.length >= 3) {
        _timer?.cancel();
        _timer = Timer(const Duration(milliseconds: 800), () async {
          setState(() {
            _state = AutocompleteState.loading;
          });
          final result = await widget.suggestionItemsSearch(value);
          setState(() {
            _state = AutocompleteState.suggestions;
            _items = result;
          });
        });
      } else {
        setState(() {
          _state = AutocompleteState.closed;
          _items = [];
        });
      }
    });
    _ssFocus = _resolveFormControl(context).focusChanges.listen((focus) {
      if (!focus) {
        setState(() {
          _state = AutocompleteState.closed;
        });
      }
    });
  }

  @override
  void dispose() {
    _ssValue?.cancel();
    _ssFocus?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      explicitChildNodes: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReactiveTextField<String>(
            formControlName: widget.formControlName,
            formControl: widget.formControl,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            validationMessages: widget.validationMessages,
            maxLength: widget.maxLength,
            decoration: InputDecoration(
              hintText: widget.hint,
              suffixIcon: _state == AutocompleteState.loading &&
                      _resolveFormControl(context).hasFocus
                  ? const UnconstrainedBox(
                      child: SizedBox(
                          height: 16.0,
                          width: 16.0,
                          child: CircularProgressIndicator()),
                    )
                  : widget.suffixIcon,
            ),
          ),
          if (_state == AutocompleteState.suggestions &&
              _resolveFormControl(context).hasFocus) ...[
            const SizedBox(height: 8),
            _suggestions,
          ]
        ],
      ),
    );
  }

  Widget get _suggestions {
    return Container(
      height: _height * min(5, _items.length),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => _selectSuggestion(_items[index]),
            child: SizeReportingWidget(
              onSizeChange: (size) => setState(() => _height = size.height),
              child: widget.suggestionItemsBuilder(_items[index]),
            ),
          );
        },
      ),
    );
  }

  void _selectSuggestion(T item) {
    _resolveFormControl(context)
      ..patchValue(widget.suggestionToString(item))
      ..unfocus();
    widget.onChanged?.call(item);
    setState(() {
      _state = AutocompleteState.closed;
    });
  }

  FormControl<String> _resolveFormControl(BuildContext context) {
    if (widget.formControl != null) {
      return widget.formControl!;
    }
    final parent = ReactiveForm.of(context, listen: false);
    if (parent == null || parent is! FormControlCollection) {
      throw FormControlParentNotFoundException(widget);
    }

    final collection = parent as FormControlCollection;
    final control = collection.control(widget.formControlName!);

    return control as FormControl<String>;
  }
}
