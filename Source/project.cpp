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
//#include "opencv2"
#include <opencv2/opencv.hpp>
using namespace cv;
using namespace std;

int main(int argc, char* argv[])
{
    VideoCapture cap("vid2.mp4"); // open the video file for reading

    while ( !cap.isOpened() )  // if not success, exit program
    {
         //cout << "Cannot open the video file" << endl;
         cap = VideoCapture("vid2.mp4");
		waitKey(1000);
		cout << "wait for the header." << endl;
    }

    //cap.set(CV_CAP_PROP_POS_MSEC, 300); //start the video at 300ms

    double fps = cap.get(CV_CAP_PROP_FPS); //get the frames per seconds of the video

     cout << "Frame per seconds : " << fps << endl;

    namedWindow("MyVideo",CV_WINDOW_AUTOSIZE); //create a window called "MyVideo"

    while(1)
    {
        Mat frame;

        bool bSuccess = cap.read(frame); // read a new frame from video

       if (!bSuccess) //if not success, break loop
       {
                        cout << "Cannot read the frame from video file" << endl;
                      break;
       }

        imshow("MyVideo", frame); //show the frame in "MyVideo" window

        if(waitKey(30) == 27) //wait for 'esc' key press for 30 ms. If 'esc' key is pressed, break loop
      {
                cout << "esc key is pressed by user" << endl;
               break; 
      }
    }

    return 0;

}

