import 'package:flutter/material.dart';
import 'package:mobile/core/utils/extensions.dart';
import 'package:mobile/features/chat/presentation/widgets/chat.thread.item.dart';
import 'package:mobile/generated/assets.dart';
import 'package:shared_utils/shared_utils.dart';

enum ChatMediaActions {
  scheduleSurvey,
  makeOffer,
  uploadMedia,
}

class ChatPage extends StatefulWidget {
  final dynamic user;

  const ChatPage({Key? key, required this.user}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _messages = [
    'Hello, if you want a survey I am available from 9am to 5pm on weekdays.',
    'Yeah sure, I will be there. We can do it at 10am.',
    'Thank you, I will be waiting for you.',
    'Awesome, see you then.',
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: false,
          titleSpacing: 0,
          toolbarHeight: kToolbarHeight + 16,
          actions: [
            IconButton(
              onPressed: context.showFeatureUnderDevSheet,
              color: context.colorScheme.secondary,
              icon: const Icon(TablerIcons.phone),
            ).right(12),
          ],
          title: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Assets.imgAppLogo.avatar(size: 32, fromAsset: true).right(16),
              AnimatedColumn(
                animateType: AnimateType.slideRight,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.user
                      .toString()
                      .subtitle1(context, weight: FontWeight.w600),
                  context.localizer.recentlyActive
                      .bodyText2(context, emphasis: kEmphasisMedium),
                ],
              ),
            ],
          ),
        ),
        body: DecoratedBox(
          decoration: BoxDecoration(color: context.colorScheme.surface),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration:
                    BoxDecoration(color: context.colorScheme.background),
                // TODO: replace with real data
                child: ListTile(
                  title: 'Blue Sky Apartments'.subtitle1(context),
                  subtitle: '2376 5th Ave, New York, NY 10037'
                      .bodyText2(context, emphasis: kEmphasisMedium),
                  trailing: Icon(TablerIcons.info_circle,
                      color: context.colorScheme.secondary),
                ),
              ),

              // TODO chat UI goes here
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                  itemBuilder: (context, index) => ChatThreadListItem(
                    key: UniqueKey(),
                    isMe: index % 2 != 0,
                    message: _messages[index],
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemCount: _messages.length,
                ),
              ),

              // chat input goes here
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: context.colorScheme.background,
                  boxShadow: [
                    BoxShadow(
                      color: context.colorScheme.onSurface.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: SafeArea(
                  top: false,
                  child: Row(
                    children: [
                      PopupMenuButton(
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem(
                              value: ChatMediaActions.scheduleSurvey,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(TablerIcons.calendar_time,
                                          size: 20)
                                      .right(8),
                                  Text(context.localizer.scheduleSurvey),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: ChatMediaActions.makeOffer,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(TablerIcons.file_dollar, size: 20)
                                      .right(8),
                                  Text(context.localizer.makeOffer),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: ChatMediaActions.uploadMedia,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(TablerIcons.photo_up, size: 20)
                                      .right(8),
                                  Text(context.localizer.uploadMedia),
                                ],
                              ),
                            ),
                          ];
                        },
                        child: const Icon(TablerIcons.script_plus),
                      ).right(16),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: context.localizer.typeMessage,
                            border: InputBorder.none,
                          ),
                          textCapitalization: TextCapitalization.sentences,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.send,
                        ),
                      ),
                      IconButton(
                        onPressed: context.showFeatureUnderDevSheet,
                        icon: const Icon(TablerIcons.send),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
