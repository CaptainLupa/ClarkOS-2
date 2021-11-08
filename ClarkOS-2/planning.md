# Planning file

# Scene
    ## Each scene instance has array of cameras
        ## Each camera has its own view matrix for positioning it in the world.
        ## Projection matrix is global since it will not change much.
            ### Zoom function for cameras??
            ### Maybe figure that out.
    
# Object Layout
    ## Each object has a model matrix, and can have children of type object.
    ## Update children in update method, for child in children etc...
    ## Each instance of an object type, no matter if it is a child of another, has its own draw call
    ## and must manage their own resources.  Now that I say that outloud it sounds fucking stupid.
    ## Probably a better whey if I think about it.
    
# Rotations
    ## Todo rotations, you must rotate a point around a quaternion.
    ## In Camera I implemented this, but rotating \_position every time made some sussy stuff
    ## happen.
        ## Need a way to stop rotating every time a rotation is applied.
    
# Input
    ## Singleton class EventHandler
    ## Register keypresses from MainView
    ## store the currently pressed keys every Renderer Draw


# Current Priority
 # Input
 # Get Rotations working correctly, figure out origin problems.
 
