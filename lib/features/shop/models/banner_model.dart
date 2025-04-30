class BannerModel {
  final String? imageUrl;
  final String? targetScreen;
  final bool? active;

  BannerModel({
    this.imageUrl,
    this.targetScreen,
    this.active,
  });

 
  BannerModel copyWith({
    String? imageUrl,
    String? targetScreen,
    bool? active,
  }) {
    return BannerModel(
      imageUrl: imageUrl ?? this.imageUrl,
      targetScreen: targetScreen ?? this.targetScreen,
      active: active ?? this.active,
    );
  }

 
  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'targetScreen': targetScreen,
      'active': active,
    };
  }

  
  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      imageUrl: map['imageUrl'],
      targetScreen: map['targetScreen'],
      active: map['active'],
    );
  }

  @override
  String toString() {
    return 'BannerModel(imageUrl: $imageUrl, targetScreen: $targetScreen, active: $active)';
  }
}