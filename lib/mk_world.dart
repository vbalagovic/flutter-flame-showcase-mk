// Added World
import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_showcase/main.dart';

class MkWorld extends ParallaxComponent<MortalKombat> {
  @override
  Future<void> onLoad() async {

    // Images with custom fill and repeat
    final images = [
      gameRef.loadParallaxImage('p_bg.png', fill: LayerFill.height, repeat: ImageRepeat.repeatX, alignment: Alignment.topLeft),
      gameRef.loadParallaxImage('p_4.png', fill: LayerFill.width, repeat: ImageRepeat.noRepeat),
      gameRef.loadParallaxImage('p_3.png', fill: LayerFill.width, repeat: ImageRepeat.noRepeat),
      gameRef.loadParallaxImage('p_2.gif', fill: LayerFill.width, repeat: ImageRepeat.noRepeat),
      gameRef.loadParallaxImage('p_1.gif', fill: LayerFill.width, repeat: ImageRepeat.noRepeat),
    ];

    // Layers with custom velocity
    final layers = images.map((image) async => ParallaxLayer(
          await image,
          velocityMultiplier: images.indexOf(image) == 0 ? Vector2(20, 0) : Vector2(0, 0),
        ));

    // Create parallax
    final parallaxComponent = ParallaxComponent(
      parallax: Parallax(
        await Future.wait(layers),
        baseVelocity: Vector2(1, 0),
      ),
    );

    // Add parallax to game
    parallax = parallaxComponent.parallax;
  }
}
