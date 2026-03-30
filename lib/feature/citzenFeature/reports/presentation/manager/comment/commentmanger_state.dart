import 'package:citifix/feature/citzenFeature/reports/data/Models/commentmodel/commentmodel.dart';

abstract class CommentsState {}

class CommentsInitial extends CommentsState {}

class CommentsLoading extends CommentsState {}

class CommentsSuccess extends CommentsState {
  final List<CommentModel> comments;
  CommentsSuccess(this.comments);
}

class CommentsFailure extends CommentsState {
  final String errorMessage;
  CommentsFailure(this.errorMessage);
}