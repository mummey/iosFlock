#pragma once

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"
#include "ofxQuaternion.h"

#define MAX_BOIDS                    30
#define MAX_FLOCKS                    5

// Forward declarations.
class CBox;
class CFlock;
class CBoid;

class flockApp : public ofxiPhoneApp
{
  private:
  CBox *box;
  CFlock *Flocks[MAX_FLOCKS];
  CBoid  *Boids[MAX_BOIDS];

  ofxQuaternion wrld_rot;
  
  int downX, downY;
  int moveX, moveY;
  int dragID;
  bool isIPAD;
  
  public:
  
  CFlock *FlockAtIndex(int i)
  {
    if (i < 0 || i >= MAX_FLOCKS)
      return NULL;
  
    return Flocks[i];
  }
  
  
	public:
		void setup();
		void update();
		void draw();

    void touchDown(ofTouchEventArgs &touch);
    void touchMoved(ofTouchEventArgs &touch);
    void touchUp(ofTouchEventArgs &touch);
    void touchDoubleTap(ofTouchEventArgs &touch);

};
