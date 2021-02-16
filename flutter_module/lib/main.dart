import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final model = CounterModel();

  runApp(
    ChangeNotifierProvider.value(
      value: model,
      child: MyApp(),
    ),
  );
}

class CounterModel extends ChangeNotifier {
  CounterModel() {
    _channel.setMethodCallHandler(_handleMessage);
    _channel.invokeMethod('requestCounter');
  }

  final _channel = MethodChannel('com.example/counter');

  int _count = 0;

  int get count => _count;

  void increment() {
    _channel.invokeMethod('incrementCounter');
  }

  Future<dynamic> _handleMessage(MethodCall call) async {
    if (call.method == 'reportCounter') {
      _count = call.arguments as int;
      notifyListeners();
    }
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Module Title',
      routes: {
        '/': (context) => FullScreenView(),
        '/mini': (context) => Contents(),
      },
    );
  }
}


class FullScreenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Full-screen Flutter'),
      ),
      body: Contents(),
    );
  }
}


class Contents extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return SizedBox.expand(
      child: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: .25,
              child: FittedBox(
                fit: BoxFit.cover,
                child: FlutterLogo(),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 16),
                Consumer<CounterModel>(
                  builder: (context, model, child) {
                    return Text(
                      'Taps: ${model.count}',
                      style: Theme.of(context).textTheme.headline5,
                    );
                  },
                ),
                SizedBox(height: 16),
                Consumer<CounterModel>(
                  builder: (context, model, child) {
                    return ElevatedButton(
                      onPressed: () => model.increment(),
                      child: Text('Tap me!'),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
