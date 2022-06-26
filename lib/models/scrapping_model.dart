class ScrappingModel {
  const ScrappingModel({
    required this.title,
    required this.url,
    required this.photoUrl,
    this.oldPrice,
    required this.currentPrice,
  });
  final String title;
  final String url;
  final String photoUrl;
  final int? oldPrice;
  final int currentPrice;

  ScrappingModel copyWith({
    String? title,
    String? url,
    String? photoUrl,
    int? oldPrice,
    int? currentPrice,
  }) {
    return ScrappingModel(
      title: title ?? this.title,
      url: url ?? this.url,
      photoUrl: photoUrl ?? this.photoUrl,
      oldPrice: oldPrice ?? this.oldPrice,
      currentPrice: currentPrice ?? this.currentPrice,
    );
  }
}
