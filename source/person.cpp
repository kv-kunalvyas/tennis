#include <iostream>
#include <opencv2/opencv.hpp>

using namespace std;
using namespace cv;

Rect person(Mat img){
    //VideoCapture cap(video);
    //cap.set(CV_CAP_PROP_FPS, 120);
    //if (!cap.isOpened())
    //    return -1;
    
    //Mat img;
    //HOGDescriptor hog;
    CascadeClassifier cascade;
    cascade.load("haarcascade_upperbody.xml");
    //hog.setSVMDetector(HOGDescriptor::getDefaultPeopleDetector());
    
    //namedWindow("video capture", CV_WINDOW_AUTOSIZE);
    //while (true)
    //{
        double t = (double)cv::getTickCount();
        //cap >> img;
        //if (!img.data)
        //    continue;
        
        Mat roi = img(Rect(img.cols/5, img.rows/3, (img.cols*0.6) , img.rows/2));
        rectangle(img, Point(img.cols/5, img.rows/3), Point((img.cols*0.6)+img.cols/5, img.rows/3 + img.rows/2), 255, 0, 255);
        
        vector<Rect> found;
        cascade.detectMultiScale(roi, found, 1.1, 15, 1, cvSize(32, 32), cvSize(64, 64));
        //hog.detectMultiScale(roi, found, 1.05, Size(4,4), Size(32,32), 1, 0);
        
        for (size_t i = 0; i < found.size(); i++){
            Rect r = found[i];
            rectangle(roi, r.tl(), r.br(), CV_RGB(0, 255, 0), 1);
            return r;
            //cout << (r.tl().x + r.br().x)/2 << endl;
        }
       
        t = ((double)cv::getTickCount() - t) / cv::getTickFrequency();
        double fps = 1.0/t;
        String text = "FPS = " + to_string(fps);
        putText(img, text, Point(20,30), cv::FONT_HERSHEY_SIMPLEX, 0.5, CV_RGB(255,255,0), 1, 8);
        
        //imshow("video capture", img);
        //if (waitKey(2) >= 0){
        //    break;
        }
    //}
    //return 0;
}