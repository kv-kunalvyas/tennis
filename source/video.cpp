// Eugene Stanley
// 9/29/14
// eugene.stanley@gmail.com

// This program is based on code provided by Dr. Kate Saenko of UMass Lowell
// This file has been modified to normalize the image using the grey world
// algorithm prior to conversion to HSV and color detection

#include <iostream>
#include <stdio.h>
#include "opencv2/highgui/highgui.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include <opencv2/opencv.hpp>

using namespace cv;
using namespace std;

int main(int argc, char* argv[])
{
    // open the video file for reading
    VideoCapture cap("vid2.mp4");
    cap.set(CV_CAP_PROP_FRAME_WIDTH, 360);
    cap.set(CV_CAP_PROP_FRAME_HEIGHT, 240);
    cap.set(CV_CAP_PROP_FPS, 20);
    
    // if not success, exit program
    while(!cap.isOpened())
    {
        cout << "Cannot open the video file" << endl;
    }
    
    //get the frames per seconds of the video
    double fps = cap.get(CV_CAP_PROP_FPS);
    cout << "Frame per seconds : " << fps << endl;
    
    //create a window called "MyVideo"
    namedWindow("MyVideo",CV_WINDOW_AUTOSIZE);
    
    while(1)
    {
        Mat frame;
        bool bSuccess = cap.read(frame); // read a new frame from video
        if (!bSuccess) //if not success, break loop
        {
            cout << "Cannot read the frame from video file" << endl;
            break;
        }
        
        cout << "Frame per seconds : " << fps << endl;
        imshow("MyVideo", frame); //show the frame in "MyVideo" window
        
        if(waitKey(1) == 2) //wait for 'esc' key press for 1 ms. If 'esc' key is pressed, break loop
        {
            cout << "esc key is pressed by user" << endl;
            break;
        }
    }
    
    return 0;
    
}















