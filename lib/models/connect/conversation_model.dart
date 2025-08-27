import 'dart:convert';

List<ConversationModel> conversationModelFromJson(String str) =>
    List<ConversationModel>.from(
        json.decode(str).map((x) => ConversationModel.fromJson(x)));

String conversationModelToJson(List<ConversationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ConversationModel {
  final int? id;
  final int? interestingId;
  final int? senderId;
  final int? receiverId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final ErDetails? senderDetails;
  final ErDetails? receiverDetails;
  final List<Message>? messages;

  ConversationModel({
    this.id,
    this.interestingId,
    this.senderId,
    this.receiverId,
    this.createdAt,
    this.updatedAt,
    this.senderDetails,
    this.receiverDetails,
    this.messages,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      ConversationModel(
        id: json["id"],
        interestingId: json["interesting_id"],
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        senderDetails: json["sender_details"] == null
            ? null
            : ErDetails.fromJson(json["sender_details"]),
        receiverDetails: json["receiver_details"] == null
            ? null
            : ErDetails.fromJson(json["receiver_details"]),
        messages: json["messages"] == null
            ? []
            : List<Message>.from(
                json["messages"]!.map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "interesting_id": interestingId,
        "sender_id": senderId,
        "receiver_id": receiverId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "sender_details": senderDetails?.toJson(),
        "receiver_details": receiverDetails?.toJson(),
        "messages": messages == null
            ? []
            : List<dynamic>.from(messages!.map((x) => x.toJson())),
      };
}

class Message {
  final int? id;
  final int? conversationId;
  final int? senderId;
  final int? receiverId;
  final String? message;
  final dynamic file;
  final int? readStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Message({
    this.id,
    this.conversationId,
    this.senderId,
    this.receiverId,
    this.message,
    this.file,
    this.readStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        conversationId: json["conversation_id"],
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        message: json["message"],
        file: json["file"],
        readStatus: json["read_status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "conversation_id": conversationId,
        "sender_id": senderId,
        "receiver_id": receiverId,
        "message": message,
        "file": file,
        "read_status": readStatus,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class ErDetails {
  final int? userId;
  final String? firstName;
  final String? lastName;
  final String? imageUrl;

  ErDetails({
    this.userId,
    this.firstName,
    this.lastName,
    this.imageUrl,
  });

  factory ErDetails.fromJson(Map<String, dynamic> json) => ErDetails(
        userId: json["user_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
        "image_url": imageUrl,
      };
}
