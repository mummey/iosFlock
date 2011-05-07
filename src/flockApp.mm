#include "flockApp.h"
//#include "ofAppRunner.h"
#include "ofGraphics.h"
#include "ofConstants.h"

#include "ofxVec3f.h"

#include "CBox.h"
#include "CBoid.h"
#include "CFlock.h"

//--------------------------------------------------------------
void flockApp::setup()
{
	// register touch events
	ofRegisterTouchEvents(this);
  
	ofBackground(100,100,100);
  
  int width = ofGetWidth();
  isIPAD = (width == 1024 || width == 768) ? true : false;
  float boxSide = (isIPAD) ? 500.0 : 200.0;
  
  box = new CBox(boxSide, boxSide, boxSide);
  
  for (int i = 0; i < MAX_BOIDS; i++) 
  {
    Boids[i] = new CBoid(i, this);
  }
  
  for (int j = 0; j < MAX_FLOCKS; j++) 
  {
    Flocks[j] = new CFlock();
  }
  
  Flocks[0]->AddTo(Boids[0]);       
  Flocks[0]->AddTo(Boids[1]);       
  Flocks[0]->AddTo(Boids[2]);
  Flocks[0]->AddTo(Boids[3]);
  Flocks[0]->AddTo(Boids[4]);
  Flocks[0]->AddTo(Boids[5]);
  Flocks[0]->AddTo(Boids[6]);
  Flocks[0]->AddTo(Boids[7]);
  Flocks[0]->AddTo(Boids[8]);
  Flocks[0]->AddTo(Boids[9]);
  
  Flocks[1]->AddTo(Boids[10]);
  Flocks[1]->AddTo(Boids[11]);
  Flocks[1]->AddTo(Boids[12]);
  Flocks[1]->AddTo(Boids[13]);
  
  Flocks[2]->AddTo(Boids[14]);
  Flocks[2]->AddTo(Boids[15]);
  Flocks[2]->AddTo(Boids[16]);
  Flocks[2]->AddTo(Boids[17]);
  Flocks[2]->AddTo(Boids[18]);
  Flocks[2]->AddTo(Boids[19]);
  Flocks[2]->AddTo(Boids[20]);
  Flocks[2]->AddTo(Boids[21]);
  Flocks[2]->AddTo(Boids[22]);
  Flocks[2]->AddTo(Boids[23]);
  Flocks[2]->AddTo(Boids[24]);
  Flocks[2]->AddTo(Boids[25]);
  Flocks[2]->AddTo(Boids[26]);
  
  Flocks[3]->AddTo(Boids[27]);
  Flocks[3]->AddTo(Boids[28]);
  
  Flocks[4]->AddTo(Boids[29]);

  downX=downY=0;
  moveX=moveY=0;
  dragID = -1;
}

//--------------------------------------------------------------
void flockApp::update()
{
  for (int i = 0; i < MAX_FLOCKS; i++) {
    Flocks[i]->Update();
  }
  
  // Rotation Action:
  // There are a few compromises here that will have to be rethought later.
  // 1. rate update() is called is guessed (30.0 fps).
  // 2. angle per-second based on what seems reasonable for guessed rate.
  // 3. uses touch to affect rotation speed, but there's no momentum.
  // 
  if(-1 != dragID)
    {
      ofxVec3f screenVec(moveX-downX,moveY-downY,0.0);
      ofxVec3f screenSiz(ofGetWidth(),ofGetHeight(),0.0);
    
      screenVec.limit(screenSiz.length()/2.0);
      float angle = (20.0 / 30.0) * screenVec.length() / (screenSiz.length()/2.0);
      screenVec.normalize();
      screenVec.set(screenVec.y,screenVec.x,0.0);
      wrld_rot = wrld_rot * ofxQuaternion(ofDegToRad(angle), screenVec);
    }
}

//--------------------------------------------------------------
void flockApp::draw()
{
  float ang=0.0;
  ofxVec3f axis;
  wrld_rot.getRotate(ang, axis);
  
  ofPushMatrix();
  
    ofTranslate(ofGetWidth()/2,ofGetHeight()/2,0);
    ofRotate(ofRadToDeg(ang), -axis.x, axis.y, -axis.z);
  
    box->Draw();
    
    for (int i = 0; i < MAX_FLOCKS; i++) {
      Flocks[i]->Draw();
    }

  ofPopMatrix();
}

//--------------------------------------------------------------
void flockApp::touchDown(ofTouchEventArgs &touch)
{
  downX = moveX = touch.x;
  downY = moveY = touch.y;
  dragID = touch.id;
}

//--------------------------------------------------------------
void flockApp::touchMoved(ofTouchEventArgs &touch)
{
  if(dragID == touch.id)
    {
      moveX = touch.x;
      moveY = touch.y;
    }
  else if(-1 == dragID)
    {
      downX = moveX = touch.x;
      downY = moveY = touch.y;
      dragID = touch.id;
    }
}

//--------------------------------------------------------------
void flockApp::touchUp(ofTouchEventArgs &touch)
{
  if(dragID == touch.id)
    {
      downX=downY=0;
      moveX=moveY=0;
      dragID = -1;
    }
}

//--------------------------------------------------------------
void flockApp::touchDoubleTap(ofTouchEventArgs &touch)
{
  wrld_rot = ofxQuaternion();
}
