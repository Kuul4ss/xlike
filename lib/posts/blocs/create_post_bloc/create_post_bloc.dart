import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:xlike/models/requests/create_post_request.dart';
import 'package:xlike/posts/services/posts/posts_repository.dart';

part 'create_post_event.dart';

part 'create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  final PostsRepository postsRepository;

  CreatePostBloc({required this.postsRepository}) : super(CreatePostState()) {
    on<CreatePost>(_onCreatePost);
  }

  void _onCreatePost(CreatePost event, Emitter<CreatePostState> emit) async {
    emit(state.copyWith(
      status: CreatePostStatus.loading,
    ));

    try {
      await postsRepository.createPost(event.request);

      emit(
        state.copyWith(
          status: CreatePostStatus.success,
        ),
      );
    } catch (error) {
      emit(state.copyWith(
        status: CreatePostStatus.error,
        error: Exception(),
      ));
    }
  }
}
