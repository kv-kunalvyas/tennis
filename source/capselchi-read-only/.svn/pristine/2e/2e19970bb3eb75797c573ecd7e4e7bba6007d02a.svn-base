#include "thresholdmanager.h"
#include "math.h"
#include "constants.h"

using namespace cv;

ThresholdManager::ThresholdManager(int a, int b, int c)
{
    minA = max(0,a-1);
    maxA = min(179,a+1);
    minB = max(0,b-1);
    maxB = min(255,b+1);
    minC = 0;
    maxC = 256;
}

void ThresholdManager::addValues(int a, int b, int c){
    if(a<(minA-HUE_MARGIN)){
        minA -= 180;
        maxA -= 180;
    } else if(a>(maxA+HUE_MARGIN))
        a -= 180;
    if(a<minA)
        minA = a-1;
    if(a>maxA)
        maxA = min(179,a+1);

    if(b<minB)
        minB = max(0,b-1);
    if(b>maxB)
        maxB = min(255,b+1);

    if(PRINT_HSV_VALUES){
        cout << "New HSV: " << a << ", : " << b  << ", : " << c << endl;
        cout << "Min HSV: " << minA << ", " << minB << ", " << minC << endl;
        cout << "Max HSV: " << maxA << ", " << maxB << ", " << maxC << endl;
    }
}

int ThresholdManager::getMinA(){
    return minA;
}
int ThresholdManager::getMinB(){
    return minB;
}
int ThresholdManager::getMinC(){
    return minC;
}
int ThresholdManager::getMaxA(){
    return maxA;
}
int ThresholdManager::getMaxB(){
    return maxB;
}
int ThresholdManager::getMaxC(){
    return maxC;
}

Mat ThresholdManager::thresholdImage(Mat &image){
    Mat thresholdedTemp;
    Mat thresholded;
    inRange(image,Scalar(max(0,minA),minB,minC,0),Scalar(maxA,maxB,maxC,0),thresholded);
    if(minA < 0){
        inRange(image,Scalar(minA+180,minB,minC,0),Scalar(180,maxB,maxC,0),thresholdedTemp);
        bitwise_or(thresholded,thresholdedTemp,thresholded);
    }
    return thresholded;
}

/*
Mat ThresholdManager::thresholdImage(Mat &image){
    Mat thresholded;
    inRange(image,Scalar(minA,minB,minC,0),Scalar(maxA,maxB,maxC,0),thresholded);
    return thresholded;
}*/

/*
void ThresholdManager::addValues(int a, int b, int c){
    if(a<minA)
        minA = max(0,a-1);
    if(a>maxA)
        maxA = min(179,a+1);

    if(b<minB)
        minB = max(0,b-1);;
    if(b>maxB)
        maxB = min(255,b+1);

    if(PRINT_HSV_VALUES){
        cout << "New HSV: " << a << ", : " << b  << ", : " << c << endl;
        cout << "Min HSV: " << minA << ", " << minB << ", " << minC << endl;
        cout << "Max HSV: " << maxA << ", " << maxB << ", " << maxC << endl;
    }
}*/
