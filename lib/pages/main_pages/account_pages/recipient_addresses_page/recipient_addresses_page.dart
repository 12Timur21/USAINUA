import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usainua/blocs/recipient_address_bloc/recipient_address_bloc.dart';
import 'package:usainua/models/new_post_models/city_model.dart';
import 'package:usainua/models/new_post_models/region_model.dart';
import 'package:usainua/models/recipient_address_model.dart';
import 'package:usainua/pages/main_pages/account_pages/add_recipient_addresses_page/add_recipient_address_page.dart';
import 'package:usainua/repositories/firestore_repository.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/resources/app_icons.dart';
import 'package:usainua/widgets/app_bars/custom_app_bar.dart';
import 'package:usainua/widgets/buttons/icon_text_button.dart';
import 'package:usainua/widgets/card/address_card.dart';
import 'package:usainua/widgets/radio_buttons/custom_radio_button.dart';

enum DeliveryType {
  department,
  address,
}

class RecipientAddressesPage extends StatefulWidget {
  const RecipientAddressesPage({Key? key}) : super(key: key);

  static const routeName = '/recipient_addresses_page';

  @override
  State<RecipientAddressesPage> createState() => _RecipientAddressesPageState();
}

class _RecipientAddressesPageState extends State<RecipientAddressesPage> {
  Future<void> _addNewRecipentAddress() async {
    RecipentAddressModel? recipientAddressesModel =
        await Navigator.of(context).pushNamed(
      AddRecipientAddressPage.routeName,
    ) as RecipentAddressModel?;

    if (recipientAddressesModel != null) {
      context.read<RecipientAddressBloc>().add(
            AddRecipientAddressEvent(
              recipentAddressModel: recipientAddressesModel,
            ),
          );
    }
  }

  Future<void> _editNewRecipentAddress(
    RecipentAddressModel recipentAddressModel,
  ) async {
    final recipientAddressesModel = await Navigator.of(context).pushNamed(
      AddRecipientAddressPage.routeName,
      arguments: recipentAddressModel,
    ) as RecipentAddressModel?;

    if (recipientAddressesModel != null) {
      context.read<RecipientAddressBloc>().add(
            UpdateRecipientAddressEvent(
              recipentAddressModel: recipientAddressesModel,
            ),
          );
    }
  }

  Future<void> _deleteRecipentAddress(
    String recipentAddressID,
  ) async {
    context.read<RecipientAddressBloc>().add(
          DeleteRecipientAddressEvent(
            recipentAddressID: recipentAddressID,
          ),
        );
  }

  void _onSelectRecipentAddress(String id) {
    context.read<RecipientAddressBloc>().add(
          UpdateSelectedRecipientAddressIDEvent(
            recipentAddressID: id,
          ),
        );
  }

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              _RecipientAdressList(
                onDismissed: _deleteRecipentAddress,
                onEdit: _editNewRecipentAddress,
                onChanged: _onSelectRecipentAddress,
              ),
              const SizedBox(
                height: 10,
              ),
              IconTextButton(
                onTap: _addNewRecipentAddress,
                text: 'Добавить еще адрес',
                textStyle: const TextStyle(
                  color: AppColors.darkBlue,
                  fontWeight: AppFonts.bold,
                  fontSize: AppFonts.sizeXSmall,
                ),
                icon: SvgPicture.asset(
                  AppIcons.plus,
                  color: AppColors.lightBlue,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecipientAdressList extends StatelessWidget {
  const _RecipientAdressList({
    required this.onChanged,
    required this.onEdit,
    required this.onDismissed,
    Key? key,
  }) : super(key: key);

  final void Function(String) onChanged;
  final void Function(RecipentAddressModel) onEdit;
  final void Function(String) onDismissed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipientAddressBloc, RecipientAddressState>(
      builder: (context, state) {
        print('123');
        print(state.selectedRecipentAddressID);
        List<RecipentAddressModel> recipientAddressModels =
            state.recipientAddressModels;
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: recipientAddressModels.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
              ),
              onDismissed: (_) {
                onDismissed(recipientAddressModels[index].id);
              },
              child: _AddressCard(
                recipentAddressModel: recipientAddressModels[index],
                value: recipientAddressModels[index].id,
                groupValue: state.selectedRecipentAddressID,
                onChanged: onChanged,
                onEdit: onEdit,
              ),
            );
          },
        );
      },
    );
  }
}

class _AddressCard extends StatelessWidget {
  const _AddressCard({
    required this.recipentAddressModel,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.onEdit,
    Key? key,
  }) : super(key: key);
  final RecipentAddressModel recipentAddressModel;
  final String value;
  final String? groupValue;
  final ValueChanged<String> onChanged;
  final void Function(RecipentAddressModel) onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CustomRadioOption<String>(
                    value: value,
                    groupValue: groupValue,
                    onChanged: onChanged,
                    backgroundColor: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                    ),
                    child: Text(
                      recipentAddressModel.addressName,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.darkBlue,
                        fontWeight: AppFonts.heavy,
                        fontSize: AppFonts.sizeLarge,
                      ),
                    ),
                  )
                ],
              ),
              IconButton(
                icon: SvgPicture.asset(
                  AppIcons.editBox,
                ),
                onPressed: () {
                  onEdit(recipentAddressModel);
                },
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          AddressCard(
            recipentAddressModel: recipentAddressModel,
          ),
        ],
      ),
    );
  }
}
