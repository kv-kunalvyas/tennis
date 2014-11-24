#include <iostream>
#include <opencv2/opencv.hpp>

using namespace std;
using namespace cv;

int main (int argc, const char * argv[])
{
    VideoCapture cap("vid1.mp4");
    cap.set(CV_CAP_PROP_FPS, 120);
    if (!cap.isOpened())
        return -1;
    
    Mat img;
    HOGDescriptor hog;
    hog.setSVMDetector(HOGDescriptor::getDefaultPeopleDetector());
    
    namedWindow("video capture", CV_WINDOW_AUTOSIZE);
    while (true)
    {
        cap >> img;
        if (!img.data)
            continue;
        //cvtColor(img, img, CV_BGR2GRAY);
        
        //Dimesion of the video is 640 X 360
        Mat roi = img(Rect(160, 140, 320, 160));
        //rectangle(img, Point(160,140), Point(480,300), 255, 0, 255);
        
        vector<Rect> found;
        hog.detectMultiScale(roi, found, 0, Size(2,2), Size(1,1), 5, 1);
        
        for (size_t i = 0; i < found.size(); i++)
        {
            Rect r = found[i];
            rectangle(roi, r.tl(), r.br(), CV_RGB(0, 255, 0), 1);
        }
        
        imshow("video capture", img);
        if (waitKey(2) >= 0){
            break;
        }
    }
    return 0;
}