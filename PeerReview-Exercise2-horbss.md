# Code Review for Programming Exercise 2 #

## Due Date and Submission Information ##
See the official course schedule for due date.

A successful submission should consist of a copy of this markdown document template that is modified with your peer-review. The file name should be the same as in the template: PeerReview-Exercise1.md. You also need to include your name and email address in the Peer-reviewer Information section below. This review document should be placed into the base folder of the repo you are reviewing in the master branch. This branch should be on the origin of the repository you are reviewing.

If you are in the rare situation where there are two peer-reviewers on a single repository, append your UC Davis user name before the extension of your review file. An example: PeerReview-Exercise1-username.md. Both reviewers should submit their reviews in the master branch.  

## Solution Assessment ##

## Peer-reviewer Information

* *name:* Harshana Somas
* *email:* hksomas@ucdavis.edu

### Description ###

To assess the solution, you will be choosing ONE choice from unsatisfactory, satisfactory, good, great, or perfect. Place an x character inside of the square braces next to the appropriate label.

The following are the criteria by which you should assess your peer's solution of the exercise's stages.

#### Perfect #### 
    Cannot find any flaws concerning the prompt. Perfectly satisfied all stage objectives.

#### Great ####
    Minor flaws in one or two objectives. 

#### Good #####
    A major flaw and some minor flaws.

#### Satisfactory ####
    A couple of major flaws. Heading towards a solution, however, did not fully realize the solution.

#### Unsatisfactory ####
    Partial work, but not really converging to a solution. Pervasive major flaws. Objective largely unmet.


### Stage 1 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 
The camera works perfectly and is locked to the vessel. The draw camera logic is good as well.

### Stage 2 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### Justification ##### 
The autoscroll works as well, with the draw camera logic creating a box as the boundary for the vessel. My only addition would maybe to change the viewport to be the size of the viewport. I like that the user has to move with the autoscroll as well.

### Stage 3 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### justification ##### 
The camera works here as well. The only thing I would maybe change is to have the camera move to the player itself faster so that it looks less like that player is snapping to the camera instead of the other way around. 

### Stage 4 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### justification ##### 
Works great! Perfect implementation of the camera. 

### Stage 5 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

#### justification ##### 
The camera works perfectly, with the different zones toggling different speeds. The drawn box is perfect as well.

### Overall ###
I also noticed that you tried to add in scaling based on zoom amount which I thought was commendable and worth shouting out in this review. Fantastic implementation of this project. 

## Code Style ##

### Description ###
Check the scripts to see if the student code follows the Godot style guide.

If sections don't adhere to the style guide, please permalink the line of code from GitHub and justify why the line of code has infractions of the style guide.

It should look something like this:

* [description of infraction](https://github.com/dr-jam/ECS189L) - this is the justification.

Here is an example of the permalink drop-down on GitHub.

![Permalink option](../images/permalink_example.png)

Here is another example as well.

* [I go to Github and look at the ICommand script in the ECS189L repo!](https://github.com/dr-jam/ECS189L/blob/1618376092e85ffd63d3af9d9dcc1f2078df2170/Projects/CommandPatternExample/Assets/Scripts/ICommand.cs#L5)

### Code Style Review ###
The code is truly exemplary, with an abundance of comments that follow the style guide. The variables are all well defined and there is no code that is unclear or hard to read. The if statements are well structured and don't make use of multiline commands. 

#### Style Guide Infractions ####
Maybe a little nitpicky, but I noticed some comments that are structured to break up the entire code like this.
https://github.com/ensemble-ai/exercise-2-camera-control-4Clover/blob/26cc1687f09320a833da5bdd3ffb4e02fbaf7c46/Obscura/scripts/camera_controllers/camera_controller_four_way_speed.gd#L27
Not sure if this is in line with the style guide, and I would stick to just keeping it as a regular comment. 

#### Style Guide Exemplars ####
Great way to structure this variable, with the different parts of the boolean statement being split into multiple lines. 
https://github.com/ensemble-ai/exercise-2-camera-control-4Clover/blob/26cc1687f09320a833da5bdd3ffb4e02fbaf7c46/Obscura/scripts/camera_controllers/camera_controller_four_way_speed.gd#L74C1-L75C3

## Best Practices ##

### Best Practices Review ###
One thing I noticed is your use of frequent commits to the github, with about 15 commits made over the course of working on the project. That is a good practice. You use comments to detail what the code is doing and make use of multiple variables to make the code cleaner and easier to read, especially in your four way speed code. 
I also like that you used a separate script to create the crosshair for the cameras that required a crosshair. 

#### Best Practices Infractions ####

#### Best Practices Exemplars ####
https://github.com/ensemble-ai/exercise-2-camera-control-4Clover/blob/26cc1687f09320a833da5bdd3ffb4e02fbaf7c46/Obscura/scripts/camera_controllers/camera_controller_four_way_speed.gd#L61-L84
This is an example of you using multiple variables to make the code cleaner. 
