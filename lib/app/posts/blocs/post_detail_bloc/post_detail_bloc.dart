import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:xlike/models/domain/post.dart';
import 'package:xlike/services/posts/posts_repository.dart';

part 'post_detail_event.dart';
part 'post_detail_state.dart';

class PostDetailBloc extends Bloc<PostDetailEvent, PostDetailState> {

  final PostsRepository postsRepository;

  PostDetailBloc({required this.postsRepository}) : super(PostDetailState()) {
    on<GetPostDetail>(_onGetPostDetail);
  }

  void _onGetPostDetail(GetPostDetail event, Emitter<PostDetailState> emit) async {
    emit(state.copyWith(status: PostDetailStatus.loading));

    try {
      final post = await postsRepository.getPostDetail(event.id);

      emit(
        state.copyWith(
          status: PostDetailStatus.success,
          post: post,
        ),
      );
    } catch (error) {
      emit(state.copyWith(
        status: PostDetailStatus.error,
        error: Exception(),
      ));
    }
  }

}
