#include "balltracker.h"
#include "time.h"

using namespace cv;

BallTracker::BallTracker(VideoCapture &capture,list<string> colorNames)
{
    this->capture = capture;
    this->detectNewBall = true;
    this->colorNames = colorNames;
}

BallTracker::~BallTracker(){
    clearTrackers();
    clearBalls();
}

void BallTracker::clearTrackers(){
    for(list<ColorTracker*>::const_iterator it = colorTrackers.begin(); it != colorTrackers.end(); it++)
        delete *it;
    colorTrackers.clear();
}

void BallTracker::clearBalls(){
    for (list<Ball*>::iterator it = lastBalls.begin(); it!=lastBalls.end(); it++)
        delete (*it);
    lastBalls.clear();
}

void BallTracker::calibrate(){
    string windowName = "Calibrating";
    namedWindow(windowName, CV_WINDOW_AUTOSIZE);


    for (list<string>::iterator it = colorNames.begin(); it!=colorNames.end(); it++) {
        ColorTracker* analyzer = new ColorTracker(windowName, *it);
        colorTrackers.push_back(analyzer);
        cout<<"Calibrating "<<*it<<endl;
        trackBalls(windowName,(*it));
        cout<<"Finished Calibrating "<<*it<<endl;
    }

    cvDestroyWindow(windowName.c_str());
}

list<Ball*> BallTracker::getBalls(){
    Mat frame;
    return getBalls(frame);
}

list<Ball*> BallTracker::getBalls(Mat &frame){
    capture >> frame;

    if(!frame.data)
        cerr << "ERROR: frame is NULL" << endl;

    flip(frame,frame,1);

    clearBalls();

    for (list<ColorTracker*>::iterator it = colorTrackers.begin(); it!=colorTrackers.end(); it++)
        (*it)->analyseFrame(lastBalls,frame);

    return lastBalls;
}

void BallTracker::trackBalls(string windowName,string colorName){
    detectNewBall = false;

    Mat frame;

    while(!detectNewBall){
        list<Ball*> balls = getBalls(frame);

        for (list<Ball*>::iterator it = balls.begin(); it!=balls.end(); it++)
            drawBallOnFrame((*it),frame);

        int val = frame.at<Vec3b>(HEIGHT-10,10)[0];
        if(val > 128)
            putText(frame, colorName, Point(10, HEIGHT-10), FONT_HERSHEY_TRIPLEX, 0.5, Scalar(0, 0, 0, 0));
        else
            putText(frame, colorName, Point(10, HEIGHT-10), FONT_HERSHEY_TRIPLEX, 0.5, Scalar(255,255,255,0));
        imshow(windowName, frame);

        //Breaks when Esc is pressed
        if( (waitKey(1) & 255) == 27 ) break;
    }
}

void BallTracker::newValue(int a, int b, int c){
    colorTrackers.back()->newValue(a,b,c);
}

void BallTracker::newBall(){
    detectNewBall = true;
}

void BallTracker::resetThresholds(){
    colorTrackers.back()->resetThresholds();
}

void BallTracker::drawBallOnFrame(Ball* ball, Mat &frame){
    circle( frame, cvPoint(ball->getX(), ball->getY()), 3, CV_RGB(0,255,0), -1, 8, 0 );
    circle( frame, cvPoint(ball->getX(), ball->getY()), ball->getR(), CV_RGB(255,0,0), 3, 8, 0 );
}

int BallTracker::getFrameWidth(){
	return capture.get(CV_CAP_PROP_FRAME_WIDTH);
}

int BallTracker::getFrameHeight(){
	return capture.get(CV_CAP_PROP_FRAME_HEIGHT);
}
