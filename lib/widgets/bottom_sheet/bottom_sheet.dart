import 'dart:async';

import 'package:flutter/material.dart';
import 'package:usainua/resources/app_colors.dart';

class CustomBottomSheetState {
  CustomBottomSheetState({
    Key? key,
    this.buttonText,
    required this.bottomSheetTitle,
    this.submitButtonText,
    this.submitButtonColor = const Color.fromRGBO(70, 76, 222, 1),
    this.searchHintText,
    this.searchBackgroundColor = Colors.black12,
    this.searchController,
    required this.dataList,
    this.onselectItems,
    this.onSelectItem,
    this.onSearch,
    this.focusNode,
    required this.enableMultipleSelection,
  });

  /// This gives the button text or it sets default text as 'click me'.
  final String? buttonText;

  /// This gives the bottom sheet title.
  final String bottomSheetTitle;

  /// This will give the submit button text.
  final String? submitButtonText;

  /// This will give the submit button background color.
  final Color? submitButtonColor;

  /// This will give the hint to the search text filed.
  final String? searchHintText;

  /// This will give the background color to the search text filed.
  final Color? searchBackgroundColor;

  /// This will give the default search controller to the search text field.
  final TextEditingController? searchController;

  /// This will give the list of data.
  final Future<List<SelectedListItem>>? Function() dataList;

  /// This will give the call back to the selected items (multiple) from list.
  final void Function(List<String>)? onselectItems;

  /// This will give the call back to the selected item (single) from list.
  final void Function(String value)? onSelectItem;

  final Future<List<SelectedListItem>?> Function(String)? onSearch;

  final FocusNode? focusNode;

  /// This will give selection choise for single or multiple for list.
  final bool enableMultipleSelection;
}

class CustomBottomSheet {
  CustomBottomSheet(this.dropDown);
  CustomBottomSheetState dropDown;

  void showModal(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return _MainBody(
              dropDown: dropDown,
            );
          },
        );
      },
    ).then((value) {
      FocusScope.of(context).unfocus();
    });
  }
}

/// This is Model class. Using this model class, you can add the list of data with title and its selection.
class SelectedListItem {
  SelectedListItem({
    this.isSelected,
    required this.name,
  });
  bool? isSelected;
  String name;
}

/// This is main class to display the bottom sheet body.
class _MainBody extends StatefulWidget {
  const _MainBody({
    required this.dropDown,
    Key? key,
  }) : super(key: key);
  final CustomBottomSheetState dropDown;

  @override
  State<_MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<_MainBody> {
  late final TextEditingController _controller;
  List<SelectedListItem> _mainList = [];
  bool _isLoading = false;

  Future<void> _asyncInit() async {
    setState(() {
      _isLoading = true;
    });
    List<SelectedListItem>? result = await widget.dropDown.dataList();

    setState(() {
      _isLoading = false;
      if (result != null) {
        _mainList = result;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _asyncInit();
    _controller = TextEditingController(
      text: widget.dropDown.searchController?.text,
    );
    _buildSearchList(_controller.text);
  }

  @override
  void didUpdateWidget(covariant _MainBody oldWidget) {
    _asyncInit();
    super.didUpdateWidget(oldWidget);
  }

  Future<void> _buildSearchList(String userSearchTerm) async {
    if (widget.dropDown.onSearch != null) {
      List<SelectedListItem>? result = await widget.dropDown.onSearch!(
        userSearchTerm,
      );
      if (result != null) {
        setState(() {
          _mainList = result;
        });
      }
    } else {
      List<SelectedListItem>? results = await widget.dropDown.dataList();
      results = results
          ?.where(
            (element) => element.name.toLowerCase().contains(
                  userSearchTerm.toLowerCase(),
                ),
          )
          .toList();

      setState(() {
        if (userSearchTerm.isNotEmpty && results != null) {
          _mainList = results;
        }
      });
    }
  }

  void _onClearTap() {
    _controller.clear();

    setState(() {
      _mainList.clear();
    });
  }

  void _onUnfocusKeyboardAndPop() {
    Navigator.of(context).pop();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.13,
      maxChildSize: 0.9,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                      top: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// Bottom sheet title text
                        Text(
                          widget.dropDown.bottomSheetTitle,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        const Spacer(),
                        _DoneButton(
                          isVisible: widget.dropDown.enableMultipleSelection,
                          onTap: () {
                            List<SelectedListItem> selectedList = _mainList
                                .where((element) => element.isSelected == true)
                                .toList();
                            List<String> selectedNameList = [];

                            for (var element in selectedList) {
                              selectedNameList.add(element.name);
                            }

                            widget.dropDown.onselectItems
                                ?.call(selectedNameList);
                            _onUnfocusKeyboardAndPop();
                          },
                          submitButtonColor: widget.dropDown.submitButtonColor,
                          submitButtonText: widget.dropDown.submitButtonText,
                        ),
                      ],
                    ),
                  ),
                  _AppTextField(
                    hintText: widget.dropDown.searchHintText,
                    searchBackgroundColor:
                        widget.dropDown.searchBackgroundColor,
                    onTextChanged: _buildSearchList,
                    onClearTap: _onClearTap,
                    controller: _controller,
                  ),
                  _ListElements(
                    scrollController: scrollController,
                    mainList: _mainList,
                    isMultiSelectMode: widget.dropDown.enableMultipleSelection,
                    onSelectItem: (String value) {
                      widget.dropDown.onSelectItem?.call(
                        value,
                      );
                      _onUnfocusKeyboardAndPop();
                    },
                    onchangeCheckElementStatus: (String value) {
                      setState(() {
                        final SelectedListItem sc = _mainList.firstWhere(
                          (element) => element.name == value,
                        );
                        sc.isSelected = !sc.isSelected!;
                      });
                    },
                  ),
                ],
              );
      },
    );
  }
}

class _DoneButton extends StatelessWidget {
  const _DoneButton({
    this.submitButtonColor,
    this.submitButtonText,
    required this.isVisible,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final VoidCallback onTap;
  final bool isVisible;
  final Color? submitButtonColor;
  final String? submitButtonText;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Align(
        alignment: Alignment.centerRight,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            primary: submitButtonColor ?? Colors.blue,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: Text(
            submitButtonText ?? 'Done',
          ),
        ),
      ),
    );
  }
}

class _ListElements extends StatelessWidget {
  const _ListElements({
    this.scrollController,
    required this.mainList,
    this.isMultiSelectMode = false,
    this.onSelectItem,
    this.onchangeCheckElementStatus,
    Key? key,
  }) : super(key: key);

  final ScrollController? scrollController;
  final List<SelectedListItem> mainList;
  final bool isMultiSelectMode;
  final void Function(String)? onSelectItem;
  final void Function(String)? onchangeCheckElementStatus;

  @override
  Widget build(BuildContext context) {
    /// Listview (list of data with check box for multiple selection & on tile tap single selection)
    return Expanded(
      child: ListView.builder(
        controller: scrollController,
        itemCount: mainList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: isMultiSelectMode
                ? null
                : () => onSelectItem!(
                      mainList[index].name,
                    ),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: ListTile(
                  title: Text(
                    mainList[index].name,
                  ),
                  trailing: isMultiSelectMode
                      ? GestureDetector(
                          onTap: () {
                            onchangeCheckElementStatus!(mainList[index].name);
                          },
                          child: mainList[index].isSelected!
                              ? const Icon(Icons.check_box)
                              : const Icon(Icons.check_box_outline_blank),
                        )
                      : const SizedBox(
                          height: 0.0,
                          width: 0.0,
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _AppTextField extends StatefulWidget {
  const _AppTextField({
    required this.onTextChanged,
    required this.onClearTap,
    this.controller,
    this.hintText,
    this.searchBackgroundColor,
    Key? key,
  }) : super(key: key);
  final String? hintText;
  final Color? searchBackgroundColor;
  final TextEditingController? controller;
  final Function(String) onTextChanged;
  final VoidCallback onClearTap;

  @override
  State<_AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<_AppTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        cursorColor: Colors.black,
        onChanged: (value) {
          widget.onTextChanged(value);
        },
        controller: widget.controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.searchBackgroundColor ?? Colors.black12,
          contentPadding:
              const EdgeInsets.only(left: 0, bottom: 0, top: 0, right: 15),
          hintText: widget.hintText ?? 'Search',
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          prefixIcon: const IconButton(
            icon: Icon(Icons.search),
            onPressed: null,
          ),
          suffixIcon: GestureDetector(
            onTap: widget.onClearTap,
            child: const Icon(
              Icons.cancel,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
