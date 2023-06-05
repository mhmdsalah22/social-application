import 'package:equatable/equatable.dart';

class SocialUserModel extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String uId;
  final String image;
  final String cover;
  final String bio;
  final List followers;
  final List following;

  const SocialUserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.cover,
    required this.uId,
    required this.bio,
    required this.followers,
    required this.following,
  });

  factory SocialUserModel.fromJson(Map<String, dynamic> json) {
    return SocialUserModel(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      image: json['image'],
      cover: json['cover'],
      uId: json['uId'],
      bio: json['bio'],
      followers: json['followers'],
      following: json['following'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'cover': cover,
      'uId': uId,
      'bio': bio,
      'following': following,
      'followers': followers
    };
  }

  @override
  List<Object?> get props =>
      [name, email, phone, uId, cover, image, bio, following, followers];
}
