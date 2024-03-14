import 'package:qiscus_chat_sdk/src/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:dio/dio.dart';
import 'package:qiscus_chat_sdk/src/domain/room/room-model.dart';
import 'package:qiscus_chat_sdk/src/impls/room/create-channel-impl.dart';

ReaderTaskEither<Dio, String, QChatRoom> getChannelImpl(String uniqueId) {
  return Reader((dio) {
    return TaskEither.tryCatch(() async {
      var req = GetOrCreateChannelRequest(
        uniqueId: uniqueId,
        name: null,
        avatarUrl: null,
        extras: null,
      );
      return req(dio);
    }, (e, _) => e.toString());
  });
}
