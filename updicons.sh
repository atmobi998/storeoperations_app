#!/bin/sh

for i in android/app/src/main/res/mipmap-*/ic_launcher.png ; do cp assets/Icon-1024.png $i ; done
 sips sips -Z 192 android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png
 sips -Z 192 android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png
 sips -Z 144 android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png
 sips -Z 96 android/app/src/main/res/mipmap-xhdpi/ic_launcher.png
 sips -Z 48 android/app/src/main/res/mipmap-mdpi/ic_launcher.png
 sips -Z 72 android/app/src/main/res/mipmap-hdpi/ic_launcher.png
 for i in ios/Runner/Assets.xcassets/AppIcon.appiconset/*;do cp assets/Icon-1024.png $i ; done
 sips ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-83.5x83.5@2x.png -Z 167 
 sips ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@2x.png -Z 152 
 sips ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@1x.png -Z 76
 sips ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@3x.png -Z 180
 sips ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@2x.png -Z 120 
 sips ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@3x.png -Z 120
 sips ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@2x.png -Z 80
 sips ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@1x.png -Z 40
 sips ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@3x.png -Z 87
 sips ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@2x.png -Z 58
 sips ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@1x.png -Z 29
 sips ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@3x.png -Z 60
 sips ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@2x.png -Z 40
 sips ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@1x.png -Z 20

