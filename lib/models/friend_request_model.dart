enum FriendRequestStatus { pending, accepted, declined }

class FriendRequestModel {
  final String id;
  final String senderId;
  final String receiverId;
  final FriendRequestStatus status;
  final DateTime createdAt;
  final DateTime? responseAt;
  final String? message;

  FriendRequestModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    this.status = FriendRequestStatus.pending,
    required this.createdAt,
    this.responseAt,
    this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'status': status.name,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'responseAt': responseAt?.millisecondsSinceEpoch,
      'message': message,
    };
  }

  static FriendRequestModel fromMap(Map<String, dynamic> map) {
    return FriendRequestModel(
      id: map['id'] ?? '',
      senderId: map['senderId'] ?? '',
      receiverId: map['receiverId'] ?? '',
      status: FriendRequestStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => FriendRequestStatus.pending,
      ),
      createdAt: _parseDateTime(map['createdAt']),
      responseAt: map['responseAt'] != null
          ? _parseDateTime(map['responseAt'])
          : null,
      message: map['message'],
    );
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value);
    }
    if (value is String) {
      return DateTime.fromMillisecondsSinceEpoch(int.tryParse(value) ?? 0);
    }
    if (value is DateTime) {
      return value;
    }
    return DateTime.fromMillisecondsSinceEpoch(0);
  }

  FriendRequestModel copyWith({
    String? id,
    String? senderId,
    String? receiverId,
    FriendRequestStatus? status,
    DateTime? createdAt,
    DateTime? responseAt,
    String? message,
  }) {
    return FriendRequestModel(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      responseAt: responseAt ?? this.responseAt,
      message: message ?? this.message,
    );
  }
}
