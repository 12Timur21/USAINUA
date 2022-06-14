import 'package:equatable/equatable.dart';

class ShoppingMallsModel extends Equatable {
  const ShoppingMallsModel({
    required this.mallName,
    required this.imageUrl,
    required this.linkUrl,
  });
  final String mallName;
  final String imageUrl;
  final String linkUrl;

  @override
  List<Object?> get props => [
        mallName,
        imageUrl,
        linkUrl,
      ];
}
