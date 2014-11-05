#include <iostream>
#include <opencv2/opencv.hpp>

using namespace std;
using namespace cv;

int main (int argc, const char * argv[])
{
    VideoCapture cap("vid2.mp4");
    cap.set(CV_CAP_PROP_FRAME_WIDTH, 160);
    cap.set(CV_CAP_PROP_FRAME_HEIGHT, 120);
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
        
        /*
         vector<float> features;
         hog.compute(img, features);
         cout << "HOG feature's length is " << hog.getDescriptorSize() << " "  << features.size() << endl;
         
         Rect roi(img.cols, 0, img.width, img.height/2);
         Mat image_roi = inputImage(roi);
         imshow("result", image_roi);
         
         vector<Rect> found, found_filtered;
         hog.detectMultiScale(image_roi, found, 0, Size(8,8), Size(32,32), 1.05, 1);
         */
        
        size_t i, j;
        for (i=0; i<found.size(); i++)
        {
            Rect r = found[i];
            for (j=0; j<found.size(); j++)
                if (j!=i && (r & found[j])==r)
                    break;
            if (j==found.size())
                found_filtered.push_back(r);
        }
        for (i=0; i<found_filtered.size(); i++)
        {
            Rect r = found_filtered[i];
            r.x += cvRound(r.width*0.1);
            r.width = cvRound(r.width*0.8);
            r.y += cvRound(r.height*0.06);
            r.height = cvRound(r.height*0.9);
            rectangle(img, r.tl(), r.br(), cv::Scalar(0,255,0), 1);
        }
        imshow("video capture", img);
        if (waitKey(20) >= 0)
            break;
    }
    return 0;
}