import 'dart:async';

import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:usainua/services/new_post_service.dart';
import 'package:usainua/widgets/app_bars/custom_app_bar.dart';

class AddRecipientAddressesPage extends StatefulWidget {
  const AddRecipientAddressesPage({Key? key}) : super(key: key);

  static const routeName = '/recipient_adresses_page';

  @override
  State<AddRecipientAddressesPage> createState() =>
      _AddRecipientAddressesPageState();
}

class _AddRecipientAddressesPageState extends State<AddRecipientAddressesPage> {
  // final TextEditingController _addressController = TextEditingController();

  // List<DropdownMenuItem<String>> get dropdownItems {
  //   List<DropdownMenuItem<String>> menuItems = const [
  //     DropdownMenuItem(child: Text('USA'), value: 'USA'),
  //     DropdownMenuItem(child: Text('Canada'), value: 'Canada'),
  //     DropdownMenuItem(child: Text('Brazil'), value: 'Brazil'),
  //     DropdownMenuItem(child: Text('England'), value: 'England'),
  //   ];
  //   return menuItems;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onLeading: () {
          Navigator.of(context).pop();
        },
        text: 'Адреса получателей',
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 24,
          right: 24,
        ),
        child: Column(
          children: [
            // const Text(
            //   'Добавьте новый адрес для доставки и используйте его по умолчанию',
            //   style: TextStyle(
            //     color: AppColors.darkBlue,
            //     fontSize: AppFonts.sizeXSmall,
            //     fontWeight: AppFonts.regular,
            //     letterSpacing: 1,
            //   ),
            // ),
            TextButton(
              onPressed: () {
                // NewPostService.instance.getRegions();
                // NewPostService.instance.getCitys(
                //   cityName: 'Крив',
                //   regionRef: '7150812b-9b87-11de-822f-000c2965ae0e',
                // );
                NewPostService.instance.getStreets(
                  streetName: 'Бул',
                  cityRef: 'e71a2cab-4b33-11e4-ab6d-005056801329',
                );
              },
              child: Text(
                'Text select request',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),

            // Form(
            //   child: Column(
            //     children: [
            //       // TextFieldWithCustomLabel(
            //       //   controller: _addressController,
            //       //   textInputAction: TextInputAction.send,
            //       //   maxLength: 60,
            //       //   keyboardType: TextInputType.streetAddress,
            //       //   validator: MultiValidator([
            //       //     LengthRangeValidator(
            //       //       min: 1,
            //       //       max: 60,
            //       //       errorText: 'Укажите название адреса',
            //       //     )
            //       //   ]),
            //       //   hintText: 'Название адреса (дом, офис и т.п.)',
            //       // ),
            //       // CountryListPick(
            //       //   initialSelection: '+380',
            //       //   pickerBuilder: (context, CountryCode? code) {
            //       //     return Container(
            //       //       width: double.infinity,
            //       //       height: 60,
            //       //       color: Colors.red,
            //       //       child: TextFieldWithCustomLabel(
            //       //         controller: _addressController,
            //       //         textInputAction: TextInputAction.send,
            //       //         maxLength: 60,
            //       //         keyboardType: TextInputType.streetAddress,
            //       //         validator: MultiValidator([
            //       //           LengthRangeValidator(
            //       //             min: 1,
            //       //             max: 60,
            //       //             errorText: 'Укажите страну',
            //       //           )
            //       //         ]),
            //       //         hintText: 'Страна',
            //       //       ),
            //       //     );
            //       //   },
            //       //   onChanged: (CountryCode? code) {},
            //       // ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
