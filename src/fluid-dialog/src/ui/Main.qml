/*
 * This file is part of Liri Browser
 *
 * Copyright (C) 2017 Tim Süberkrüb <tim.sueberkrueb@web.de>
 *
 * $BEGIN_LICENSE:GPL3+$
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * $END_LICENSE$
*/

import QtQuick 2.8
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.0
import Fluid.Controls 1.0

ApplicationWindow {
    visible: true
    maximumWidth: 500
    maximumHeight: layout.childrenRect.height + 2 * Units.smallSpacing
    minimumHeight: maximumHeight
    minimumWidth: maximumWidth
    title: "%1 - Liri Platform".arg(dialogTitle)
    header: Item {}
    flags: Qt.Dialog | Qt.Window
    modality: Qt.ApplicationModal

    ColumnLayout {
        id: layout
        anchors {
            left: parent.left
            right: parent.right
            margins: Units.mediumSpacing
        }
        y: Units.smallSpacing

        spacing: Units.smallSpacing

        TitleLabel {
            text: dialogTitle
        }

        ThinDivider { Layout.fillWidth: true }

        SubheadingLabel {
            Layout.fillWidth: true
            text: dialogMessage
            wrapMode: Text.WordWrap
        }

        Rectangle {
            visible: dialogCode
            Layout.fillWidth: true
            Layout.preferredHeight: childrenRect.height + 2 * Units.smallSpacing
            color: Material.color(Material.BlueGrey)
            radius: 2

            TextField {
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Units.mediumSpacing
                }
                y: Units.smallSpacing
                selectByMouse: true
                readOnly: true
                background: Item {}
                text: dialogCode
                wrapMode: Text.WordWrap
                color: "white"
                font.family: "Roboto Mono"
                onActiveFocusChanged: {
                    // Select everything when gaining
                    // active focus to make copying
                    // the snippet easier
                    if (activeFocus)
                        selectAll();
                }
            }
        }

        Item { Layout.fillHeight: true }    // Spacer

        RowLayout {
            width: parent.width
            Layout.alignment: Qt.AlignBottom

            Item { Layout.fillWidth: true }     // Spacer

            Button {
                Layout.alignment: Qt.AlignRight
                text: "Ok"
                flat: true
                onClicked: {
                    Qt.quit();
                }
            }
        }
    }
}
