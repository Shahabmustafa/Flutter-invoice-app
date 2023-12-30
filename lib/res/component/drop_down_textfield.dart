import 'package:flutter/material.dart';

class DropDownTextField extends StatelessWidget {
  DropDownTextField({Key? key,this.selectedDropdownValue,required this.dropdownItems}) : super(key: key);
  String? selectedDropdownValue;
  List<String> dropdownItems;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
              labelText: 'Select an option',
              errorText: state.errorText,
              border: InputBorder.none,
            ),
            isEmpty: selectedDropdownValue == null || selectedDropdownValue!.isEmpty,
            child: DropdownButtonFormField<String>(
              value: selectedDropdownValue,
              items: dropdownItems.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                // Update the state when a new value is selected
                selectedDropdownValue = value!;
                state.didChange(value);
              },
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
