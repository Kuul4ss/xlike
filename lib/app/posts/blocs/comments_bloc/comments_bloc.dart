import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:xlike/models/domain/comment.dart';
import 'package:xlike/models/requests/create_comment_request.dart';
import 'package:xlike/services/comments/comments_repository.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {

  final CommentsRepository commentsRepository;

  CommentsBloc({required this.commentsRepository}) : super(CommentsState()) {
    on<AddComment>(_onAddComment);
  }

  void _onAddComment(AddComment event, Emitter<CommentsState> emit) async {
    emit(state.copyWith(status: CommentsStatus.addingComment));

    try {
      await commentsRepository.addComment(event.request);

      emit(state.copyWith(
        status: CommentsStatus.success,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: CommentsStatus.error,
        error: Exception(),
      ));
    }
  }

}
