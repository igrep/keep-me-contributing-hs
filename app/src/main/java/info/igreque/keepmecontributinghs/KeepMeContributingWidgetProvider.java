package info.igreque.keepmecontributinghs;

import android.appwidget.AppWidgetManager;
import android.appwidget.AppWidgetProvider;
import android.content.Context;
import info.igreque.android.AppWidgetProviderHs;

public class KeepMeContributingWidgetProvider extends AppWidgetProvider {

    @Override
    public void onUpdate(Context context, AppWidgetManager appWidgetManager, int[] appWidgetIds) {
        KeepMeContributingWidgetProviderHs.onUpdate(context, appWidgetManager, appWidgetIds);
    }
}
