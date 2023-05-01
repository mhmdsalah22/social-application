class CommentModel {
  final String uId;
  final String datePublished;
  final String text;
  final String commentId;



  CommentModel({
    required this.uId,
    required this.datePublished,
    required this.text,
    required this.commentId,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      uId: json['uId'],
      datePublished: json['datePublished'],
      text: json['text'],
      commentId: json['commentId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'datePublished': datePublished,
      'text': text,
      'commentId': commentId,
    };
  }
}
