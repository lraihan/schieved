import 'package:flutter/scheduler.dart';

class CustomTickerProvider extends TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}
