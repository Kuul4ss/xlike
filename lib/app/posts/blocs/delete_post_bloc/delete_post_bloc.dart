import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:xlike/models/requests/create_post_request.dart';
import 'package:xlike/services/posts/posts_repository.dart';

part 'delete_post_event.dart';

part 'delete_post_state.dart';

class DeletePostBloc extends Bloc<DeletePostEvent, DeletePostState> {
  final PostsRepository postsRepository;

  DeletePostBloc({required this.postsRepository}) : super(DeletePostState()) {
    on<DeletePost>(_onDeletePost);
  }

  void _onDeletePost(DeletePost event, Emitter<DeletePostState> emit) async {
    emit(state.copyWith(
      status: DeletePostStatus.loading,
    ));

    try {
      await postsRepository.deletePost(event.postId);

      emit(
        state.copyWith(
          status: DeletePostStatus.success,
        ),
      );
    } catch (error) {
      emit(state.copyWith(
        status: DeletePostStatus.error,
        error: Exception(),
      ));
    }
  }
}
