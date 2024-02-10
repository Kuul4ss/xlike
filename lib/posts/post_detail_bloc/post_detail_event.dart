part of 'post_detail_bloc.dart';

@immutable
abstract class PostDetailEvent {}

class GetPostDetail extends PostDetailEvent {
  final int id;

  GetPostDetail({required this.id});
}
