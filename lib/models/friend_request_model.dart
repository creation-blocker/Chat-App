enum FriendRequestStatus { pending, accepted, declined }

class FriendRequestModel {
  final String id;
  final String senderId;
  final String receiverid;
  final FriendRequestStatus status;
  final DateTime createdAt;
  final DateTime? responseAt;
  final String? message;

  FriendRequestModel({
    required this.id,
    required this.senderId,
    required this.receiverid,
    this.status = FriendRequestStatus.pending,
    required this.createdAt,
    this.responseAt,
    this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'senderId': senderId,
      'receiverid': receiverid,
      'status': status,
      'createdAt': createdAt,
      'responseAt': responseAt?.millisecondsSinceEpoch,
      'message': message,
    };
  }

  static FriendRequestModel fromMap(Map<String, dynamic> map) {
    return FriendRequestModel(
      id: map['id'] ?? '',
      senderId: map['senderId'] ?? '',
      receiverid: map['receiverid'] ?? '',
      status: FriendRequestStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => FriendRequestStatus.pending,
      ),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] ?? 0),
      responseAt: map['responseAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['responseAt'])
          : null,
      message: map['message'],
    );
  }

  FriendRequestModel copyWith({
    String? id,
    String? senderId,
    String? receiverid,
    FriendRequestStatus? status,
    DateTime? createdAt,
    DateTime? responseAt,
    String? message,
  }) {
    return FriendRequestModel(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      receiverid: receiverid ?? this.receiverid,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      responseAt: responseAt ?? this.responseAt,
      message: message ?? this.message,
    );
  }
}
