import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:qiscus_chat_sdk/src/core.dart';
import 'package:qiscus_chat_sdk/src/domain/room/room-model.dart';
import 'package:qiscus_chat_sdk/src/impls/room/room-from-json-impl.dart';

ReaderTaskEither<Dio, String, QChatRoom> createChannelImpl(
  String uniqueId, {
  String? name,
  String? avatarUrl,
  Json? extras,
}) {
  return Reader((Dio dio) {
    return TaskEither.tryCatch(() async {
      var req = GetOrCreateChannelRequest(
        uniqueId: uniqueId,
        name: name,
        avatarUrl: avatarUrl,
        extras: extras,
      );
      return req(dio);
    }, (e, _) => e.toString());
  });
}

class GetOrCreateChannelRequest extends IApiRequest<QChatRoom> {
  const GetOrCreateChannelRequest({
    required this.uniqueId,
    required this.name,
    required this.avatarUrl,
    required this.extras,
  });

  final String uniqueId;
  final String? name;
  final String? avatarUrl;
  final Json? extras;

  @override
  String get url => 'get_or_create_room_with_unique_id';

  @override
  IRequestMethod get method => IRequestMethod.post;

  @override
  Json get body => <String, dynamic>{
        'unique_id': uniqueId,
        'name': name,
        'avatar_url': avatarUrl,
        'options': extras != null ? jsonEncode(extras) : null,
      };

  @override
  QChatRoom format(Json json) {
    return roomFromJson((json['results'] as Map?)?['room'] as Json);
  }
}
