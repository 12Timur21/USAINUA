import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/resources/app_images.dart';

class AddressTab extends StatefulWidget {
  const AddressTab({Key? key}) : super(key: key);

  @override
  State<AddressTab> createState() => _AddressTabState();
}

class _AddressTabState extends State<AddressTab> {
  bool _hasAdress = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _hasAdress
            ? _NoAdress(
                onTap: () {
                  setState(() {
                    _hasAdress = true;
                  });
                },
              )
            : const _Addresses(),
      ],
    );
  }
}

class _NoAdress extends StatelessWidget {
  const _NoAdress({
    //!Убрать потом
    required VoidCallback onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          AppImages.girlWithMarker,
        ),
        TextButton.icon(
          onPressed: () {},
          icon: SvgPicture.asset(
            AppIcons.plus,
            color: AppColors.lightBlue,
          ),
          label: const Text(
            'Добавить адрес доставки',
            style: TextStyle(
              color: AppColors.darkBlue,
              fontWeight: AppFonts.bold,
              fontSize: AppFonts.sizeXSmall,
            ),
          ),
        ),
      ],
    );
  }
}

class _Addresses extends StatefulWidget {
  const _Addresses({Key? key}) : super(key: key);

  @override
  State<_Addresses> createState() => __AddressesState();
}

class __AddressesState extends State<_Addresses> {
  int? selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Expanded(
        child: Column(
          children: [
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 200,
                  child: ExpansionTile(
                    key: Key(index.toString()), //attention
                    initiallyExpanded: index == selected, //attention
                    title: Text(index.toString()),
                    children: _Product_ExpandAble_List_Builder(index),
                    onExpansionChanged: ((newState) {
                      if (newState)
                        setState(() {
                          selected = index;
                        });
                      else
                        setState(() {
                          selected = -1;
                        });
                    }),
                  ),
                );
              },
            ),
            TextButton.icon(
              onPressed: () {},
              icon: SvgPicture.asset(
                AppIcons.plus,
                color: AppColors.lightBlue,
              ),
              label: const Text(
                'Добавить еще адрес',
                style: TextStyle(
                  color: AppColors.darkBlue,
                  fontWeight: AppFonts.bold,
                  fontSize: AppFonts.sizeXSmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

_Product_ExpandAble_List_Builder(int cat_id) {
  List<Widget> columnContent = [];
  [1, 2, 4, 5].forEach((product) => {
        columnContent.add(
          ListTile(
            title: ExpansionTile(
              title: Text(product.toString()),
            ),
            trailing: Text("$product (Kg)"),
          ),
        ),
      });
  return columnContent;
}
