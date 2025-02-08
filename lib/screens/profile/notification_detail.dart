import 'dart:convert';

import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/utils/id_replace.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/models/message/message.dart';
import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:cirilla/store/store.dart';
import 'package:ui/ui.dart';

import '../../types/types.dart';

class NotificationDetail extends StatefulWidget {
  static const routeName = '/notification_detail';

  final Map<String, dynamic> args;

  const NotificationDetail({
    super.key,
    required this.args,
  });

  @override
  State<NotificationDetail> createState() => _NotificationDetailState();
}

class _NotificationDetailState extends State<NotificationDetail> with AppBarMixin, NavigationMixin, Utility {
  late AppStore _appStore;
  late MessageStore _messageStore;
  late AuthStore _authStore;
  MessageData? _message;
  Map<String, dynamic>? actionClick;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _authStore = Provider.of<AuthStore>(context);
    _appStore = Provider.of<AppStore>(context);

    String key = "notification_store";

    if (_appStore.getStoreByKey(key) == null) {
      MessageStore store = MessageStore(Provider.of<RequestHelper>(context), _authStore, key: key);

      _appStore.addStore(store);
      _messageStore = store;
    } else {
      _messageStore = _appStore.getStoreByKey(key);
    }

    final message = widget.args['message'];
    if (message is MessageData) {
      _message = message;
      _messageStore.putRead(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_message == null) {
      return Container();
    }

    ThemeData theme = Theme.of(context);

    TextTheme textTheme = theme.textTheme;

    String title = get(_message?.payload, ['title'], '');

    String body = get(_message?.payload, ['body'], '');

    if (_message?.action != null) {
      Map<String, dynamic> action = _message?.action ?? {};
      actionClick = {
        'type': action['type'] ?? '',
        'route': action['route'] ?? '',
        'args': jsonDecode(action['args'] ?? "{}"),
      };
    }

    String? sentTime = _message?.createdAt;

    TextStyle? defaultStyle = textTheme.bodyMedium;

    String? bodyHtml = IdReplace.idReplaceAllMapped(body);

    TranslateType translate = AppLocalizations.of(context)!.translate;

    Widget html = Html(
      data: "<p>$bodyHtml</p>",
      style: {
        'p': Style.fromTextStyle(defaultStyle ?? const TextStyle()),
      },
      extensions: [
        _TagAExtension(
          buildContext: context,
          action: actionClick,
        ),
      ],
    );

    return Theme(
      data: theme.copyWith(canvasColor: Colors.transparent),
      child: Scaffold(
        appBar: baseStyleAppBar(
          context,
          title: translate('notifications_detail_title'),
        ),
        bottomSheet: Padding(
          padding: paddingHorizontal.add(paddingVerticalLarge),
          child: SizedBox(
            height: 48,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => buildDialog(context, _message!),
              style: ElevatedButton.styleFrom(padding: paddingHorizontalLarge),
              child: Text(translate('notifications_detail_delete')),
            ),
          ),
        ),
        body: Column(
          children: [
            NotificationItem(
              onTap: () {},
              title: Text(title, style: textTheme.titleSmall),
              leading: Icon(FeatherIcons.messageCircle, color: theme.primaryColor, size: 22),
              date: Text(
                  sentTime is String && sentTime != 'null' ? formatDate(date: sentTime, dateFormat: 'MMMM d, y') : '',
                  style: textTheme.bodySmall),
              time: Text(sentTime is String && sentTime != 'null' ? formatDate(date: sentTime, dateFormat: 'jm') : '',
                  style: textTheme.bodySmall),
            ),
            Padding(padding: paddingHorizontalLarge, child: html),
          ],
        ),
      ),
    );
  }

  Future<void> buildDialog(BuildContext context, MessageData data) async {
    TranslateType translate = AppLocalizations.of(context)!.translate;
    String? result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(translate('notifications_detail_dialog_title')),
        content: Text(translate('notifications_detail_dialog_description')),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: Text(translate('notifications_detail_dialog_cancel')),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: Text(translate('notifications_detail_dialog_ok')),
          ),
        ],
      ),
    );
    if (result == "OK") {
      if (!_messageStore.loadingData) {
        _messageStore.removeMessageById(id: data.id);
      }
      if (context.mounted) Navigator.of(context).pop();
    }
  }
}

class _TagAExtension extends HtmlExtension with NavigationMixin {

  final BuildContext buildContext;
  final Map<String, dynamic>? action;

  _TagAExtension({
    required this.buildContext,
    this.action,
  });

  @override
  Set<String> get supportedTags => {"a"};

  @override
  InlineSpan build(ExtensionContext context) {
    ThemeData theme = Theme.of(buildContext);

    String txt = context.element?.innerHtml ?? "";
    TextStyle? linkStyle = theme.textTheme.bodyMedium?.copyWith(color: theme.primaryColor);

    return WidgetSpan(
      child: CssBoxWidget(
        style: context.styledElement!.style,
        child: InkWell(
          onTap: () => navigate(buildContext, action),
          child: SizedBox(
            height: 18,
            child: Text(txt, style: linkStyle),
          ),
        ),
      ),
    );
  }
}