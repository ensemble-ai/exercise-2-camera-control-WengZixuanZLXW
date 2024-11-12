# Peer-Review for Programming Exercise 2 #

## Peer-reviewer Information

* *name:* Abhimanyu Warrier
* *email:* avwarrier@ucdavis.edu
___

## Solution Assessment ##

### Stage 1 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The camera is correctly centered around the vessel/player and moves at the exact same speed like detailed in the instructions. Additionally when draw_camera_logic is true, the camera draws a 5x5 cross in the center of the screen.

___
### Stage 2 ###

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The camera correctly moves at the autoscroll speed on the x and z axes and the player is able to move within a bounding box. In the example gif, the player can move around freely in the box at its own speed whereas in this implementation, it moves with the box. This is understandable as the instructions were confusing in this aspect and it wasn't clear which approach to take.

___
### Stage 3 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The camera follows the player with a slight delay at a given follow speed and catches up with the given catchup speed when the player is stationary. There is also a leash that limits the player from going too far and when the player reaches the leash, the camera follows the player at the player's speed so it does not exceed the leash. Additionally, the camera is also able to draw a 5x5 unit cross centered on the camera, displaying the said logic.

___
### Stage 4 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The camera moves slightly faster than the character at lead_speed and is also tied by a leash that stops it when the camera gets to a certain distance away from the player in the x and z directions. When the player is stationary, the camera waits (catchup_delay_duration) seconds to center back to the player at catchup speed. The 5x5 cross is also present and centered on the camera to display this logic.

___
### Stage 5 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The camera correctly acts on the player input in the three given scenarios in any direction. When the player is within the inner push_box, the camera does not move. When the player is outside the inner push_box but still within the outer push_box, the camera moves at the player's speed multiplied by a certain push_ratio which is usually < 1 meaning the camera will move slower than the player in that zone. Finally, when the player is touching the outer push_box, the camera moves at the same speed as the player which acts kind of like a leash. There were no errors with this stage and the 2 boxes were drawn properly by the camera when prompeted by draw camera logic being true.
___
# Code Style #

#### Style Guide Infractions ####
Overall the code adhered to the Godot Style Guide very closely, but there were a couple issues.
- The code here for the [move_toward()](https://github.com/ensemble-ai/exercise-2-camera-control-WengZixuanZLXW/blob/351c8155141a0a43e5bce98f4fa9a7695ea62c69/Obscura/scripts/camera_controllers/camera_stage3.gd#L33) function is very long and hard to read without a lot of screen space which is an infraction on the style guide. Maybe using the parenthesis and having it be multiline would make it easier to read and better fit the style guide such as how it is done [here](https://github.com/ensemble-ai/exercise-2-camera-control-WengZixuanZLXW/blob/351c8155141a0a43e5bce98f4fa9a7695ea62c69/Obscura/scripts/camera_controllers/camera_stage2.gd#L28)
- Same case in the [if statement made below for leash checking](https://github.com/ensemble-ai/exercise-2-camera-control-WengZixuanZLXW/blob/351c8155141a0a43e5bce98f4fa9a7695ea62c69/Obscura/scripts/camera_controllers/camera_stage3.gd#L41), where the line is very long. Here, the vector2 could have been initialized in the previous line on its own and then used in the if statement for simplicity.
- One small thing, the student had lots of comments but no whitespace separating the lines making it slightly cramped such as seen [here in this file](https://github.com/ensemble-ai/exercise-2-camera-control-WengZixuanZLXW/blob/ca7a64b1e89eb35439fb1b4372ce074b12578bdf/Obscura/scripts/camera_controllers/camera_stage4.gd#L27) and there were a couple other places where this was done as well.

Not many other infractions, overall the student clearly took the time and effort to make their code style adhere to the guidelines.

#### Style Guide Exemplars ####
There were many exemplars in my opinion that made this project easier to read and understand due to its proper implementation of their code style.
- Overall [variable ordering](https://github.com/ensemble-ai/exercise-2-camera-control-WengZixuanZLXW/blob/351c8155141a0a43e5bce98f4fa9a7695ea62c69/Obscura/scripts/camera_controllers/camera_stage4.gd#L4) in the camera controllers were very good, and followed the styling guidelines. The classnames were also very simple and easy to understand.
- Great use of [comments](https://github.com/ensemble-ai/exercise-2-camera-control-WengZixuanZLXW/blob/351c8155141a0a43e5bce98f4fa9a7695ea62c69/Obscura/scripts/camera_controllers/camera_stage5.gd#L32) all around the project with correct white space usage as well, making the code easy to read and easy to understand.

Nothing else really specific, overall the code was simply organized, well styled, and easy to read and understand
___
#### Put style guide infractures ####

___

# Best Practices #

#### Best Practices Infractions ####
The student clearly did a thorough review of their code and made sure to implement a lot of best practices so there weren't really any examples I could find of a best practice infraction. Additionally, because this assignment did not have too much actual code necessarily being written, it means that there is less room for best practices infractions which is one reason why the student did not have any infractions at all.

#### Best Practices Exemplars ####
There were a couple really good examples of best practices exemplars in this student's implementation
- The implementations of [stage 3](https://github.com/ensemble-ai/exercise-2-camera-control-WengZixuanZLXW/blob/ca7a64b1e89eb35439fb1b4372ce074b12578bdf/Obscura/scripts/camera_controllers/camera_stage3.gd#L36) and [stage 4](https://github.com/ensemble-ai/exercise-2-camera-control-WengZixuanZLXW/blob/ca7a64b1e89eb35439fb1b4372ce074b12578bdf/Obscura/scripts/camera_controllers/camera_stage4.gd#L50) were very well synced together and I could see the student put effort into making the code consistent among different camera controllers which was nice
- The [drawing of the lines](https://github.com/ensemble-ai/exercise-2-camera-control-WengZixuanZLXW/blob/ca7a64b1e89eb35439fb1b4372ce074b12578bdf/Obscura/scripts/camera_controllers/camera_stage5.gd#L63) in the stage 5 implementation was well structured and spaced out, making it easy to understand which line did what
- Classes were named well, variables were also named well and easy to understand, and in-built godot functions were used to simplify the camera process

Overall really great implementation of the different cameras and great work!
