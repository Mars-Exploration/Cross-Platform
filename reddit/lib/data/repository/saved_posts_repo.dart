// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:reddit/data/model/saved_posts_model.dart';

import 'package:reddit/data/web_services/saved_posts_web_services.dart';

/// Repo for Reciveng data from Web Server.
///
/// Then Model it.
/// Then Sending it to Cubit.
class SavedPostsRepository {
  final SavedPostsWebServices savedPostsWebServices;
  SavedPostsModelling savedPostsModelling = SavedPostsModelling();

  SavedPostsRepository({
    required this.savedPostsWebServices,
  });

  Future<SavedPostsModelling> getAllSavedPosts() async {
    final savedPosts = await savedPostsWebServices.getAllSavedPosts();
    print("All saved Posts from repo:");
    print("$savedPosts");
    if (savedPosts != []) {
      savedPostsModelling.datafromJson(savedPosts);
      return savedPostsModelling;
    } else {
      return SavedPostsModelling();
    }
  }
}
