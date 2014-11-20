#ifndef FRAMEANALYZER_H
#define FRAMEANALYZER_H

#include <cv.h>
#include <highgui.h>
#include <list>
#include <vector>
#include <string>

#include "thresholdmanager.h"
#include "ball.h"
#include "constants.h"

using namespace std;

//Tracks a range of HSV values
//This class can make a difference between multiple balls
class ColorTracker
{
private:
    ThresholdManager* manager;
    string colorName;
    Mat hsv_frame;

    Ball* calcAvgBall(list<Ball*> circles);

    void closing(Mat &in, Mat &out);
    void detectBallHough(list<Ball*> &balls, Mat &thresholded, Point &offset);
    void detectBallMoments(list<Ball*> &balls, Mat &thresholded);
    void detectBallMax(list<Ball*> &balls, Mat &thresholded);
    void detectBallContours(list<Ball*> &balls, Mat &thresholded);

public:
    ColorTracker(string,string);
    ~ColorTracker();

    //These methods are called during calibration
    void newValue(int a, int b, int c);
    void resetThresholds();

    //Analyzes a frame
    void analyseFrame(list<Ball*> &balls, Mat &frame);
};

#endif
