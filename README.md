# Mortal Kombat with Flutter Flame (basics) showcase

Flutter application with flame engine that I used for [presentation](https://docs.google.com/presentation/d/1op0C2Z3DihatYnyU8ElI-2gJ5_4Q5ur7Jr4GkCi3_sQ/edit?usp=sharing) on Zagorje DevCon.

Note: all sprites and images are downloaded from [mortalkombatwarehouse](https://www.mortalkombatwarehouse.com/)

## Parallax Component

- Used for background with several layers
- Some have velocity some not

![world](https://user-images.githubusercontent.com/30495155/222731374-01c43d6e-bb83-4104-a3f5-45704a8d7f5c.gif)

## SpriteAnimationGroupComponent

- SpriteAnimationComponent wrapper [Component that has sprites that run in a single cyclic animation]
- hold several animations and change the current playing animation at runtime

![stance](https://user-images.githubusercontent.com/30495155/222732018-677c1754-813c-45d0-97cf-44ad4ded2771.gif)

## Adding Movement (Player extends PositionComponent)

![Movement](https://user-images.githubusercontent.com/30495155/222735800-4ac0d563-41b3-4300-ab74-b956151b63cb.gif)

## Collision Detection

- HasCollisionDetection
- CollisionCallbacks
- Hitboxes

![collision](https://user-images.githubusercontent.com/30495155/222735933-b0d6ae86-4698-4108-bc2b-9a66a525f4c6.gif)

## Overlays

Game overlays enables any Flutter widget to be shown on top of a game instance

![overlay](https://user-images.githubusercontent.com/30495155/222736196-f6358a04-32e2-4536-a858-c5f65bfe93c7.gif)

## Complete Circle Of Game

- Adding multiple overlays
- Triggering functions on game state changes
- Creating gameplay

![complete](https://user-images.githubusercontent.com/30495155/222736232-d6d1c730-259a-4e52-a495-6d96d3cbb0e8.gif)

## Adding sound

- `FlameAudio.bgm.play('music.mp3')`

https://user-images.githubusercontent.com/30495155/222736487-085ff8d3-a3d2-4541-8ebf-243344df4733.mov