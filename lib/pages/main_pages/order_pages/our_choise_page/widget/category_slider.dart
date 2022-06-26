import 'package:flutter/material.dart';
import 'package:usainua/resources/app_colors.dart';
import 'package:usainua/resources/app_fonts.dart';
import 'package:usainua/utils/constants.dart';

class CategorySlider extends StatefulWidget {
  const CategorySlider({
    required this.onChange,
    this.activeCategory = WebsiteSections.popular,
    Key? key,
  }) : super(key: key);

  final Function(WebsiteSections value) onChange;
  final WebsiteSections activeCategory;

  @override
  State<CategorySlider> createState() => _CategorySliderState();
}

class _CategorySliderState extends State<CategorySlider> {
  final List<WebsiteSections> _categories = [
    WebsiteSections.popular,
    WebsiteSections.clothes,
    WebsiteSections.shoes,
    WebsiteSections.electronics,
  ];

  WebsiteSections? _selectedCategory;

  @override
  void initState() {
    _selectedCategory = widget.activeCategory;
    super.initState();
  }

  void _selectCategory(WebsiteSections selectedCategory) {
    setState(() {
      _selectedCategory = selectedCategory;
    });
    widget.onChange(selectedCategory);
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
                _selectCategory(_categories[index]);
              },
              child: Text(
                _categories[index].displayTitle,
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
