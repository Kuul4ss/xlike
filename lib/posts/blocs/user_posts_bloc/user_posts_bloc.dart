import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:xlike/models/post.dart';
import 'package:xlike/posts/services/posts/posts_repository.dart';

part 'user_posts_event.dart';
part 'user_posts_state.dart';

class UserPostsBloc extends Bloc<UserPostsEvent, UserPostsState> {

  final PostsRepository postsRepository;

  UserPostsBloc({required this.postsRepository}) : super(UserPostsState()) {
    on<GetAllPostsOfUser>(_onGetAllPostOfUser);
  }

  void _onGetAllPostOfUser(GetAllPostsOfUser event, Emitter<UserPostsState> emit) async {
    emit(state.copyWith(status: UserPostsStatus.loading));

    try {
      final posts = await postsRepository.getAllPostsOfUser(event.userId);

      emit(
        state.copyWith(
          status: UserPostsStatus.success,
          posts: posts,
        ),
      );
    } catch (error) {
      emit(state.copyWith(
        status: UserPostsStatus.error,
        error: Exception(),
      ));
    }
  }

}
