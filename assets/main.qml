/*
 * Copyright (c) 2011-2013 BlackBerry Limited.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import bb.cascades 1.2
import bb 1.0

Page {
    attachedObjects: [
        ApplicationInfo {
            id: thisApp
        }
    ]
    ScrollView {
    Container {
        topPadding: 30
        bottomPadding: topPadding
        rightPadding: topPadding
        leftPadding: topPadding
        Container {
            Label {
                horizontalAlignment: HorizontalAlignment.Center
                multiline: true
                text: "Connect2UpFront is a demonstration app controlling UpFront' Active Frame. This is tageted to developers who would like to add UpFront support to their apps. UpFront is a new Active Frame app that allows other apps (like this one) to easily update its Active Frame. Make sure to download UpFront before using this application."
                textStyle.textAlign: TextAlign.Justify
                }
        }
        Divider {}
        Container {
            visible: false
            bottomPadding: 5
            layout: StackLayout {orientation: LayoutOrientation.LeftToRight}
            Label {
                text: "UUID:"
            }
            TextField {
                id: uuid
                text: thisApp.signingHash
                enabled: false
            }
        }
        Container {
            visible: false
            bottomPadding: 5
            layout: StackLayout {orientation: LayoutOrientation.LeftToRight}
            Label {
                text: "App Name:"
            }
            TextField {
                id: appName
                text: thisApp.title
                enabled: false
            }
        }
        Container {
            visible: false
            bottomPadding: 5
            layout: StackLayout {orientation: LayoutOrientation.LeftToRight}
            Label {
                text: "Layout choice:"
            }
            TextField {
                id: layout
                enabled: false
                hintText: "Not available yet"
            }
        }
        Container {
            bottomPadding: 5
            layout: StackLayout {orientation: LayoutOrientation.TopToBottom}
            Label {
                text: "Background image for BlackBerry Z3, BlackBerry Z10 and BlackBerry Z30:"
                multiline: true
            }
            TextField {
                id: backgroundZ
                hintText: "Image URL - Preferred size 334 X 351"
                text: _app.getValueFor("backgroundZ", "");
                onTextChanging: {
                    _app.saveValueFor("backgroundZ", text);
                }
            }
        }
        Container {
            bottomPadding: 5
            layout: StackLayout {orientation: LayoutOrientation.TopToBottom}
            Label {
                text: "Background image for BlackBerry Q5 and BlackBerry Q10:"
                multiline: true
            }
            TextField {
                id: backgroundQ
                hintText: "Image URL - Preferred size 310 X 166"
                text: _app.getValueFor("backgroundQ", "");
                onTextChanging: {
                    _app.saveValueFor("backgroundQ", text);
                }
            }
        }
        Container {
            bottomPadding: 5
            layout: StackLayout {orientation: LayoutOrientation.TopToBottom}
            Label {
                text: "Your app icon:"
            }
            TextField {
                id: icon
                hintText: "Image URL - Preferred size 38 X 38"
                text: _app.getValueFor("icon", "");
                onTextChanging: {
                    _app.saveValueFor("icon", text);
                }
            }
        }
        Container {
            visible: false
            bottomPadding: 5
            layout: StackLayout {orientation: LayoutOrientation.LeftToRight}
            Label {
                text: "Title:"
            }
            TextField {
                id: title
            }
        }
        Container {
            bottomPadding: 5
            layout: StackLayout {orientation: LayoutOrientation.LeftToRight}
            Label {
                text: "Message:"
            }
            TextField {
                id: message
                text: _app.getValueFor("message", "");
                onTextChanging: {
                    _app.saveValueFor("message", text);
                }
            }
        }
        Container {
            bottomPadding: 5
            layout: StackLayout {orientation: LayoutOrientation.LeftToRight}
            Label {
                text: "Seconds available in UpFront:"
            }
            TextField {
                id: seconds
                hintText: "Max 3600"
                text: _app.getValueFor("seconds", "");
                onTextChanging: {
                    _app.saveValueFor("seconds", text);
                }
            }
        }
        Container {
            bottomPadding: 5
            layout: StackLayout {orientation: LayoutOrientation.LeftToRight}
            Label {
                text: "Send to Pebble (if available):"
            }
            ToggleButton {
                id: t2wToggle
                checked: _app.getValueFor("t2w", "false")
                onCheckedChanged: {
                    _app.saveValueFor("t2w", checked);
                }
            }
        }
        Container {
            bottomPadding: 5
            layout: StackLayout {orientation: LayoutOrientation.LeftToRight}
            Label {
                text: "Color:"
            }
            TextField {
                id: textColor
                hintText: "Enter any QML color (default: Gray)"
                text: _app.getValueFor("textColor", "");
                onTextChanging: {
                    _app.saveValueFor("textColor", text);
                }
            }
        }
        Container {
            bottomPadding: 5
            layout: StackLayout {orientation: LayoutOrientation.LeftToRight}
            Label {
                text: "Other:"
            }
            TextField {
                id: other
                hintText: "Not available yet"
                text: _app.getValueFor("other", "");
                onTextChanging: {
                    _app.saveValueFor("other", text);
                }
            }
        }
        Container {
            horizontalAlignment: HorizontalAlignment.Center
            topPadding: 25
            Button {
                text: "Update UpFront"
                onClicked: {
                    _app.updateUpFront(backgroundZ.text, backgroundQ.text, icon.text, message.text, seconds.text, t2wToggle.checked.toString(), textColor.text, other.text)
                    Application.minimize()
                }
            }
        }
    }
}
}
