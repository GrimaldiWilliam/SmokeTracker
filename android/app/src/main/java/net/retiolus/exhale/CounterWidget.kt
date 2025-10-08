package it.buonomba.smoketracker

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import java.util.concurrent.TimeUnit

class CounterWidget : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (appWidgetId in appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId)
        }
    }

    override fun onEnabled(context: Context) {
        // Enter relevant functionality for when the first widget is created
    }

    override fun onDisabled(context: Context) {
        // Enter relevant functionality for when the last widget is disabled
    }
}

internal fun updateAppWidget(
    context: Context,
    appWidgetManager: AppWidgetManager,
    appWidgetId: Int
) {
    // Access SharedPreferences to get the last smoked timestamp
    val sharedPreferences: SharedPreferences =
        context.getSharedPreferences("net.retiolus.exhale.PREFS", Context.MODE_PRIVATE)
    val lastSmokedTimestamp = sharedPreferences.getLong("last_smoked", 0L)

    // Calculate the number of days since last smoked
    val currentTime = System.currentTimeMillis()
    val daysSinceLastSmoked = if (lastSmokedTimestamp > 0) {
        TimeUnit.MILLISECONDS.toDays(currentTime - lastSmokedTimestamp)
    } else {
        0 // Default if no timestamp is stored
    }

    // Construct the RemoteViews object
    val views = RemoteViews(context.packageName, R.layout.counter_widget)
    views.setTextViewText(R.id.appwidget_text, "$daysSinceLastSmoked days since last smoked")

    // Update the widget
    appWidgetManager.updateAppWidget(appWidgetId, views)
}
