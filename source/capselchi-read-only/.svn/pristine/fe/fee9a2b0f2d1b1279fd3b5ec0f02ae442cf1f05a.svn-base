#include "colortracker.h"
#include "main.h"

using namespace cv;

ColorTracker::ColorTracker(string mainWindowName, string colorName){
    this->manager = NULL;
    this->colorName = colorName;
    this->hsv_frame = cvCreateImage(cvSize(WIDTH, HEIGHT), IPL_DEPTH_8U, 3);

    cvSetMouseCallback(mainWindowName.c_str(), mouseHandler, &hsv_frame );

    if(SHOW_DEBUG_WINDOWS)
        namedWindow( colorName, CV_WINDOW_AUTOSIZE);
}

ColorTracker::~ColorTracker(){
    delete manager;
}

void ColorTracker::newValue(int a, int b, int c){
    if(manager == NULL)
        manager = new ThresholdManager(a,b,c);
    else
        manager->addValues(a,b,c);
}

void ColorTracker::resetThresholds(){
    delete manager;
    manager = NULL;

    Mat blackImage = Mat::zeros(Size(WIDTH,HEIGHT),CV_8UC3);
    imshow(colorName,blackImage);
}


void ColorTracker::analyseFrame(list<Ball*> &balls, Mat &frame){
    cvtColor(frame, hsv_frame, CV_BGR2HSV);

    if(manager != NULL){
        Mat thresholded = manager->thresholdImage(hsv_frame);

        closing(thresholded, thresholded);

        switch(CHOSEN_METHOD){
        case HOUGH : {  Point offset = Point(0,0);
                        detectBallHough(balls,thresholded,offset); } break;
        case MOMENTS :  detectBallMoments(balls,thresholded); break;
        case MAX :      detectBallMax(balls,thresholded); break;
        default :       detectBallContours(balls,thresholded); //Requires closing
        }

        if(SHOW_DEBUG_WINDOWS)
            imshow(colorName,thresholded);
    }
}

Ball* ColorTracker::calcAvgBall(list<Ball*> balls){
    long x = 0;
    long y = 0;
    long r = 0;

    for (list<Ball*>::iterator it = balls.begin(); it!=balls.end(); it++) {
        x += (*it)->getX();
        y += (*it)->getY();
        r += (*it)->getR();
    }

    return new Ball(colorName, x/balls.size(), y/balls.size(), r/balls.size());
}

void ColorTracker::detectBallHough(list<Ball*> &balls, Mat &thresholded, Point &offset){
    GaussianBlur(thresholded, thresholded, Size(9, 9), 1.5, 1.5);
    //cvCanny(thresholded,thresholded,40.0,180.0);

    double minDist;
    int param1;
    int param2;

    if(CHOSEN_METHOD == HOUGH){
        minDist = thresholded.rows/4;
        param1 = 100;
        param2 = 50;
    } else {
        minDist = 1000;
        param1 = 400;
        param2 = 50;
    }

    vector<Vec3f> circles;
    HoughCircles(thresholded, circles, CV_HOUGH_GRADIENT,2,minDist,param1,param2,5,400);

    for(uint i=0; i<circles.size(); i++)
        balls.push_back(new Ball(colorName,
                                 cvRound(circles[i][0])+offset.x,
                                 cvRound(circles[i][1])+offset.y,
                                 cvRound(circles[i][2])));

}

void ColorTracker::detectBallMoments(list<Ball*> &balls, Mat &thresholded){
    Moments moment = moments(thresholded);

    double area = moment.m00;

    double x = moment.m10/area;
    double y = moment.m01/area;
    double r = sqrt(area/(3.14*255));

    balls.push_back(new Ball(colorName,x,y,r));
}

void ColorTracker::detectBallMax(list<Ball*> &balls, Mat &thresholded){
    vector<int> columnSums;
    for(int i=0;i<thresholded.cols;i++)
        columnSums.push_back(0);

    vector<int> rowSums;
    for(int i=0;i<thresholded.rows;i++)
        rowSums.push_back(0);

    int sum = 0;

    for(int row = 0; row < thresholded.rows; ++row) {
        uchar* inp  = thresholded.ptr<uchar>(row);
        for (int col = 0; col < thresholded.cols; ++col) {
            if (*inp++ == 255) {
                rowSums[row]++;
                columnSums[col]++;
                sum++;
            }
        }
    }

    int x = 0, maxColumnSum = 0;
    for(uint i=0;i<columnSums.size();i++)
        if (columnSums.at(i) > maxColumnSum){
            x = i;
            maxColumnSum = columnSums.at(i);
        }

    int y = 0, maxRowSum = 0;
    for(uint i=0;i<rowSums.size();i++)
        if (rowSums.at(i) > maxRowSum){
            y = i;
            maxRowSum = rowSums.at(i);
        }

    double r = sqrt((double)sum/3.14);

    balls.push_back(new Ball(colorName,x,y,r));
}

void ColorTracker::detectBallContours(list<Ball*> &balls, Mat &thresholded){
    vector< vector<Point> > contours;
    vector<Vec4i> hierarchy;

    Mat temp;
    thresholded.copyTo(temp);
    findContours(temp,contours,hierarchy,CV_RETR_CCOMP,CV_CHAIN_APPROX_SIMPLE );

    if (hierarchy.size() > 0) {
        int index = 0;
        for ( ; index >= 0; index = hierarchy[index][0]) {
            if(CHOSEN_METHOD == CONTOURS_HOUGH){
                Moments moment = moments((Mat)contours[index]);

                double area = moment.m00;

                int margin = 10;
                Rect rect = boundingRect((Mat)contours[index]);
                Point pt1, pt2;
                pt1.x = max(0,rect.x - margin);
                pt1.y = max(0,rect.y - margin);
                pt2.x = min(rect.x + rect.width + margin,639);
                pt2.y = min(rect.y + rect.height + margin,479);
                Rect resizedRect = Rect(pt1,pt2);

                if(area>SMALLEST_OBJECT){
                    Mat region = thresholded(resizedRect);
                    detectBallHough(balls,region,pt1);
                }
            } else {
                Moments moment = moments((Mat)contours[index]);

                double area = moment.m00;

                if(area > SMALLEST_OBJECT){
                    double x = moment.m10/area;
                    double y = moment.m01/area;
                    double r = sqrt(area/3.14);

                    balls.push_back(new Ball(colorName,x,y,r));
                }
            }
        }
    }
}

void ColorTracker::closing(Mat &in, Mat &out){
    Mat element = getStructuringElement( MORPH_ELLIPSE, Size(4,4) );
    dilate(in, out, element );
    dilate(out, out, element );
    dilate(out, out, element );
    erode(out, out, element);
    erode(out, out, element);
    erode(out, out, element);
}
