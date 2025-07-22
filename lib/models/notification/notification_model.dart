import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  final bool? success;
  final String? message;
  final Data? data;

  NotificationModel({
    this.success,
    this.message,
    this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  final List<Notification>? notifications;
  final Pagination? pagination;

  Data({
    this.notifications,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        notifications: json["notifications"] == null
            ? []
            : List<Notification>.from(
                json["notifications"]!.map((x) => Notification.fromJson(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "notifications": notifications == null
            ? []
            : List<dynamic>.from(notifications!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
      };
}

class Notification {
  final int? id;
  final int? userId;
  final int? senderId;
  final String? title;
  final int? isRead;
  final String? notificationType;
  final dynamic clickUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? senderName;
  final String? senderImageUrl;

  Notification({
    this.id,
    this.userId,
    this.senderId,
    this.title,
    this.isRead,
    this.notificationType,
    this.clickUrl,
    this.createdAt,
    this.updatedAt,
    this.senderName,
    this.senderImageUrl,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["id"],
        userId: json["user_id"],
        senderId: json["sender_id"],
        title: json["title"],
        isRead: json["is_read"],
        notificationType: json["notification_type"],
        clickUrl: json["click_url"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        senderName: json["sender_name"],
        senderImageUrl: json["sender_image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "sender_id": senderId,
        "title": title,
        "is_read": isRead,
        "notification_type": notificationType,
        "click_url": clickUrl,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "sender_name": senderName,
        "sender_image_url": senderImageUrl,
      };
}

class Pagination {
  final int? currentPage;
  final int? totalPages;
  final int? total;
  final int? perPage;

  Pagination({
    this.currentPage,
    this.totalPages,
    this.total,
    this.perPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        currentPage: json["current_page"],
        totalPages: json["total_pages"],
        total: json["total"],
        perPage: json["per_page"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "total_pages": totalPages,
        "total": total,
        "per_page": perPage,
      };
}
