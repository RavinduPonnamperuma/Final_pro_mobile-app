import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:provider/provider.dart';
import 'login_page.dart';
import 'mqtt/MqttDataNotifier.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings = const InitializationSettings(
    android: initializationSettingsAndroid,
  );
  flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(
    ChangeNotifierProvider(
      create: (_) => MqttDataNotifier(),
      child: MyApp(),
    ),

  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  late MqttService mqttService;

  @override
  void initState() {
    super.initState();
    mqttService = MqttService(
      navigatorKey,
      Provider.of<MqttDataNotifier>(context, listen: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class MqttService {
  final String serverUri = '15.235.192.41';
  final int port = 1883;
  final String clientId = 'flutter_client';
  final String username = 'sadee';
  final String password = 'qwerty';
  final GlobalKey<NavigatorState> navigatorKey;
  List<String> notifications = [];
  final MqttDataNotifier dataNotifier;


  MqttServerClient? client;

  MqttService(this.navigatorKey, this.dataNotifier) {
    client = MqttServerClient(serverUri, clientId);
    client?.port = port;
    client?.keepAlivePeriod = 20;
    client?.onDisconnected = onDisconnected;
    client?.onConnected = onConnected;
    client?.logging(on: true);

    final connMessage = MqttConnectMessage()
        .withClientIdentifier(clientId)
        .authenticateAs(username, password)
        .keepAliveFor(20)
        .withWillTopic('willtopic')
        .withWillMessage('My Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    client?.connectionMessage = connMessage;
  }

  Future<void> connect() async {
    try {
      await client?.connect(username, password);
      if (client?.connectionStatus?.state == MqttConnectionState.connected) {
        print('MQTT client connected');
        client?.subscribe('esp/output1', MqttQos.atMostOnce);
        client?.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
          final String topic = c[0].topic;
          if (topic == 'esp/output1') {
            final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
            final String payload = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

            try {
              final Map<String, dynamic> message = jsonDecode(payload);

              final double humidity = message['humidity'] ?? 0.0;
              final double temperature = message['temperature'] ?? 0.0;
              final double moisture = message['moisture'] ?? 0.0;

              print('Humidity: $humidity');
              print('Temperature: $temperature');
              print('Moisture: $moisture');

              final String messageContent = 'Humidity: $humidity, Temperature: $temperature, Moisture: $moisture';
              print(messageContent);


            } catch (e) {
              print('Failed to decode message: $e');
            }
          }
        });


      } else {
        print('ERROR: MQTT client connection failed - '
            'status is ${client?.connectionStatus}');
        client?.disconnect();
      }
    } catch (e) {
      print('Exception: $e');
      client?.disconnect();
    }
  }


  void onConnected() {
    print('Connected to the broker');
  }

  void onDisconnected() {
    print('Disconnected from the broker');
  }

  void disconnect() {
    client?.disconnect();
  }
}
