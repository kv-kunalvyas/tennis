#ifndef BALLTRACKER_H
#define BALLTRACKER_H

#include <cv.h>
#include <highgui.h>
#include <iostream>
#include <list>

#include "colortracker.h"
#include "main.h"
#include "constants.h"
#include "ball.h"

using namespace std;

class BallTracker
{
private:
    VideoCapture capture;
    list<string> colorNames;
    list<ColorTracker*> colorTrackers;
    bool detectNewBall;
    list<Ball*> lastBalls;

    void trackBalls(string windowName, string colorName);
    void drawBallOnFrame(Ball* ball, Mat &frame);

    void clearTrackers();
    void clearBalls();

public:
    BallTracker(VideoCapture &capture, list<string> colorNames);
    ~BallTracker();

    void calibrate();
    list<Ball*> getBalls(Mat &frame);
    list<Ball*> getBalls();

    //Called by mouseHandler - new value should be added
    void newValue(int a, int b, int c);

    //Called by mouseHandler - start calibrating a new ball
    void newBall();

    //Called by mouseHandler - reset thresholds of current frameanalyzer
    void resetThresholds();
    int getFrameWidth();
    int getFrameHeight();
};

#endif
