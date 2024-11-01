# Camera Control Exercise

## Description

Your goal is to create several swappable camera control scripts for a top-down terraforming simulator.

Here is the document covered in class that details the type of camera controllers you are to implement for this exercise:  
[Scroll Back: The Theory and Practice of Cameras in Side-Scrollers](https://docs.google.com/document/d/1iNSQIyNpVGHeak6isbP6AHdHD50gs8MNXF1GCf08efg/pub) by Itay Keren.  

The images in the *Exercise Stages* section are taken from Itay Keren's document.

### Grading

Stage 1 is worth 10 points. Stages 2, 3, 4, and 5 are worth 15 points each. The stages are worth a total of 70 points. The remaining 30 points are for your peer review of another student's submission.

### Due Date and Submission Information

The due date for this exercise is listed in Canvas. The master branch, as found on your individual exercise repository, will be evaluated.

DUE NOV 1 @ 8:00 AM PST

## Exercise Stages 

The following are the basic criteria for each stage:
* Each stage requires you to implement a type of camera controller. 
* Each of your five controllers should extend `CameraControllerBase`. 
* Each of your camera controller implementations should be added as a child of the `World` node in the hierarchy.
* You should bind the `Vessel` node to the `Target` exported field via the editor to your cameras.
* Bind your camera controllers to the `Array[CameraControllerBase]` in the `CameraSelector`.
* Most controllers will require you to expose fields to the editor to allow a designer to parameterize the controller's function (e.g., the size of a bounding box, the speed of scrolling, the speed of learning, etc.). Each controller has its own list of required fields to export.
* Each camera controller should use the `ImmediateMesh` found in `draw_logic()` to visualize the camera controller's logic when the `draw_camera_logic` exported variable is true. The lines should be drawn at the same `z` value as the `Vessel`. See the `PushBoxCamera` class for an example.
* Your camera controllers should be immediately testable by your peer-reviewer and should have `draw_camera_logic` set to true by default and in your submitted project.
~~
## Stage 1 - position lock

This camera controller should always be centered on the `Vessel`. There are no additional fields to be serialized and usable in the inspector.

Your controller should draw a 5 by 5 unit cross in the center of the screen when `draw_camera_logic` is true. 

![position-locking](https://lh6.googleusercontent.com/Bh_vzER7pXFZgRMsi158LA_q3Dg9LnykuR1cW3f8K8hgSI-BlNKLfocuGAhHRxbrcaeadtay_MgS55CO4eD0jyDIy0QB9SvAPHFnWQlDMKfN9QQJkL4RxAKc28_ymrCz) as found in Terraria, ©2011 Re-Logic.

## Stage 2 - framing with horizontal auto-scroll

In the grand tradition of [shmups](http://www.shmups.com/), this camera controller implements a frame-bound autoscroller. The player should be able to move inside a box constantly moving on the `z-x` plane denoted by `autoscroll_speed`. If the player is lagging behind and is touching the left edge of the box, the player should be pushed forward by that box edge.

Your controller should draw the frame border box when `draw_camera_logic` is true. 

Required exported fields:
* `Vector2 top_teft` - the top left corner of the frame border box.
* `Vector2 bottom_right` - the bottom right corner of the frame border box.
* `Vector3 autoscroll_speed` - the number of units per second to scroll along each axis. For this project, you should only scroll on the `x` and `z` axes.

![auto-scroll](https://lh3.googleusercontent.com/ob8Z5bAdjxI6C9hgzL1-EcIPNeUCxCGHuOK7TaQoGtkq0iczuaSw3usLF9oYhqJfrRWQTmsRFTNqoYNoX9KjHTsuOC_auBY68C24FQEN-a3a11bM25xQdfAZ8Ls7RuxS) as found in Scramble, ©1981 Konami.

## Stage 3 - position lock and lerp smoothing

This camera controller generally behaves like the position lock controller from Stage 1. The major difference is that it does not immediately center on the player as the player moves. Instead, it approaches the player's position in `_process()`. It should follow the player at a `follow_speed` that is slower than the player. The camera will catch up to the player when the player is not moving. This approach should be done at `catchup_speed` that can be tuned for game feel. Finally, the distance between the vessel and the camera should never exceed `leash_distance`.

The linear intepolation, or lerp, in this camera is implicit in the parameterization and behavior. If you would like to more explicity use lerp, please do so. The instruction team can help you get started.

Your controller should draw a 5 by 5 unit cross in the center of the screen when `draw_camera_logic` is true.

Required exported fields:
* `float follow_speed` - The speed at which the camera follows the player when the player is moving. This can either be a tuned static value or a ratio of the vessel's speed. 
* `float catchup_speed` - When the player has stopped, what speed shoud the camera move to match the vesse's position.
* `float leash_distance` - The maxiumum allowed distance between the vessel and the center of the camera.

![position-locking with lerp-smoothing](https://lh3.googleusercontent.com/Lo1c9W3Yo0VQzf6mxAssaqXS7RoELziUwPbowklnCsI4BiqR46vYeejQPhjgZla3AR6INwVy6tCoXog4_Yc85DmlPcOapN_DjoRz6CRgD3nvTaGWkPm3cmaNpKj2tWiO) as found in Super Meat Boy, ©2010 Team Meat.

## Stage 4 - lerp smoothing target focus

This stage requires you to create a variant of the position-lock lerp-smoothing controller. The variation is that the center of the camera leads the player in the direction of the player's input. The position of the camera should approach to the player's position when the player stops moving. Much like stage 3's controller, the distance between the camera and target should increase when movement input is given (to a maximum of `leash_distnace`) and the camera should only be settled on the target when it has not moved `catchup_delay_duration`.

Just as in Stage 3, the lerp in this camera is implicit in the parameterization and behavior. If you would like to more explicity use lerp, please do so. The instruction team can help you get started.

Your controller should draw a 5 by 5 unit cross in the center of the screen when `draw_camera_logic` is true.

Required exported fields:
* `float lead_speed` - the speed at which the camera moves toward the direction of the input. This should be faster than the `Vessel`'s movement speed.
* `float catchup_delay_duration` - the time delay between when the target stops moving and when the camera starts to catch up to the target.
* `float catchup_speed` - When the player has stopped, what speed shoud the camera move to match the vesse's position.
* `float leash_distance` - The maxiumum allowed distance between the vessel and the center of the camera.

![lerp-smoothing with target-focus](https://lh3.googleusercontent.com/-zeUJrdvmQnbB8stwBJ-P9spyZVEJIHtxDATQPkniX1hc35Y6oCLXQaqfcCmKn_Sd1cXSHN2MF2BWn1SLmoAvQbg6rCC6h_HQtqEkplanN3iaXjNgDdixCf5SSdw-YTm) as found in Jazz Jackrabbit 2, ©1998 Epic Games.

## Stage 5 - 4-way speedup push zone

This camera controller should implement a 4-directional version of the speedup push zone as seen in Super Mario Bros. The controller should move at the speed of the target multiplied by the `push_ratio` required exported variable in the direction of target's movement when the target is 1) moving, 2) not touching the outer zone pushbox, and 3) are betwen the speedup zone and the pushbox border. When the target is touching one side of the outer pushbox, the camera will move at the target's current movement speed in the direction of the touched side of the border box and at the `push_ratio` in the other direction (e.g., when the target is touching the top middle of the pushing box but is moving to the upper right, the camera will move at the target's speed in the y direction but at the `push_ratio` in the x direction). If the target touches two sides of the outer pushbox (i.e., the player is in the corner of the box), the camera will move at full player speed in both x and y directions. If the target moves within the inner-most area (i.e., inside the speedup zone's border and not between the speedup zone the outer pushbox), the camera should not move.

Your controller should draw the push zone border box when `draw_camera_logic` is true. 

Required exported fields:
* `float push_ratio` - The ratio that the camera should move toward the target when it is not at the edge of the outer pushbox.
* `Vector2 pushbox_top_left` - the top left corner of the push zone border box.
* `Vector2 pushbox_bottom_right` - the bottom right corner of the push zone border box.
* `Vector2 speedup_zone_top_left` - the top left corner of the inner border of the speedup zone.
* `Vector2 speedup_zone_bottom_right` - the bottom right cordner of the inner boarder of the speedup zone


![1-way speedup push zone](https://lh6.googleusercontent.com/uuYbEkabfImuD-zi06EV57-pWfdrM7fcFsZxFXZVIfr5dFijpk_AXeRkR9K55wiqYl6IH7bMc15SEr8YzQFmHiBdvk6WntvSmkTvdDupe1y57R33AkxEXiDYif4AOUEY) as found in Super Mario Bros., ©1985 Nintendo.]
