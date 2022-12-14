import '../auth_model.dart';

class SearchPostModel {
  String? _id;
  String? title;
  int? commentsCount;
  int? upvotes;
  Map<String, String>? subreddit;
  // Map<String, String>? user;
  User? user;
  List<String>? images;
  String? text;
  DateTime? creationDate;
  DateTime? publishDate;
  Duration? durantion;

  SearchPostModel.fromJson(Map<String, dynamic> json) {
    _id = json['_id'];
    title = json['title'];
    commentsCount = json['commentCount'];
    upvotes = json['upvotes'];
    subreddit = json['subreddit'];
    user = User.fromJson(json['user']);
    images = List<String>.from(json['images']);
    text = json['text'];
    creationDate = DateTime.parse(json['createdDate']);
    publishDate = DateTime.parse(json['publishedDate']);
    durantion = DateTime.now()
        .difference(publishDate ?? creationDate ?? DateTime.now());
    subreddit = json['subreddit'];
    user = json['user'];
  }
}
