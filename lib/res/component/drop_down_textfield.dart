import 'package:flutter/material.dart';

class CustomDropDownButton extends StatelessWidget {
  CustomDropDownButton({
    Key? key,
    required this.selectedDropdownValue,
    required this.itemList,
    required this.onChange,
  }) : super(key: key);
  String selectedDropdownValue;
  List<DropdownMenuItem<String>> itemList;
  void Function(String?)? onChange;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
              labelText: 'Categori Name',
              errorText: state.errorText,
              border: InputBorder.none,
            ),
            isEmpty: selectedDropdownValue == null || selectedDropdownValue!.isEmpty,
            child: DropdownButtonFormField<String>(
              value: selectedDropdownValue,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              items: itemList,
              onChanged: onChange,
            ),
          );
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select an option';
          }
          return null;
        },
      ),
    );
  }
}
