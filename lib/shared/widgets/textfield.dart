import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/modules/textfield/textfieldcontroller.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final bool readOnly;
  final TextFieldController? textFieldController;
  const CustomTextField({
    Key? key,
    this.readOnly = false,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.onChanged,
    this.textFieldController
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
    late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.readOnly,

      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText:  _obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(widget.prefixIcon, color: TheColors.errorColor),
        // suffixIcon: Icon(suffixIcon,color: TheColors.errorColor,),
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: TheColors.yellow,
                ),
                onPressed: () {
                 
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
        hintText: widget.hintText,

        hintStyle: TextStyles.siemreap(
          context,
          fontSize: 11,
          color: TheColors.gray,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: TheColors.orange,
            width: 0.5,
          ), // Primary Blue
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: TheColors.lightOrage,
            width: 0.5,
          ), // Primary Blue
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 12,
        ),
      ),
      style: TextStyles.siemreap(context, fontSize: 12),
      validator:
          widget.validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'សូមបំពេញ';
            }
            return null;
          },
      onChanged: widget.onChanged,
    );
  }
}
