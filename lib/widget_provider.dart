import 'package:home_widget/home_widget.dart';

class WidgetProvider {
  static Future<void> updateCounter(DateTime lastSmoked) async {
    final duration = DateTime.now().difference(lastSmoked);

    final int days = duration.inDays;
    final int hours = duration.inHours % 24;
    final int minutes = duration.inMinutes % 60;

    String time = '${days}d ${hours}h ${minutes}m';

    // Save widget data
    await HomeWidget.saveWidgetData<String>('counter', time);
    await HomeWidget.updateWidget(
      iOSName: 'HomeWidgetExample',
      androidName: 'HomeWidgetExample',
    );
  }
}