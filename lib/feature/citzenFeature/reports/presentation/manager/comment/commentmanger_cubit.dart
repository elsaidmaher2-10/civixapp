import 'package:citifix/feature/citzenFeature/reports/data/repos/commentRepo/commentRepo.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/manager/comment/commentmanger_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentsCubit extends Cubit<CommentsState> {
  final Commentrepo commentRepo;

  CommentsCubit(this.commentRepo) : super(CommentsInitial());

  Future<void> fetchComments(int id) async {
    if (isClosed) return;
    emit(CommentsLoading());

    final result = await commentRepo.getAllCommentByID(id);

    result.fold(
      (failure) {
        final errorMsg = failure.errors.isNotEmpty
            ? failure.errors[0]
            : "An unexpected error occurred";
        emit(CommentsFailure(errorMsg));
      },
      (comments) {
        if (isClosed) return;
        emit(CommentsSuccess(comments));
      },
    );
  }

  Future<void> makeComments(int id, {required String content}) async {
    if (isClosed) return;
    final result = await commentRepo.makeCommentByID(id, content: content);
    result.fold(
      (failure) {
        final errorMsg = failure.errors.isNotEmpty
            ? failure.errors.join()
            : "An unexpected error occurred";
        emit(CommentsFailure(errorMsg));
      },
      (comments) async {
        await fetchComments(id);
      },
    );
  }
}
