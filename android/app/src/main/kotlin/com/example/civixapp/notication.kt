package com.example.citifix

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.os.Build
import android.graphics.Color
import android.widget.RemoteViews
import androidx.core.app.NotificationCompat
import android.media.AudioAttributes
import android.net.Uri

object Notifications {
    const val NOTIFICATION_ID_BACKGROUND_SERVICE = 1
    private const val CHANNEL_ID_BACKGROUND_SERVICE = "channelId"

    fun createNotificationChannels(context: Context) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val soundUri: Uri = Uri.parse(
                "android.resource://" + context.packageName + "/raw/mixkitlongpop2358"
            )

            val audioAttributes = AudioAttributes.Builder()
                .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
                .setUsage(AudioAttributes.USAGE_NOTIFICATION_RINGTONE)
                .build()

            val channel = NotificationChannel(
                CHANNEL_ID_BACKGROUND_SERVICE,
                "Background Service",
                NotificationManager.IMPORTANCE_HIGH
            )
            channel.setSound(soundUri, audioAttributes)

            val manager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            manager.createNotificationChannel(channel)
        }
    }

    fun buildForegroundNotification(context: Context): Notification {
    val customLayout = RemoteViews(context.packageName, R.layout.custom_notification)

    return NotificationCompat.Builder(context, CHANNEL_ID_BACKGROUND_SERVICE)
        .setSmallIcon(R.mipmap.ic_launcher)
        .setCustomContentView(customLayout) 
        .setCustomBigContentView(customLayout)
        .setPriority(NotificationCompat.PRIORITY_MAX)
        .setCategory(NotificationCompat.CATEGORY_SERVICE)
        .setOngoing(true)
        .build()
}
}