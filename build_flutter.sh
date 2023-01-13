#!/bin/bash
cd flutter
./build_web.sh
cd ../
cp flutter/build/web/main.dart.js atlassian_forge/static/flutter-game/build/
