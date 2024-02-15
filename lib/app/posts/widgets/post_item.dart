import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:xlike/models/domain/post.dart';

class PostItem extends StatelessWidget {
  const PostItem({
    super.key,
    required this.post,
    this.onTap,
  });

  final Post post;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    child: Icon(Icons.person, size: 20.0, color: Colors.white),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          post.author?.name ?? "anonymous",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text(
                          DateFormat('yyyy-MM-dd – kk:mm').format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  post.createdAt ?? 0)),
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (post.image != null && post.image!.url != null) ...[
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Center(
                    child: Image.network(
                      post.image!.url!,
                      height: 200,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 10.0),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 120,
                ),
                child: Text(
                  post.content.toString(),
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.comment, size: 20.0, color: Colors.grey),
                  const SizedBox(width: 5.0),
                  Text(post.commentsCount.toString()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
