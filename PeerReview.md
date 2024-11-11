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

* *name:* [Michelle Lu] 
* *email:* [mchlu@ucdavis.edu]

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
Camera remains locked onto the target and the plus symbol is drawn correctly. All the cameras tested also work in hyperspeed mode.

___
### Stage 2 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Camera scrolls to the right at a constant speed, while the target appears to stay still. The target is also unable to leave the confines of the box.

___
### Stage 3 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The target is able to move ahead of the cross, giving the impression that the camera is lagging behind. The camera doesn't exceed a certain leash distance and speeds up when catching back up to the target when the target becomes stationary.

___
### Stage 4 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The cross is able to move ahead of the target, giving the impression of a "look ahead" camera. When the target stops, the camera returns to the target after waiting a set amount of time, and the camera never exceeds it's leash distance.

___
### Stage 5 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
There are 2 boxes correctly drawn. When the target is inside the inner box, the camera doesn't move, but if it's in the outer box, the camera moves in the direction the of the quadrant of the box the player is in when the player also moves in that direction. The target is also unable to escape the outer box, fulfilling all the requirements.
___
# Code Style #


### Description ###
Check the scripts to see if the student code adheres to the GDScript style guide.

If sections do not adhere to the style guide, please peramlink the line of code from Github and justify why the line of code has not followed the style guide.

It should look something like this:

* [description of infraction](https://github.com/dr-jam/ECS189L) - this is the justification.

Please refer to the first code review template on how to do a permalink.


#### Style Guide Infractions ####
I could barely find any style guide infractions, I believe the student has throughly read and memorized the Godot style guide and took care when coding to make it neat and easily accessible.
* [Weird spacing in variable declarations](https://github.com/ensemble-ai/exercise-2-camera-control-4Clover/blob/a9c94769fa00e18d2d4910886f61038ace83602a/Obscura/scripts/camera_controllers/camera_controller_position_lock_lerp.gd#L56) - When drawing the crosshairs, the variable declarations at the top have uneven spacing
* [A single line between functions](https://github.com/ensemble-ai/exercise-2-camera-control-4Clover/blob/a9c94769fa00e18d2d4910886f61038ace83602a/Obscura/scripts/camera_controllers/camera_controller_auto_scroller.gd#L54) - According to the Godot style guide, there should be 2 lines in between functions.
#### Style Guide Exemplars ####
* [Correct exported variable definition](https://github.com/ensemble-ai/exercise-2-camera-control-4Clover/blob/a9c94769fa00e18d2d4910886f61038ace83602a/Obscura/scripts/camera_controllers/camera_controller_auto_scroller.gd#L4) - Exported variables are declared at the very top, and there is spacing aroung the := operators.
* [Correct use of comments](https://github.com/ensemble-ai/exercise-2-camera-control-4Clover/blob/a9c94769fa00e18d2d4910886f61038ace83602a/Obscura/scripts/camera_controllers/camera_controller_lerp_target_focus.gd#L32) - Comments about the code have a space after the #, while code that is commented out do not have the space - this is to distinguish which is a comment for information and which is code that is just disabled.
Almost all the rules in the style guide were followed correctly.
___
#### Put style guide infractures ####
* [Weird spacing in variable declarations](https://github.com/ensemble-ai/exercise-2-camera-control-4Clover/blob/a9c94769fa00e18d2d4910886f61038ace83602a/Obscura/scripts/camera_controllers/camera_controller_position_lock_lerp.gd#L56)
* [A single line between functions](https://github.com/ensemble-ai/exercise-2-camera-control-4Clover/blob/a9c94769fa00e18d2d4910886f61038ace83602a/Obscura/scripts/camera_controllers/camera_controller_auto_scroller.gd#L54)
___

# Best Practices #

### Description ###

If the student has followed best practices then feel free to point at these code segments as examplars. 

If the student has breached the best practices and has done something that should be noted, please add the infraction.


This should be similar to the Code Style justification.

#### Best Practices Infractions ####
* Honestly would not find any infractions of the Godot Best Practices guide, student did well in making their code and project as efficient as possible.

#### Best Practices Exemplars ####
* [snake case](https://github.com/ensemble-ai/exercise-2-camera-control-4Clover/blob/a9c94769fa00e18d2d4910886f61038ace83602a/Obscura/scripts/camera_controllers/camera_controller_four_way_speed.gd#L61) - variables are correctly declared in snake case.
* [_process is used in vessel.gd](https://github.com/ensemble-ai/exercise-2-camera-control-4Clover/blob/a9c94769fa00e18d2d4910886f61038ace83602a/Obscura/scripts/vessel.gd#L14) - Correct use of _process over _physics_process.
