import 'package:spotify/Features/domain/entities/user.dart';

class UserModel {
  String? userId;
  String? name;
  String? email;
  String? imageUrl;
  String? createdAt;

  UserModel({
     this.userId,
     this.name,
     this.email,
     this.imageUrl,
     this.createdAt,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['uid'];
    name = json['name'];
    email = json['email'];
    imageUrl = json['imageUrl'];
    createdAt = json['createdAt'];
  }
}

extension UserModelX on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      userId: userId,
      name: name,
      email: email,
      imageUrl: imageUrl,
      createdAt: createdAt
    );
  }
}
