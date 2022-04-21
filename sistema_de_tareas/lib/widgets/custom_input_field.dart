import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final bool obscureText;
  final FocusNode? focusNode;
  final IconData? icon;
  final String? initialValue;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Function(String)? onChanged;
  final String? counterText;
  final String? Function(String?)? validator;
  final String? helperText;
  final String? hintText;
  final String? labelText;
  final TextCapitalization textCapitalization;
  final TextInputType? keyboardType;
  final void Function(String)? onFieldSubmitted;

  const CustomInputField({
    Key? key,
    this.onChanged,
    this.counterText,
    this.initialValue,
    this.focusNode,
    this.helperText,
    this.hintText,
    this.icon,
    this.keyboardType,
    this.labelText,
    this.obscureText = false,
    this.onFieldSubmitted,
    this.prefixIcon,
    this.suffixIcon,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      focusNode: focusNode,
      initialValue: initialValue,
      keyboardType: keyboardType,
      obscureText: obscureText,
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        helperText: helperText,
        counterText: counterText,
        prefixIcon: prefixIcon == null ? null : Icon(prefixIcon),
        suffixIcon: suffixIcon == null ? null : Icon(suffixIcon),
        icon: icon == null ? null : Icon(icon),
      ),
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      // validator: (value) {
      //   if (value == null) return 'Este campo es requerido';
      //   return value.length < 3 ? 'Debe tener 3 letras' : null;
      // },
    );
  }
}
