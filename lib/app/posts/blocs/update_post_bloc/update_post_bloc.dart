import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:xlike/models/domain/post.dart';
import 'package:xlike/models/requests/update_post_request.dart';
import 'package:xlike/services/posts/posts_repository.dart';

part 'update_post_event.dart';
part 'update_post_state.dart';

class UpdatePostBloc extends Bloc<UpdatePostEvent, UpdatePostState> {
  final PostsRepository postsRepository;

  UpdatePostBloc({required this.postsRepository}) : super(UpdatePostState()) {
    on<UpdatePost>(_onUpdatePost);
  }

  void _onUpdatePost(UpdatePost event, Emitter<UpdatePostState> emit) async {
    emit(state.copyWith(
      status: UpdatePostStatus.loading,
    ));

    try {
      final post = await postsRepository.updatePost(event.request);

      emit(
        state.copyWith(
          status: UpdatePostStatus.success,
          post: post,
        ),
      );
    } catch (error) {
      emit(state.copyWith(
        status: UpdatePostStatus.error,
        error: Exception(),
      ));
    }
  }
}
