import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/widgets/text_fields/custom_text_field.dart';

class PersonalDataPage extends StatelessWidget {
  PersonalDataPage({Key? key}) : super(key: key);

  static const routeName = '/personal_data';

  final _nameController = TextEditingController(
      // text: 'Timur',
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            CustomTextField(
              controller: _nameController,
              maxLength: 35,
              keyboardType: TextInputType.name,
              validator: MultiValidator([
                LengthRangeValidator(
                  min: 1,
                  max: 35,
                  errorText: 'Укажите ваше имя',
                )
              ]),
              hintText: 'Ваше имя*',
            ),
          ],
        ),
      ),
    );
  }
}

PreferredSizeWidget _appBar() {
  return AppBar(
    leading: IconButton(
      icon: SvgPicture.asset(
        AppIcons.leftArrow,
      ),
      onPressed: () {},
    ),
    centerTitle: true,
    title: const Text(
      'Личные данные',
      style: TextStyle(
        color: AppColors.darkBlue,
        fontWeight: AppFonts.bold,
        letterSpacing: 0.5,
        fontSize: AppFonts.sizeLarge,
      ),
    ),
    actions: [
      IconButton(
        icon: SvgPicture.asset(
          AppIcons.dialog,
        ),
        onPressed: () {},
      ),
    ],
  );
}
