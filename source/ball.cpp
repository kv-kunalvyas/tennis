#include "opencv2/highgui/highgui.hpp"
#include "opencv2/imgproc/imgproc.hpp"

#include <iostream>

using namespace cv;
using namespace std;

static void help()
{
    cout << "\nThis program demonstrates circle finding with the Hough transform.\n"
    "Usage:\n"
    "./houghcircles <image_name>, Default is pic1.png\n" << endl;
}

int main(int argc, char** argv)
{
    
    VideoCapture cap("vid5.mp4");
    if (!cap.isOpened())
        return -1;
    
    namedWindow("video capture", CV_WINDOW_AUTOSIZE);
    namedWindow("video capture2", CV_WINDOW_AUTOSIZE);
    Mat roi2;
    cap >> roi2;
    Mat img2 = roi2(Rect(160, 100, 320, 200));
    cvtColor(img2, img2, COLOR_BGR2GRAY);
    while (true)
    {
        Mat roi;
        cap >> roi;
        Mat img = roi(Rect(160, 100, 320, 200));
        Mat orig;
        cap >> orig;
        // TODO: try first filtering the image based on hsv of ball. doesn't have to be perfect
        
        cvtColor(img, img, COLOR_BGR2GRAY);
        if (!img.data)
            continue;
        
        Mat img3;
        
        
        if(img.empty())
        {
            help();
            return -1;
        }
        //img3 = img2-img+img2-img;
        img3 = (img2-img);
        waitKey(100);
        img2=img;
        Mat cimg;
        // cvtColor(img, img, COLOR_BGR2GRAY);
        //	cvtColor(img, cimg, COLOR_GRAY2BGR);
        vector<Vec3f> circles;
        //   HoughCircles(cimg, circles, CV_HOUGH_GRADIENT, 1, 10, 100, 30, 1, 30);
        // change the last two parameters
        // (min_radius & max_radius) to detect larger circles
        
        HoughCircles(img3, circles, CV_HOUGH_GRADIENT, 1, 30, 100, 1, 1, 6);
        for( size_t i = 0; i < circles.size(); i++ )
        {//continue;
            Vec3i c = circles[i];
            circle( orig, Point(c[0] + 160, c[1] + 100), c[2], Scalar(0,0,255), 3, CV_AA);
            circle( orig, Point(c[0] + 160, c[1] + 100), 2, Scalar(0,255,0), 3, CV_AA);
        }
        
        
        imshow("video capture", orig);
        imshow("video capture2", img3);
		
        if (waitKey(2) >= 0){
            break;
        }
    }
    
    
    
    return 0;
}
