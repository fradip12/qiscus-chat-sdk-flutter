part of qiscus_chat_sdk.usecase.app_config;

Option<T> optionFromJson<T extends Object?>(T json) {
  if ((json is String) && json.isEmpty) {
    return Option<T>.none();
  }
  return Option<T>.fromNullable(json);
}

class AppConfig {
  final Option<String> baseUrl;
  final Option<String> brokerLbUrl;
  final Option<String> brokerUrl;
  final Option<bool> enableEventReport;
  final Option<bool> enableRealtime;
  final Option<bool> enableRealtimeCheck;
  final Option<Json> extras;
  final Option<int> syncInterval;
  final Option<int> syncOnConnect;
  final Option<bool> enableSync;
  final Option<bool> enableSyncEvent;

  AppConfig({
    required this.baseUrl,
    required this.brokerLbUrl,
    required this.brokerUrl,
    required this.enableEventReport,
    required this.enableRealtime,
    required this.enableRealtimeCheck,
    required this.extras,
    required this.syncInterval,
    required this.syncOnConnect,
    required this.enableSync,
    required this.enableSyncEvent,
  });

  factory AppConfig.fromJson(Json json) {
    return AppConfig(
      baseUrl: optionFromJson<String>(json['base_url'] as String),
      brokerLbUrl: optionFromJson<String>(json['broker_lb_url'] as String),
      brokerUrl: optionFromJson(json['broker_url'] as String),
      enableEventReport: optionFromJson(json['enable_event_report'] as bool),
      enableRealtime: optionFromJson(json['enable_realtime'] as bool),
      enableRealtimeCheck:
          optionFromJson(json['enable_realtime_check'] as bool),
      syncInterval: optionFromJson(json['sync_interval'] as int),
      syncOnConnect: optionFromJson(json['sync_on_connect'] as int),
      extras: ((dynamic extras) {
        if ((extras is String) && extras.isNotEmpty) {
          return decodeJson(extras);
        } else {
          return Option<Json>.none();
        }
      })(json['extras']),
      enableSync: optionFromJson(json['enable_sync'] as bool?) //
          .map((t) => t ?? false),
      enableSyncEvent: optionFromJson(json['enable_sync_event'] as bool?) //
          .map((t) => t ?? true),
    );
  }

  State<Storage, void> hydrate() {
    return State<Storage, void>((s) {
      baseUrl.match(() => null, (t) => s.baseUrl = t);
      // brokerLbUrl.match((it) => s.brokerLbUrl = it, () {});
      brokerLbUrl.match(() => null, (t) => s.brokerLbUrl = t);
      // brokerUrl.match((it) => s.brokerUrl = it, () {});
      brokerUrl.match(() => null, (t) => s.brokerUrl = t);
      // enableEventReport.match((it) => s.enableEventReport = it, () {});
      enableEventReport.match(() => null, (t) => s.enableEventReport = t);
      // enableRealtime.match((it) => s.isRealtimeEnabled = it, () {});
      enableRealtime.match(() => null, (t) => s.isRealtimeEnabled = t);
      // enableRealtimeCheck.match((it) => s.isRealtimeCheckEnabled = it, () {});
      enableRealtimeCheck.match(
          () => null, (t) => s.isRealtimeCheckEnabled = t);
      // syncInterval.match((it) => s.syncInterval = it.milliseconds, () {});
      syncInterval.match(() => null, (t) => s.syncInterval = t.milliseconds);
      // syncOnConnect.match(
      //   (it) => s.syncIntervalWhenConnected = it.milliseconds,
      //   () {},
      // );
      syncOnConnect.match(
          () => null, (t) => s.syncIntervalWhenConnected = t.milliseconds);
      // extras.match((it) => s.configExtras = it, () {});
      extras.match(() => null, (t) => s.configExtras = t);
      // enableSync.match((v) => s.isSyncEnabled = v, () {});
      enableSync.match(() => null, (t) => s.isSyncEnabled = t);
      // enableSyncEvent.match((v) => s.isSyncEventEnabled = v, () {});
      enableSyncEvent.match(() => null, (t) => s.isSyncEventEnabled = t);

      return Tuple2(null, s);
    });
  }
}
