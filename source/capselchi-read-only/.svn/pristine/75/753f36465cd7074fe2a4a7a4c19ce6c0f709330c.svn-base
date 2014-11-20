#include "ball.h"

Ball::Ball(string colorName, int x, int y, int r){
    this->colorName = colorName;
    this->x = x;
    this->y = y;
    this->r = r;
}

Ball::Ball(string colorName, vector<Vec3f> &circles){
    this->colorName = colorName;
    float sumX = 0.0;
    float sumY = 0.0;
    float sumR = 0.0;

    for (uint i = 0; i < circles.size(); i++)
    {
        if(i<3){
            sumX += circles[i][0];
            sumY += circles[i][1];
            sumR += circles[i][2];
        }
    }

    x = cvRound(sumX/(float)circles.size());
    y = cvRound(sumY/(float)circles.size());
    r = cvRound(sumR/(float)circles.size());
}

string Ball::getColorName(){
    return colorName;
}

int Ball::getX(){
    return x;
}

int Ball::getY(){
    return y;
}

int Ball::getR(){
    return r;
}
