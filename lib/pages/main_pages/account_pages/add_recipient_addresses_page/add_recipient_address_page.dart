import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/phone_input_formatter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:usainua/blocs/recipient_address_bloc/recipient_address_bloc.dart';
import 'package:usainua/models/new_post_models/city_model.dart';
import 'package:usainua/models/new_post_models/region_model.dart';
import 'package:usainua/models/new_post_models/street_model.dart';
import 'package:usainua/models/new_post_models/new_post_warehouse_model.dart';
import 'package:usainua/models/recipient_address_model.dart';
import 'package:usainua/pages/main_pages/account_pages/recipient_addresses_page/recipient_addresses_page.dart';
import 'package:usainua/repositories/firestore_repository.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/services/new_post_service.dart';
import 'package:usainua/utils/validators/is_valid_validator.dart';
import 'package:usainua/utils/validators/phone_validator.dart';
import 'package:usainua/widgets/app_bars/custom_app_bar.dart';
import 'package:usainua/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:usainua/widgets/buttons/submit_button.dart';
import 'package:usainua/widgets/select_widgets/select_new_post_delivery.dart';
import 'package:usainua/widgets/text_fields/text_field_with_custom_label.dart';
import 'package:uuid/uuid.dart';

class AddRecipientAddressPage extends StatefulWidget {
  const AddRecipientAddressPage({
    this.recipentAddressModel,
    Key? key,
  }) : super(key: key);

  final RecipentAddressModel? recipentAddressModel;

  static const routeName = '/recipient_adresses_page';

  @override
  State<AddRecipientAddressPage> createState() =>
      _AddRecipientAddressPageState();
}

class _AddRecipientAddressPageState extends State<AddRecipientAddressPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isEditMode = false;

  final _addressNameController = TextEditingController();
  DeliveryType _deliveryType = DeliveryType.department;
  final _userNameController = TextEditingController();
  final _userSurnameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _regionController = TextEditingController();
  final _cityController = TextEditingController();

  final _warehouseController = TextEditingController();

  final _streetController = TextEditingController();
  final _houseNumberController = TextEditingController();
  final _apartmentNumberController = TextEditingController();

  RegionModel? _regionModel;
  CityModel? _cityModel;
  StreetModel? _streetModel;
  NewPostWarehouseModel? _warehouseModel;

  @override
  void initState() {
    RecipentAddressModel? recipentAddressModel = widget.recipentAddressModel;
    if (recipentAddressModel != null) {
      _isEditMode = true;
      _addressNameController.text = recipentAddressModel.addressName;
      _deliveryType = recipentAddressModel.deliveryType;
      _userNameController.text = recipentAddressModel.name;
      _userSurnameController.text = recipentAddressModel.surname;
      _phoneNumberController.text = recipentAddressModel.phoneNumber;

      _regionModel = recipentAddressModel.regionModel;
      _regionController.text = _regionModel!.regionName;

      _cityModel = recipentAddressModel.cityModel;
      _cityController.text =
          '${_cityModel!.settlementTypeDescription} ${_cityModel!.cityName}';

      if (_deliveryType == DeliveryType.department) {
        _warehouseModel = recipentAddressModel.warehouseModel;
        _warehouseController.text = _warehouseModel!.warehouseName;
      } else {
        _streetModel = recipentAddressModel.streetModel;
        _streetController.text =
            '${_streetModel!.streetType} ${_streetModel!.streetName}';

        _houseNumberController.text = recipentAddressModel.houseNumber ?? '';
        _apartmentNumberController.text =
            recipentAddressModel.apartmentNumber ?? '';
      }
    }

    super.initState();
  }

  Future<void> _validateAndSave() async {
    final bool isValid = _formKey.currentState?.validate() ?? false;
    if (isValid) {
      late final RecipentAddressModel recipientAddressesPage;
      final String id = widget.recipentAddressModel?.id ?? const Uuid().v4();
      if (_deliveryType == DeliveryType.department) {
        recipientAddressesPage = RecipentAddressModel(
          id: id,
          addressName: _addressNameController.text,
          deliveryType: _deliveryType,
          name: _userNameController.text,
          surname: _userSurnameController.text,
          phoneNumber: _phoneNumberController.text,
          regionModel: _regionModel!,
          cityModel: _cityModel!,
          warehouseModel: _warehouseModel!,
        );
      } else {
        recipientAddressesPage = RecipentAddressModel(
          id: id,
          addressName: _addressNameController.text,
          deliveryType: _deliveryType,
          name: _userNameController.text,
          surname: _userSurnameController.text,
          phoneNumber: _phoneNumberController.text,
          regionModel: _regionModel!,
          cityModel: _cityModel!,
          streetModel: _streetModel!,
          houseNumber: _houseNumberController.text,
          apartmentNumber: _apartmentNumberController.text,
        );
      }

      Navigator.of(context).pop(
        recipientAddressesPage,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        onLeading: () {
          Navigator.of(context).pop();
        },
        text: 'Адреса получателей',
      ),
      body: Container(
        margin: const EdgeInsets.only(
          top: 20,
          left: 24,
          right: 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'Добавьте новый адрес для доставки и используйте его по умолчанию',
                style: TextStyle(
                  color: AppColors.darkBlue,
                  fontSize: AppFonts.sizeXSmall,
                  fontWeight: AppFonts.regular,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFieldWithCustomLabel(
                      controller: _addressNameController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      validator: MultiValidator([
                        LengthRangeValidator(
                          min: 1,
                          max: 20,
                          errorText:
                              'Укажите название адреса (дом, офис и т.п.)',
                        )
                      ]),
                      hintText: 'Название адреса (дом, офис и т.п.)',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SelectNewPostDeliveryMethod(
                      selectedDeliveryMethod: _deliveryType,
                      onChange: (DeliveryType value) {
                        setState(() {
                          _deliveryType = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWithCustomLabel(
                      controller: _userNameController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      validator: MultiValidator([
                        LengthRangeValidator(
                          min: 1,
                          max: 20,
                          errorText: 'Имя',
                        )
                      ]),
                      hintText: 'Имя*',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWithCustomLabel(
                      controller: _userSurnameController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      validator: MultiValidator([
                        LengthRangeValidator(
                          min: 1,
                          max: 20,
                          errorText: 'Фамилия',
                        )
                      ]),
                      hintText: 'Фамилия*',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWithCustomLabel(
                      controller: _phoneNumberController,
                      textInputAction: TextInputAction.next,
                      hintText: 'Ваш номер телефона*',
                      keyboardType: TextInputType.phone,
                      formatters: [
                        PhoneInputFormatter(),
                      ],
                      validator: MultiValidator([
                        MinLengthValidator(
                          1,
                          errorText: 'Укажите номер телефона',
                        ),
                        PhoneValidator(
                          errorText: 'Укажите корректный номер телефона',
                        ),
                      ]),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _RegionDropDown(
                      controller: _regionController,
                      onSelect: (RegionModel value) {
                        setState(() {
                          _regionModel = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _CityDropDown(
                      controller: _cityController,
                      regionRef: _regionModel?.ref,
                      onSelect: (CityModel value) {
                        setState(() {
                          _cityModel = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (_deliveryType == DeliveryType.department) ...{
                      _WarehouseDropDown(
                        controller: _warehouseController,
                        cityRef: _cityModel?.cityRef,
                        onSelect: (NewPostWarehouseModel value) {
                          setState(() {
                            _warehouseModel = value;
                          });
                        },
                      ),
                    } else ...{
                      _AddressDelivery(
                        cityRef: _cityModel?.cityRef,
                        onStreetSelect: (StreetModel model) {
                          setState(() {
                            _streetModel = model;
                          });
                        },
                        streetcontroller: _streetController,
                        apartmentcontroller: _apartmentNumberController,
                        houseController: _houseNumberController,
                      ),
                    },
                    const SizedBox(
                      height: 20,
                    ),
                    SubmitButton(
                      text: 'Сохранить',
                      onTap: _validateAndSave,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddressDelivery extends StatefulWidget {
  const _AddressDelivery({
    required this.houseController,
    required this.apartmentcontroller,
    required this.streetcontroller,
    required this.cityRef,
    required this.onStreetSelect,
    Key? key,
  }) : super(key: key);
  final TextEditingController houseController;
  final TextEditingController apartmentcontroller;

  final TextEditingController streetcontroller;
  final String? cityRef;
  final void Function(StreetModel) onStreetSelect;

  @override
  State<_AddressDelivery> createState() => _AddressDeliveryState();
}

class _AddressDeliveryState extends State<_AddressDelivery> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _StreetDropDown(
          controller: widget.streetcontroller,
          cityRef: widget.cityRef,
          onSelect: widget.onStreetSelect,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: TextFieldWithCustomLabel(
                controller: widget.houseController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                maxLength: 10,
                hintText: 'Номер дома',
                onChanged: (_) {
                  setState(() {});
                },
                isDisable: widget.apartmentcontroller.text.isNotEmpty,
                validator: MultiValidator([
                  IsValidValidator(
                    widget.houseController.text.isNotEmpty ||
                        widget.apartmentcontroller.text.isNotEmpty,
                    errorText: 'Заполните одно из полей',
                  ),
                ]),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextFieldWithCustomLabel(
                controller: widget.apartmentcontroller,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                maxLength: 10,
                hintText: 'Номер квартиры',
                onChanged: (_) {
                  setState(() {});
                },
                isDisable: widget.houseController.text.isNotEmpty,
                validator: MultiValidator([
                  IsValidValidator(
                    widget.houseController.text.isNotEmpty ||
                        widget.apartmentcontroller.text.isNotEmpty,
                    errorText: '',
                  ),
                ]),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _RegionDropDown extends StatefulWidget {
  const _RegionDropDown({
    required this.controller,
    required this.onSelect,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final void Function(RegionModel) onSelect;

  @override
  State<_RegionDropDown> createState() => __RegionDropDownState();
}

class __RegionDropDownState extends State<_RegionDropDown> {
  CustomBottomSheet? _customBottomSheet;
  List<RegionModel> _regionModels = [];
  @override
  void initState() {
    _customBottomSheet = CustomBottomSheet(
      CustomBottomSheetState(
        submitButtonText: 'Готово',
        searchHintText: 'Выберите регион*',
        bottomSheetTitle: 'Регион',
        searchController: widget.controller,
        dataList: _getInitData,
        onSelectItem: (String value) {
          RegionModel regionModel = _regionModels.firstWhere(
            (element) => element.regionName == value,
          );
          widget.controller.text = regionModel.regionName;
          widget.onSelect(regionModel);
        },
        enableMultipleSelection: false,
      ),
    );
    super.initState();
  }

  Future<List<SelectedListItem>> _getInitData() async {
    final List<SelectedListItem> selectedItemModels = [];
    _regionModels = await NewPostService.instance.getRegions();

    for (RegionModel element in _regionModels) {
      selectedItemModels.add(
        SelectedListItem(name: element.regionName),
      );
    }

    return selectedItemModels;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldWithCustomLabel(
          controller: widget.controller,
          onTap: () {
            _customBottomSheet?.showModal(context);
          },
          hintText: 'Регион*',
          readOnly: true,
          validator: MultiValidator([
            MinLengthValidator(
              1,
              errorText: 'Выберите регион*',
            ),
          ]),
        ),
      ],
    );
  }
}

class _CityDropDown extends StatefulWidget {
  const _CityDropDown({
    required this.controller,
    required this.regionRef,
    required this.onSelect,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final String? regionRef;
  final void Function(CityModel) onSelect;

  @override
  State<_CityDropDown> createState() => __CityDropDownState();
}

class __CityDropDownState extends State<_CityDropDown> {
  late final CustomBottomSheet _customBottomSheet;
  List<CityModel> _cityModels = [];

  final List<SelectedListItem> _selectedItemModels = [];

  @override
  void initState() {
    _customBottomSheet = CustomBottomSheet(
      CustomBottomSheetState(
        submitButtonText: 'Готово',
        searchHintText: 'Выберите город*',
        bottomSheetTitle: 'Город',
        searchController: widget.controller,
        dataList: () async {
          return _selectedItemModels;
        },
        onSearch: _onSearch,
        onSelectItem: (String value) {
          CityModel cityModel = _cityModels.firstWhere(
            (element) => element.cityName == value,
          );
          widget.controller.text =
              '${cityModel.settlementTypeDescription} ${cityModel.cityName}';
          widget.onSelect(cityModel);
        },
        enableMultipleSelection: false,
      ),
    );
    super.initState();
  }

  Future<List<SelectedListItem>?> _onSearch(String value) async {
    _cityModels = await NewPostService.instance.getCities(
      cityName: value,
      regionRef: widget.regionRef!,
    );

    _selectedItemModels.clear();
    for (CityModel element in _cityModels) {
      _selectedItemModels.add(
        SelectedListItem(name: element.cityName),
      );
    }

    return _selectedItemModels;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldWithCustomLabel(
          controller: widget.controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onTap: () {
            _customBottomSheet.showModal(context);
          },
          hintText: 'Город*',
          isDisable: widget.regionRef == null,
          readOnly: true,
          validator: MultiValidator([
            MinLengthValidator(
              1,
              errorText: 'Выберите город',
            ),
          ]),
        ),
      ],
    );
  }
}

class _StreetDropDown extends StatefulWidget {
  const _StreetDropDown({
    required this.controller,
    required this.cityRef,
    required this.onSelect,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final String? cityRef;
  final void Function(StreetModel) onSelect;

  @override
  State<_StreetDropDown> createState() => _StreetDropDownState();
}

class _StreetDropDownState extends State<_StreetDropDown> {
  late final CustomBottomSheet _customBottomSheet;
  List<StreetModel> _streetModels = [];
  List<SelectedListItem> _selectedItemModels = [];

  @override
  void initState() {
    _customBottomSheet = CustomBottomSheet(
      CustomBottomSheetState(
        submitButtonText: 'Готово',
        searchHintText: 'Выберите улицу*',
        bottomSheetTitle: 'Улица',
        searchController: widget.controller,
        dataList: _getInitData,
        onSearch: _onSearch,
        onSelectItem: (String value) {
          StreetModel streetModel = _streetModels.firstWhere(
            (element) => element.streetName == value,
          );
          widget.controller.text =
              '${streetModel.streetType} ${streetModel.streetName}';
          widget.onSelect(streetModel);
        },
        enableMultipleSelection: false,
      ),
    );
    super.initState();
  }

  Future<List<SelectedListItem>?> _onSearch(String value) async {
    _streetModels = await NewPostService.instance.getStreets(
      streetName: value,
      cityRef: widget.cityRef!,
    );

    _selectedItemModels.clear();

    for (StreetModel element in _streetModels) {
      _selectedItemModels.add(
        SelectedListItem(name: element.streetName),
      );
    }

    return _selectedItemModels;
  }

  Future<List<SelectedListItem>> _getInitData() async {
    _streetModels = await NewPostService.instance.getStreets(
      streetName: '',
      cityRef: widget.cityRef!,
    );
    _selectedItemModels.clear();

    for (StreetModel element in _streetModels) {
      _selectedItemModels.add(
        SelectedListItem(name: element.streetName),
      );
    }

    return _selectedItemModels;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldWithCustomLabel(
          controller: widget.controller,
          onTap: () {
            _customBottomSheet.showModal(context);
          },
          hintText: 'Улица*',
          readOnly: true,
          isDisable: widget.cityRef == null,
          validator: MultiValidator([
            MinLengthValidator(
              1,
              errorText: 'Выберите улицу*',
            ),
          ]),
        ),
      ],
    );
  }
}

class _WarehouseDropDown extends StatefulWidget {
  const _WarehouseDropDown({
    required this.controller,
    required this.cityRef,
    required this.onSelect,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final String? cityRef;
  final void Function(NewPostWarehouseModel) onSelect;

  @override
  State<_WarehouseDropDown> createState() => __WarehouseDropDownState();
}

class __WarehouseDropDownState extends State<_WarehouseDropDown> {
  late final CustomBottomSheet _customBottomSheet;

  List<NewPostWarehouseModel> _warehouseModels = [];

  Future<List<SelectedListItem>> _getData() async {
    List<SelectedListItem> selectedItemModels = [];

    _warehouseModels = await NewPostService.instance.getWarehouses(
      cityRef: widget.cityRef!,
    );

    for (NewPostWarehouseModel element in _warehouseModels) {
      selectedItemModels.add(
        SelectedListItem(name: element.warehouseName),
      );
    }

    return selectedItemModels;
  }

  @override
  void initState() {
    _customBottomSheet = CustomBottomSheet(
      CustomBottomSheetState(
        submitButtonText: 'Готово',
        searchHintText: 'Выберите отделение*',
        bottomSheetTitle: 'Отделение новой почты',
        searchController: widget.controller,
        dataList: _getData,
        onSelectItem: (String value) {
          NewPostWarehouseModel warehouseModel = _warehouseModels.firstWhere(
            (element) => element.warehouseName == value,
          );
          widget.controller.text = warehouseModel.warehouseName;
          widget.onSelect(warehouseModel);
        },
        enableMultipleSelection: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldWithCustomLabel(
          controller: widget.controller,
          onTap: () {
            _customBottomSheet.showModal(context);
          },
          hintText: 'Отделение новой почты*',
          readOnly: true,
          isDisable: widget.cityRef == null,
          validator: MultiValidator([
            MinLengthValidator(
              1,
              errorText: 'Выберите отделение новой почты*',
            ),
          ]),
        ),
      ],
    );
  }
}
