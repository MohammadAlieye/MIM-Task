import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task/core/constants/app_assets.dart';
import 'package:task/core/constants/app_color.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final bool? enabled;
  final String labelText;
  final String? hintText;
  final VoidCallback? onTap;
  final int? maxLines;
  final int? minLines;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final String? Function(String? value)? validator;
  final TextCapitalization? textCapitalization;
  final Icon? prefixIcon;
  final bool? isHost;
  final Color? labelCustomColor;
  final bool obscureText;

  const CustomTextField({
    Key? key,
    this.controller,
    required this.labelText,
    this.onTap,
    this.readOnly,
    this.enabled,
    this.maxLines,
    this.validator,
    this.suffixIcon,
    this.keyboardType,
    this.onChanged,
    this.hintText,
    this.minLines,
    this.textCapitalization,
    this.inputFormatters,
    this.prefixIcon,
    this.isHost,
    this.labelCustomColor,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      style: const TextStyle(fontSize: 16),
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      onChanged: onChanged,
      enabled: enabled,
      keyboardType: keyboardType,
      maxLines: maxLines ?? 1,
      controller: controller,
      inputFormatters: inputFormatters,
      onTap: onTap,
      validator: validator,
      readOnly: readOnly ?? false,
      minLines: minLines ?? 1,
      cursorColor: AppColor.kBlue,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        contentPadding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        suffixIcon: suffixIcon,
        suffixIconColor: Colors.black,
        labelText: labelText,
        floatingLabelStyle:
            const TextStyle(fontSize: 12, color: AppColor.kBlue),
        hintText: hintText,
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: labelCustomColor,
        ),
      ),
    );
  }
}

class CustomDropDownWidget extends StatelessWidget {
  final String labelText;
  final Enum? value;
  final List<Enum> items;
  final Function(Enum?)? onChanged;
  final String? Function(Enum?)? validator;
  const CustomDropDownWidget({
    super.key,
    required this.labelText,
    required this.value,
    required this.items,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Enum>(
      value: value,
      validator: validator,
      items: items.map((value) {
        return DropdownMenuItem<Enum>(
          value: value,
          child: Text(value.name),
        );
      }).toList(),
      onChanged: onChanged,
      borderRadius: BorderRadius.circular(20),
      elevation: 1,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        suffixIconColor: Colors.black,
        labelText: labelText,
        floatingLabelStyle:
            const TextStyle(fontSize: 12, color: AppColor.kBlue),
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ChatTextField extends StatelessWidget {
  final VoidCallback sendIcon;
  final bool? isHost;
  final TextEditingController messageController;

  const ChatTextField({
    Key? key,
    required this.sendIcon,
    required this.messageController,
    this.isHost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: TextField(
                  controller: messageController,
                  cursorColor: AppColor.kBlue,
                  decoration: InputDecoration(
                    hintText: 'Type message',
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(12.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColor.kBlue),
                        borderRadius: BorderRadius.circular(12.0)),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                            color: AppColor.kBlue,
                            borderRadius: BorderRadius.circular(10)),
                        child: IconButton(
                          icon: SvgPicture.asset(AppAssets.ksend),
                          onPressed: sendIcon,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).viewPadding.bottom == 0 ? 10 : 31,
        ),
      ],
    );
  }
}
