part of qiscus_chat_sdk.usecase.app_config;

Option<T> optionFromJson<T>(T json) {
  if ((json is String) && json.isEmpty) {
    return none();
  }
  return optionOf(json);
}

@immutable
class AppConfig {
  final Option<String> baseUrl;
  final Option<String> brokerLbUrl;
  final Option<String> brokerUrl;
  final Option<bool> enableEventReport;
  final Option<bool> enableRealtime;
  final Option<bool> enableRealtimeCheck;
  final Option<Map<String, dynamic>> extras;
  final Option<int> syncInterval;
  final Option<int> syncOnConnect;

  AppConfig({
    @required this.baseUrl,
    @required this.brokerLbUrl,
    @required this.brokerUrl,
    @required this.enableEventReport,
    @required this.enableRealtime,
    @required this.enableRealtimeCheck,
    @required this.extras,
    @required this.syncInterval,
    @required this.syncOnConnect,
  });

  factory AppConfig.fromJson(Map<String, dynamic> json) {
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
          return none<Map<String, dynamic>>();
        }
      })(json['extras'] as String),
    );
  }

  void hydrateStorage(Storage s) {
    baseUrl.do_((it) => s.baseUrl = it);
    brokerLbUrl.do_((it) => s.brokerLbUrl = it);
    brokerUrl.map((it) => s.brokerUrl = it);
    enableEventReport.do_((it) => s.enableEventReport = it);
    enableRealtime.do_((it) => s.isRealtimeEnabled = it);
    enableRealtimeCheck.do_((it) => s.isRealtimeCheckEnabled = it);
    syncInterval.do_((it) => s.syncInterval = it.milliseconds);
    syncOnConnect.do_((it) => s.syncIntervalWhenConnected = it.milliseconds);
    extras.do_((it) => s.configExtras = it);
  }
}
