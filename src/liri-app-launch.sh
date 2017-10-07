#!/bin/bash

# Launch script for Liri Apps using the Liri App Platform
# Sets up environment variables specific to the Liri platform snap
# Originally based on the Qt desktop launcher from
# https://github.com/ubuntu/snapcraft-desktop-helpers

# Additional library paths
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$RUNTIME/usr/local/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$RUNTIME/usr/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$RUNTIME/usr/lib/$ARCH
export PATH=$PATH:$RUNTIME/usr/bin

# Removes Qt warning: Could not find a location
# of the system Compose files
export QTCOMPOSE=$RUNTIME/usr/share/X11/locale

# Qt Libs, Modules and helpers
export LD_LIBRARY_PATH=$RUNTIME/lib/qt5/lib:$LD_LIBRARY_PATH
export QT_PLUGIN_PATH=$RUNTIME/lib/qt5/plugins/
export QML2_IMPORT_PATH=$RUNTIME/usr/lib/qml:$QML2_IMPORT_PATH
export QML2_IMPORT_PATH=$RUNTIME/lib/qt5/qml:$QML2_IMPORT_PATH
export QML2_IMPORT_PATH=$SNAP/lib/qml:$QML2_IMPORT_PATH
export QML2_IMPORT_PATH=$SNAP/usr/lib/qml:$QML2_IMPORT_PATH
export QT_QPA_PLATFORM_PLUGIN_PATH=$RUNTIME/lib/qt5/plugins/platforms
export QT_QPA_PLATFORM_PLUGIN_PATH=$RUNTIME/lib/plugins/platforms:$QT_QPA_PLATFORM_PLUGIN_PATH
[ "$WITH_RUNTIME" = yes ] && QML2_IMPORT_PATH=$SNAP/lib/$ARCH:$SNAP/usr/lib/$ARCH/qt5/qml:$QML2_IMPORT_PATH

# Use GTK styling for running under Gtk based desktop environments
export GTK_PATH=$RUNTIME/usr/lib/$ARCH/gtk-2.0

# Start the generic glib desktop launcher
# from the Ubuntu snapcraft desktop helpers
exec $RUNTIME/bin/desktop-launch "$@"
