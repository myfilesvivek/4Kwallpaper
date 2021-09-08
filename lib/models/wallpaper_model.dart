import 'package:get/get.dart';

class WallpaperModel {
  int? id;
  String? category;
  String? wallpaperType;
  String? colorCode;
  String? wallpaperKey;
  String? uploadDate;
  String? imageURLLow;

  int downloads;

  String? title;
  String? description;
  String? imgUrl;
  String? colorName;
  RxBool isFavorite;

    get getImageURLLow => this.imageURLLow;

 set setImageURLLow(String? imageURLLow) => this.imageURLLow = imageURLLow;

  RxBool get getIsFavorite => this.isFavorite;

  set setIsFavorite(RxBool isFavorite) => this.isFavorite = isFavorite;

  get getColorName => this.colorName;

  set setColorName(colorName) => this.colorName = colorName;

  get colorcode => this.colorCode;

  set colorcode(value) => this.colorCode = value;

  String? get getWallpaperType => this.wallpaperType;

  set setWallpaperType(String? wallpaperType) =>
      this.wallpaperType = wallpaperType;

  get getId => this.id;

  set setId(id) => this.id = id;

  get getCategory => this.category;

  set setCategory(category) => this.category = category;

  get getTitle => this.title;

  set setTitle(title) => this.title = title;

  get getDescription => this.description;

  set setDescription(description) => this.description = description;

  get getImgUrl => this.imgUrl;

  set setImgUrl(imgUrl) => this.imgUrl = imgUrl;

  WallpaperModel(
      {this.id,
      this.category,
      this.wallpaperType,
      this.colorCode,
      this.title,
      this.description,
      this.imgUrl,
      this.colorName,
      required this.downloads,
      this.imageURLLow,
      this.uploadDate,
      this.wallpaperKey,
      required this.isFavorite});

  factory WallpaperModel.fromRTDB(Map<String, dynamic> data,String key) {
    print(data.keys);
    return WallpaperModel(
      id: data['id'],
      category: data['category'],
      wallpaperType: data['type'],
      colorCode: data['color_code'],
      title: data['title'],
      description: data['desc'],
      imgUrl: data['url'],
      colorName: data['color_name'],
      downloads: data['downloads'],
      imageURLLow: data['image_url_low'],
      uploadDate: data['uploadDate'],
      wallpaperKey: key,
      isFavorite: false.obs,
    );
  }
}
