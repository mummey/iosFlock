//Copyright (C) Brian Walsh, 2011
//Portions Copyright (C) Steven Woodcock, 2000
//*********************************************************************
// Name:     CFlock.h
// Purpose:  Class definitions and method prototypes for the flocks
//           themselves.
//*********************************************************************

#pragma once

//
// includes
//

#include "CBoid.h"

//
// class definition
//

class CFlock 
{

   public:

      ///////////////////
      // static variables
      ///////////////////

      // number of flocks

      static int FlockCount;
  
      static const GLfloat boidVert[];
      static const GLubyte boidIndices[];

      static const GLfloat axes[];
      static const GLfloat axesColor[];
      static const GLubyte axesIndices[];
  
      ///////////////////////////////
      // constructors and destructors
      ///////////////////////////////

      // Constructor.
      // Creates a new flock.

      CFlock (void);

      // Destructor.

      ~CFlock (void);

      /////////////////////
      // flocking functions
      /////////////////////

      // Update.
      // Updates all members of a flock.

      void Update (void);

      //////////////////////
      // rendering functions
      //////////////////////

      void Draw ();

      //////////////////////////
      // miscellaneous functions
      //////////////////////////

      // AddTo.
      // Adds the indicated boid to the flock.

      void AddTo (CBoid * boid);

      // GetCount.
      // Returns the # of boids in a given flock.

      int GetCount (void);

      // GetFirstMember.
      // Returns a pointer to the first boid 
	    // in a given flock (if any).

      CBoid * GetFirstMember (void);

      // RemoveFrom.
      // Removes the indicated boid from the flock.

      void RemoveFrom (CBoid * boid);

   private:

      int     m_id;                    // id of this flock
      int     m_num_members;           // number of boids in this flock
      CBoid   *m_first_member;         // pointer to first member

};

