pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Notifications

Singleton {
    id: root
    
    // List to store active notifications
    property var notifications: []
    property int notificationCount: 0
    
    // Function to add a notification
    function addNotification(notification) {
        var tempList = notifications.slice() 
        tempList.push({
            id: notification.id,
            appName: notification.appName,
            summary: notification.summary,
            body: notification.body,
            icon: notification.image,
            timestamp: Date.now()
        })
        notifications = tempList
        notificationCount = notifications.length 
    }
    
    // Function to remove a notification
    function removeNotification(notifId) {
        notifications = notifications.filter(n => n.id !== notifId)
        notificationCount = notifications.length 
    }
}