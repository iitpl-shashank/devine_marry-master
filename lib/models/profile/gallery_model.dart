class GalleryModel {
  final bool? status;
  final Data? data;
  final String? message;

  GalleryModel({
    this.status,
    this.data,
    this.message,
  });

  // Factory method to create a GalleryModel from JSON
  factory GalleryModel.fromJson(Map<String, dynamic> json) {
    return GalleryModel(
      status: json['status'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      message: json['message'],
    );
  }

  // Method to convert a GalleryModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data?.toJson(),
      'message': message,
    };
  }
}

class Data {
  final List<ImageData>? images;
  final int? count;

  Data({
    this.images,
    this.count,
  });

  // Factory method to create a Data object from JSON
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      images: json['images'] != null
          ? (json['images'] as List)
              .map((image) => ImageData.fromJson(image))
              .toList()
          : null,
      count: json['count'],
    );
  }

  // Method to convert a Data object to JSON
  Map<String, dynamic> toJson() {
    return {
      'images': images?.map((image) => image.toJson()).toList(),
      'count': count,
    };
  }
}

class ImageData {
  final int? id;
  final String? image;

  ImageData({
    this.id,
    this.image,
  });

  // Factory method to create an ImageData object from JSON
  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      id: json['id'],
      image: json['image'],
    );
  }

  // Method to convert an ImageData object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
    };
  }
}
