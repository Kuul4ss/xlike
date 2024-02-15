import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xlike/app/posts/widgets/delete_icon.dart';
import 'package:xlike/app/posts/widgets/edit_icon.dart';
import 'package:xlike/models/domain/comment.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({
    super.key,
    required this.comment,
    this.showAdminButton = false,
    this.onUpdate,
    this.onDelete,
  });

  final Comment comment;
  final bool showAdminButton;
  final VoidCallback? onUpdate;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        color: Colors.white70,
        margin: const EdgeInsets.symmetric(horizontal: 20),
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
                          comment.author?.name ?? "anonymous",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.fromMillisecondsSinceEpoch(comment.createdAt ?? 0)),
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  if (showAdminButton) ...{
                    DeleteIcon(
                      onTap: () => onDelete,
                    ),
                    EditIcon(
                      onTap: () => onUpdate,
                    ),
                  }
                ],
              ),
              const SizedBox(height: 10.0),
              Text(comment.content.toString()),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      )
    );
  }

}
