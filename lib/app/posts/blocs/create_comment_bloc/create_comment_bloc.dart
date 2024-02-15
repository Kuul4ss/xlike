import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:xlike/models/requests/create_comment_request.dart';
import 'package:xlike/services/comments/comments_repository.dart';

part 'create_comment_event.dart';
part 'create_comment_state.dart';

class CreateCommentBloc extends Bloc<CommentsEvent, CreateCommentState> {

  final CommentsRepository commentsRepository;

  CreateCommentBloc({required this.commentsRepository}) : super(CreateCommentState()) {
    on<WritingComment>(_onWritingComment);
    on<CreateComment>(_onCreateComment);
  }

  void _onCreateComment(CreateComment event, Emitter<CreateCommentState> emit) async {
    emit(state.copyWith(status: CreateCommentStatus.addingComment));

    try {
      await commentsRepository.addComment(event.request);

      emit(state.copyWith(
        status: CreateCommentStatus.success,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: CreateCommentStatus.error,
        error: Exception(),
      ));
    }
  }

  void _onWritingComment(WritingComment event, Emitter<CreateCommentState> emit) {
    emit(state.copyWith(status: CreateCommentStatus.writingComment));
    print('**** writing comment ***');
  }

}
