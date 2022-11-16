import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/model/post_model.dart';
import '../../data/repository/history_page_repository.dart';

part 'history_page_state.dart';

class HistoryPageCubit extends Cubit<HistoryPageState> {
  final HistoryPageRepository subredditPageRepository;
  List<PostModel>? _postsInPageModels;

  HistoryPageCubit(this.subredditPageRepository)
      : super(SubredditPageInitial());

  void getHistoryPage(String userID, String mode) {
    emit(HistoryPagePostsLoading());

    subredditPageRepository.getPostsInHistoryPage(userID, mode).then((value) {
      _postsInPageModels = value;
      emit(HistoryPagePostsLoaded(_postsInPageModels!));
    });
  }

  void buttonPressed() {
    emit(ButtonPressed());
  }
}
