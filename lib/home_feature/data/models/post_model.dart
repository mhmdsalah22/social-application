class PostModel {
  final String uId;
  final String dateTime;
  final String text;
  final String postImage;
  final likes;
  final String postId;

  PostModel({
    required this.likes,
    required this.uId,
    required this.dateTime,
    required this.text,
    required this.postImage,
    required this.postId,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      uId: json['uId'],
      dateTime: json['dateTime'],
      text: json['text'],
      postImage: json['postImage'],
      likes: json['likes'],
      postId: json['postId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'dateTime': dateTime,
      'text': text,
      'postImage': postImage,
      'likes': likes,
      'postId': postId,
    };
  }
}
