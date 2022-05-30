import 'package:equatable/equatable.dart';

class ShoppingMallsModel extends Equatable {
  final String mallName;
  final String imageUrl;
  final String linkUrl;

  const ShoppingMallsModel({
    required this.mallName,
    required this.imageUrl,
    required this.linkUrl,
  });

  @override
  List<Object?> get props => [
        mallName,
        imageUrl,
        linkUrl,
      ];
}
