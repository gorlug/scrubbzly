#!/bin/bash

flutter build web --web-renderer canvaskit --release --dart-define=FLUTTER_WEB_CANVASKIT_URL=./canvaskit/
cp build/web/main.dart.js backend/sprint-board-sorter-game/static/flutter-game/build/