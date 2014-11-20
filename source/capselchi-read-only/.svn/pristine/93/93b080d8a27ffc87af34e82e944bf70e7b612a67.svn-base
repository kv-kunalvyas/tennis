#ifndef CIRCLE_H
#define CIRCLE_H

#include <cv.h>
#include <math.h>
#include <string>

using namespace std;
using namespace cv;

class Ball
{
private:
    string colorName;
    int x;
    int y;
    int r;

public:
    //Pre: circles->total != 0
    //Post: avgX, avgY and avgR are stored
    Ball(string colorName, vector<Vec3f> &circles);
    Ball(string colorName, int x, int y, int r);

    string getColorName();
    int getX();
    int getY();
    int getR();
};

#endif
