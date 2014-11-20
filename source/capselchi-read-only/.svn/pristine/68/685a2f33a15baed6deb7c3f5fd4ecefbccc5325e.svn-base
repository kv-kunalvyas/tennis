#include <cv.h>
#include <highgui.h>
#include <iostream>
#include <list>

#include "balltracker.h"
#include "constants.h"
#include "ball.h"

using namespace std;
using namespace cv;

BallTracker* ballTracker;

void mouseHandler(int event, int x, int y, int flags, void *param)
{
    if(event == CV_EVENT_LBUTTONDOWN){
        Mat* hsv_frame = (Mat*) param;

        ballTracker->newValue(hsv_frame->at<Vec3b>(y,x)[0],hsv_frame->at<Vec3b>(y,x)[1],hsv_frame->at<Vec3b>(y,x)[2]);
    }
    if(event == CV_EVENT_RBUTTONDOWN){
        ballTracker->newBall();
    }
    if(event == CV_EVENT_MBUTTONDOWN){
        ballTracker->resetThresholds();
    }
}

const char* windowName = "Visualisation";

void drawBalls(list<Ball*> balls){
    Mat frame = Mat::zeros(HEIGHT,WIDTH,CV_8UC3);

    for (list<Ball*>::iterator it = balls.begin(); it!=balls.end(); it++){
        Ball* ball = (*it);

        circle(frame, cvPoint(ball->getX(), ball->getY()), 3, CV_RGB(0,255,0), -1, 8, 0 );
        circle(frame, cvPoint(ball->getX(), ball->getY()), ball->getR(), CV_RGB(255,0,0), 3, 8, 0 );
    }

    imshow(windowName,frame);
}

int ma1in2(int argc, char *argv[])
{
    VideoCapture capture;

    if(argc > 1)
        capture.open(string(argv[1]));
    else
        capture.open(0);

   // capture.set(CV_CAP_PROP_FRAME_WIDTH, 1280);   //Not working in OpenCV 2.1
    //capture.set(CV_CAP_PROP_FRAME_HEIGHT,720);    //Not working in OpenCV 2.1

    list<string> colorNames;
    colorNames.push_back("Yellow");
    colorNames.push_back("Red");

    ballTracker = new BallTracker(capture,colorNames);
    ballTracker->calibrate();

    //Visualisation starts here
    //To get ball positions call: ballTracker->getBalls()

    namedWindow(windowName,CV_WINDOW_AUTOSIZE);

    clock_t start, stop;
    int count = 0;
    start = clock();

    while(true){
        count++;

        drawBalls(ballTracker->getBalls());

        if(PRINT_FRAME_RATE && ((count%20) == 0)){
            stop = clock() ;

            double timePassed = ((double) (stop - start)) / CLOCKS_PER_SEC;

            cout << "Frame rate: " << (double)20 / timePassed << endl ;

            count = 0;

            start = clock();
        }

        //Visualisation is closed when Esc is pressed
        if( (waitKey(1) & 255) == 27 ) break;
    }

    delete ballTracker;

    return 0;
}
