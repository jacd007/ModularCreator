// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomDropDownWidget<T> extends StatefulWidget {
  final List<T> elements;
  final Widget Function(int) onBuilder;
  final ValueChanged<T> onSelected;
  final AlignmentGeometry alignment;

  const CustomDropDownWidget(
      {required this.elements,
      required this.onBuilder,
      required this.onSelected,
      this.alignment = AlignmentDirectional.centerStart,
      super.key});

  @override
  State createState() => _CustomDropDownWidgetState<T>();
}

class _CustomDropDownWidgetState<T> extends State<CustomDropDownWidget<T>> {
  T? dropdownValue;

  @override
  void initState() {
    if (widget.elements.isNotEmpty) dropdownValue = widget.elements.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      value: dropdownValue,
      onChanged: (T? newValue) {
        setState(() => dropdownValue = newValue as T);
        widget.onSelected(newValue as T);
      },
      items: List.generate(
        widget.elements.length,
        (index) => DropdownMenuItem<T>(
          value: widget.elements[index],
          child: widget.onBuilder(index),
        ),
      ),
    );
  }
}

// ========================================================================
class CustomDropdownModel {
  int id;
  String label;
  dynamic value;

  CustomDropdownModel({required this.id, required this.label, this.value});
}
