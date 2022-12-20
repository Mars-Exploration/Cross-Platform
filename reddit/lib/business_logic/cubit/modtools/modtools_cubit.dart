import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/model/auth_model.dart';
import 'package:reddit/data/model/modtools/taffic_stats_model.dart';
import 'package:reddit/data/model/posts/posts_model.dart';
import 'package:reddit/data/repository/modtools/modtools_repository.dart';

part 'modtools_state.dart';

class ModtoolsCubit extends Cubit<ModtoolsState> {
  final ModToolsRepository repository;
  List<User> approvedUsers = [];
  List<PostsModel> modToolsPosts = [];
  ModtoolsCubit(this.repository) : super(ModtoolsInitial());

  /// [subredditID] is the id of subreddit to which we get the edited posts list
  /// [subredditName] is the name of subreddit to which we get the edited posts list
  /// This function emits state [EditedPostsReady] on initState of the `Queue` widget.
  void getEditedPosts(String subredditName) {
    if (isClosed) return;
    emit(Loading());
    repository.getEditedPosts(subredditName).then((posts) {
      emit(EditedPostsReady(posts));
      modToolsPosts = posts;
    });
  }

  /// [subredditName] is the id of subreddit to which we get the spammed posts list
  /// [subredditName] is the name of subreddit to which we get the spammed posts list
  /// This function emits state [EditedPostsReady] on initState of the `Queue` widget.
  void getSpammedPosts(String subredditName) {
    if (isClosed) return;
    emit(Loading());
    repository.getSpammedPosts(subredditName).then((posts) {
      emit(SpammedPostsReady(posts));
      modToolsPosts = posts;
    });
  }

  /// [subredditName] is the name of subreddit to which we get the unmoderated posts list
  /// This function emits state [EditedPostsReady] on initState of the `Queue` widget.
  void getUnmoderatedPosts(String subredditName) {
    if (isClosed) return;
    emit(Loading());
    repository.getUnmoderatedPosts(subredditName).then((posts) {
      emit(UnmoderatedPostsReady(posts));
      modToolsPosts = posts;
    });
  }

  /// [subredditName] is the name of subreddit to which we get the traffic stats
  /// This function emits state [TrafficStatsAvailable] on initState of the `Traffic stats` page.
  void getStatistics(String subredditName) {
    if (isClosed) return;
    emit(Loading());
    repository.getStatistics(subredditName).then((statistics) {
      emit(TrafficStatsAvailable(statistics));
    });
  }

  /// [subredditId] is the id of subreddit to which we get the approved list
  /// This function emits state [ApprovedListAvailable] on initState of the `UserManagement` widget.
  void getApprovedUsers(String subredditId) {
    if (isClosed) return;
    emit(Loading());
    repository.getAprroved(subredditId).then((aprrovedList) {
      approvedUsers.clear();
      approvedUsers.addAll(aprrovedList.map((user) => User.fromJson(user)));
      emit(ApprovedListAvailable(approvedUsers));
    });
  }

  /// [subredditId] is the id of subreddit to insert an approved user
  /// [username] is the username of the user to be inserted in the approved list
  /// This function emits state [AddedToApprovedUsers] on adding a new user to the approved list or if the user already existed.
  void addApprovedUser(String subredditId, String username) {
    if (isClosed) return;
    bool usernameExist = false;
    approvedUsers.forEach((user) {
      if (user.username == username) {
        usernameExist = true;
      }
    });

    if (usernameExist) {
      repository.getAprroved(subredditId).then((aprrovedList) {
        approvedUsers.clear();
        approvedUsers.addAll(aprrovedList.map((user) => User.fromJson(user)));
        emit(AddedToApprovedUsers(approvedUsers));
        debugPrint('username : $username already exist');
        return;
      });
    } else {
      repository.addApprovedUser(subredditId, username).then((statusCode) {
        if (statusCode == 201) {
          repository.getAprroved(subredditId).then((aprrovedList) {
            approvedUsers.clear();
            approvedUsers
                .addAll(aprrovedList.map((user) => User.fromJson(user)));
            emit(AddedToApprovedUsers(approvedUsers));
          });
        } else {
          emit(WrongUsername());
        }
      });
    }
  }

  /// [subredditId] is the id of subreddit to remove an approved user
  /// [username] is the username of the user to be removed from the approved list
  /// This function emits state [RemovedFromApprovedUsers] removing a user from the approved list.
  void removeApprovedUser(String subredditId, String username) {
    if (isClosed) return;
    repository.removeApprovedUser(subredditId, username).then((statusCode) {
      repository.getAprroved(subredditId).then((aprrovedList) {
        approvedUsers.clear();
        approvedUsers.addAll(aprrovedList.map((user) => User.fromJson(user)));
        emit(RemovedFromApprovedUsers(approvedUsers));
      });
    });
  }
}
