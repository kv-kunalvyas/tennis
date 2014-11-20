#ifndef THRESHOLDMANAGER_H
#define THRESHOLDMANAGER_H

#include <cv.h>
#include <iostream>

using namespace std;
using namespace cv;

//Helper class for colortracker
//Maintains the thresholds which are tracked by a colortracker
//For now: A = Hue, B = Saturation, C = Value
class ThresholdManager
{
private:
    int minA;
    int minB;
    int minC;

    int maxA;
    int maxB;
    int maxC;

public:
    ThresholdManager(int a, int b, int c);

    void addValues(int a, int b, int c);

    int getMinA();
    int getMinB();
    int getMinC();
    int getMaxA();
    int getMaxB();
    int getMaxC();

    void resetThresholds();

    Mat thresholdImage(Mat &image);
};

#endif
