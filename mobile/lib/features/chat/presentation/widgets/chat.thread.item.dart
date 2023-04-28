import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_utils/shared_utils.dart';

class ChatThreadListItem extends StatelessWidget {
  final String message;
  final bool isMe;

  const ChatThreadListItem({
    Key? key,
    required this.isMe,
    this.message = 'Lorem ipsum dolor sit amet',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var avatar = isMe
        ? 'https://images.unsplash.com/photo-1663743629961-c6134ef1afc9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=986&q=40'
        : 'https://images.unsplash.com/photo-1580489944761-15a19d654956?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1361&q=40';

    return Row(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isMe) avatar.avatar(size: 36, circular: true).right(8),
        Container(
          constraints: BoxConstraints(maxWidth: context.width * 0.7),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: isMe
                ? context.colorScheme.secondary
                : context.colorScheme.background,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(16),
              bottomLeft:
                  isMe ? const Radius.circular(16) : const Radius.circular(0),
              topRight:
                  isMe ? const Radius.circular(0) : const Radius.circular(16),
              bottomRight: const Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color:
                    context.colorScheme.onSurface.withOpacity(kEmphasisLowest),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              message.bodyText2(context,
                  color: isMe
                      ? context.colorScheme.onSecondary
                      : context.colorScheme.onBackground),
              const SizedBox(height: 8),
              '12:00 PM'.caption(context,
                  emphasis: kEmphasisLow,
                  color: isMe
                      ? context.colorScheme.onSecondary
                      : context.colorScheme.onBackground),
            ],
          ),
        ),

        // show my profile picture if message is from me
        if (isMe) avatar.avatar(size: 36, circular: true).left(8),
      ],
    );
  }
}
