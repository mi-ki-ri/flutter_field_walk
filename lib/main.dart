import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/rendering.dart';
import 'package:flame/keyboard.dart';
import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

class MyGameSubClass extends Game with KeyboardEvents {
  Sprite player;
  double x = 16.0;
  double y = 16.0;
  Sprite bg;
  Vector2 RECT = Vector2(640, 480);
  Soundpool _pool = Soundpool(streamType: StreamType.notification);

  Future<void> onLoad() async {
    final playerImage = await images.load('standing.png');
    player = Sprite(playerImage, srcPosition: Vector2(x, y), srcSize: RECT);

    final bgImage = await images.load("green.jpg");
    bg = Sprite(bgImage, srcSize: RECT);

// 再生
  }

  @override
  void render(Canvas canvas) async {
    // TODO: implement render
    // inside an async context

    bg.render(canvas);
    player.render(canvas);
  }

  @override
  void update(double t) {
    // TODO: implement update
  }

  @override
  void onKeyEvent(e) async {
    final bool isKeyDown = e is RawKeyDownEvent;
    print(" Key: ${e.data.keyLabel} - isKeyDown: $isKeyDown");
    if (e.data.keyLabel == "d" && isKeyDown == true) {
      x -= 16.0;
    }
    if (e.data.keyLabel == "w" && isKeyDown == true) {
      y += 16.0;
    }
    if (e.data.keyLabel == "a" && isKeyDown == true) {
      x += 16.0;
    }
    if (e.data.keyLabel == "s" && isKeyDown == true) {
      y -= 16.0;
    }
    player.srcPosition = Vector2(x, y);
    int soundId =
        await rootBundle.load("assets/audio/foot.wav").then((soundData) {
      return _pool.load(soundData);
    });
    int streamId = await _pool.play(soundId);
    return;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Botch Quest'),
          ),
          body: Center(
              child: GameWidget(
            game: MyGameSubClass(),
          )))));
}
