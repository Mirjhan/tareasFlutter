import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final String hintText;
  final IconData? prefixIconData;
  final IconData? suffixIconData;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;
  final String? initialValue;
  final void Function()? onTap;
  final bool enabled;
  final TextEditingController? controller;

  const InputWidget({
    super.key,
    required this.hintText,
    required this.prefixIconData,
    this.suffixIconData,
    this.keyboardType = TextInputType.name,
    this.onChanged,
    this.initialValue,
    this.onTap,
    this.enabled = true,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: onTap,
        child: TextFormField(
          controller: controller,
          enabled: enabled,
          initialValue: initialValue,
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              hintText: hintText,
              prefixIcon: Icon(
                prefixIconData,
                color: Color.fromARGB(255, 57, 103, 215),
              ),
              suffixIcon: Icon(
                suffixIconData,
                color: Color.fromARGB(255, 57, 103, 215),
              )),
          keyboardType: keyboardType,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
