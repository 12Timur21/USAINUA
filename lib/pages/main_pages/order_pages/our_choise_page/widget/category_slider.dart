import 'package:flutter/material.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';

class CategorySlider extends StatefulWidget {
  const CategorySlider({Key? key}) : super(key: key);

  @override
  State<CategorySlider> createState() => _CategorySliderState();
}

class _CategorySliderState extends State<CategorySlider> {
  final List<String> _categories = [
    'Топ товары',
    'Обувь',
    'Одежда',
    'Электроника',
  ];

  String? _selectedCategory;

  @override
  void initState() {
    _selectedCategory = _categories[0];
    super.initState();
  }

  void selectCategory(String selectedCategory) {
    setState(() {
      _selectedCategory = selectedCategory;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          bool isSelected = _categories[index] == _selectedCategory;
          return Padding(
            padding: index == 0
                ? EdgeInsets.zero
                : const EdgeInsets.only(
                    left: 20,
                  ),
            child: TextButton(
              onPressed: () {
                selectCategory(_categories[index]);
              },
              child: Text(
                _categories[index],
                style: TextStyle(
                  color: isSelected ? AppColors.lightBlue : AppColors.darkBlue,
                  fontWeight: AppFonts.bold,
                  fontSize: AppFonts.sizeSmall,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
