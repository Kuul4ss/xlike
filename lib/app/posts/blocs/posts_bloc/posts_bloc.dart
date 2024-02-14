import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:xlike/models/domain/post.dart';
import 'package:xlike/models/requests/request_pagination_info.dart';
import 'package:xlike/services/posts/posts_repository.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {

  final PostsRepository postsRepository;

  PostsBloc({required this.postsRepository}) : super(PostsState()) {
    on<GetAllPosts>(_onGetAllPosts);
  }

  void _onGetAllPosts(GetAllPosts event, Emitter<PostsState> emit) async {
    emit(state.copyWith(status: PostsStatus.loading));

    try {
      final posts = await postsRepository.getAllPosts();

      emit(state.copyWith(
        status: PostsStatus.success,
        posts: posts,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: PostsStatus.error,
        error: Exception(),
      ));
    }
  }


}
