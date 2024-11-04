# Peer-Review for Programming Exercise 2 #

## Description ##

For this assignment, you will be giving feedback on the completeness of assignment two: Obscura. To do so, we will give you a rubric to provide feedback. Please give positive criticism and suggestions on how to fix segments of code.

You only need to review code modified or created by the student you are reviewing. You do not have to check the code and project files that the instructor gave out.

Abusive or hateful language or comments will not be tolerated and will result in a grade penalty or be considered a breach of the UC Davis Code of Academic Conduct.

If there are any questions at any point, please email the TA.   

## Due Date and Submission Information
See the official course schedule for due date.

A successful submission should consist of a copy of this markdown document template that is modified with your peer review. This review document should be placed into the base folder of the repo you are reviewing in the master branch. The file name should be the same as in the template: `CodeReview-Exercise2.md`. You must also include your name and email address in the `Peer-reviewer Information` section below.

If you are in a rare situation where two peer-reviewers are on a single repository, append your UC Davis user name before the extension of your review file. An example: `CodeReview-Exercise2-username.md`. Both reviewers should submit their reviews in the master branch.  

# Solution Assessment #

## Peer-reviewer Information

* *name:* Abhimanyu Warrier
* *email:* avwarrier@ucdavis.edu

### Description ###

For assessing the solution, you will be choosing ONE choice from: unsatisfactory, satisfactory, good, great, or perfect.

The break down of each of these labels for the solution assessment.

#### Perfect #### 
    Can't find any flaws with the prompt. Perfectly satisfied all stage objectives.

#### Great ####
    Minor flaws in one or two objectives. 

#### Good #####
    Major flaw and some minor flaws.

#### Satisfactory ####
    Couple of major flaws. Heading towards solution, however did not fully realize solution.

#### Unsatisfactory ####
    Partial work, not converging to a solution. Pervasive Major flaws. Objective largely unmet.


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


### Description ###
Check the scripts to see if the student code adheres to the dotnet style guide.

If sections do not adhere to the style guide, please peramlink the line of code from Github and justify why the line of code has not followed the style guide.

It should look something like this:

* [description of infraction](https://github.com/dr-jam/ECS189L) - this is the justification.

Please refer to the first code review template on how to do a permalink.


#### Style Guide Infractions ####
Overall the code adhered to the Godot Style Guide very closely, but there were a couple issues.
- The code here for the [move_toward()](https://github.com/ensemble-ai/exercise-2-camera-control-WengZixuanZLXW/blob/351c8155141a0a43e5bce98f4fa9a7695ea62c69/Obscura/scripts/camera_controllers/camera_stage3.gd#L33) function is very long and hard to read without a lot of screen space which is an infraction on the style guide. Maybe using the parenthesis and having it be multiline would make it easier to read and better fit the style guide such as how it is done [here](https://github.com/ensemble-ai/exercise-2-camera-control-WengZixuanZLXW/blob/351c8155141a0a43e5bce98f4fa9a7695ea62c69/Obscura/scripts/camera_controllers/camera_stage2.gd#L28)
- Same case in the [if statement made below for leash checking](https://github.com/ensemble-ai/exercise-2-camera-control-WengZixuanZLXW/blob/351c8155141a0a43e5bce98f4fa9a7695ea62c69/Obscura/scripts/camera_controllers/camera_stage3.gd#L41), where the line is very long. Here, the vector2 could have been initialized in the previous line on its own and then used in the if statement for simplicity.

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

### Description ###

If the student has followed best practices (Unity coding conventions from the StyleGuides document) then feel free to point at these code segments as examplars. 

If the student has breached the best practices and has done something that should be noted, please add the infraction.


This should be similar to the Code Style justification.

#### Best Practices Infractions ####

#### Best Practices Exemplars ####
