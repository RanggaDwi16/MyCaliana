import 'package:flutter/material.dart';
import 'package:my_caliana/src/core/utils/constant/app_colors.dart';
import 'package:my_caliana/src/core/utils/extensions/build_context.ext.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? labelText;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? hintText;
  final IconData? prefixIcon;
  final bool? isLink;
  final bool? isCalendar;
  final bool? isDisabled;
  final bool? isRequired;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onTapIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool? isRegister;

  const CustomTextField({
    super.key,
    required this.controller,
    this.labelText,
    this.obscureText = false,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.isRequired = false,
    this.isLink = false,
    this.isCalendar = false,
    this.isDisabled = false,
    this.isRegister = false,
    this.onTap,
    this.onTapIcon,
    this.keyboardType,
    this.validator,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isFocused = false; // Menyimpan status fokus input
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      setState(() {
        isFocused = _focusNode.hasFocus || widget.controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          RichText(
            text: TextSpan(
              children: [
                // **Teks Utama (Label)**
                TextSpan(
                  text:
                      widget.labelText!.replaceAll(' (tidak wajib diisi)', ''),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                // **Tanda "*" jika wajib diisi**
                if (widget.isRequired == true)
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                // **Tambahkan "(tidak wajib diisi)" dengan style abu-abu & italic**
                if (widget.labelText!.contains('tidak wajib diisi'))
                  const TextSpan(
                    text: ' (tidak wajib diisi)',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
              ],
            ),
          ),
        const SizedBox(height: 5),
        TextFormField(
          focusNode: _focusNode,
          validator: widget.validator,
          textInputAction: TextInputAction.next,
          controller: widget.controller,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          readOnly: widget.isCalendar == true || widget.isDisabled == true,
          onTap: widget.onTap,
          style: const TextStyle(color: AppColor.primaryColor),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            filled: true,
            fillColor: widget.isDisabled == true
                ? const Color.fromARGB(255, 214, 214, 209)
                : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColor.primaryColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: widget.isRegister == false
                  ? const BorderSide(color: AppColor.primaryColor)
                  : const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColor.primaryColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 12,
            ),
            prefixIcon: widget.prefixIcon != null
                ? Icon(
                    widget.prefixIcon,
                    color: isFocused ? AppColor.primaryColor : Colors.grey,
                  )
                : null,
            suffixIcon: (widget.isLink == true && widget.suffixIcon != null)
                ? GestureDetector(
                    onTap: widget.onTapIcon,
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: context.deviceHeight * 0.07,
                        minWidth: context.deviceWidth * 0.15,
                      ),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: widget.suffixIcon,
                    ),
                  )
                : widget.suffixIcon,
          ),
        ),
      ],
    );
  }
}
