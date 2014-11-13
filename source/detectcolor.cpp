#include <iostream>
#include <stdio.h>
#include <opencv2/opencv.hpp>
#include "opencv2/highgui/highgui.hpp"
#include "opencv2/imgproc/imgproc.hpp"

using namespace cv;
using namespace std;

int main( int argc, char** argv )
{
	//Uncomment the following to change to video input
	VideoCapture cap("vid2.mp4"); //capture the video from web cam
    

	if ( !cap.isOpened() )  // if not success, exit program
	{
	cout << "Cannot open the web cam" << endl;
	return -1;
	}
	// end of video input

	// Read image from disk as input
	if ( argc != 2 )
	{
		printf("usage: <this executable> <Image_Path>\n");
		return -1;
	}

	Mat  imgOriginal;
	imgOriginal = imread( argv[1], 1 );

	if ( !imgOriginal.data )
	{
		printf("No image data \n");
		return -1;
	}
	// end of image input
	
	namedWindow("Solution",1);

	Mat channel[3];
	Mat constancy[3];
	Mat finalImage;
	split(imgOriginal, channel);
	
	//Calculating mean of all three channels, RGB
	Scalar meanR = mean(channel[2]);
	Scalar meanG = mean(channel[1]);
	Scalar meanB = mean(channel[0]);
	/*	
	cout << meanR;
	cout << meanG;
	cout << meanB;
	*/
	//Calculating the constancy matrix for each channel - Grey World Algorithm
	constancy[2] = 130*(channel[2]/meanR[0]);
	constancy[1] = 100*(channel[1]/meanG[0]);
	constancy[0] = 70*(channel[0]/meanB[0]);

	//Merging them into one image
	merge(constancy, 3, finalImage);
	
	//imshow("Solution", finalImage);
	imgOriginal = finalImage;

	namedWindow("Control", CV_WINDOW_AUTOSIZE); //create a window called "Control"
	/*
	int iLowH = 160;
	int iHighH = 179;  
    
	int iLowS = 100; 
	int iHighS = 255;
    
	int iLowV = 50;
	int iHighV = 255;
	*/
	int iLowH = 50;
	int iHighH = 70;
    
	int iLowS = 22;
	int iHighS = 25;
    
	int iLowV = 85;
	int iHighV = 95;
	
	//Create trackbars in "Control" window
	//trackbarname – Name of the created trackbar.
	//winname – Name of the window that will be used as a parent of the created trackbar.
	//value – Optional pointer to an integer variable whose value reflects the position of the slider. Upon creation, the slider position is defined by this variable.
	//count – Maximal position of the slider. The minimal position is always 0.
	
	cvCreateTrackbar("LowH", "Control", &iLowH, 0); //Hue (0 - 179)
	cvCreateTrackbar("HighH", "Control", &iHighH, 40);
    
	cvCreateTrackbar("LowS", "Control", &iLowS, 230); //Saturation (0 - 255)
	cvCreateTrackbar("HighS", "Control", &iHighS, 255);
    
	cvCreateTrackbar("LowV", "Control", &iLowV, 30); //Value (0 - 255)
	cvCreateTrackbar("HighV", "Control", &iHighV, 255);
    
	while (true)
	{
		// Uncomment the following to change to video input
		         Mat imgOriginal;
		//	
		bool bSuccess = cap.read(imgOriginal); // read a new frame from video
		//	
		if (!bSuccess) //if not success, break loop
		{
		cout << "Cannot read a frame from video stream" << endl;
		break;
		}
		
		Mat imgRGB;
	
		cvtColor(imgOriginal, imgRGB, COLOR_BGR2RGB); //Convert the captured frame from BGR to HSV
	
		Mat imgThresholded;
		//Scalar() is used in opencv to pass pixel values
		//inRange() Checks if array elements lie between the elements of two other arrays.
		inRange(imgRGB, Scalar(200, 200, 140), Scalar(250, 250, 220), imgThresholded);
		//Threshold the image
	
		// Morphological opening (remove small objects from the foreground)
		//erode(imgThresholded, imgThresholded, getStructuringElement(MORPH_ELLIPSE, Size(5, 5)) );
		//dilate(imgThresholded, imgThresholded, getStructuringElement(MORPH_ELLIPSE, Size(5, 5)) ); 
	
		// Morphological closing (fill small holes in the foreground)
		//dilate(imgThresholded, imgThresholded, getStructuringElement(MORPH_ELLIPSE, Size(5, 5)) ); 
		//erode(imgThresholded, imgThresholded, getStructuringElement(MORPH_ELLIPSE, Size(5, 5)) );
	
		imshow("Thresholded Image", imgThresholded); //show the thresholded image
		imshow("Original", imgOriginal); //show the original image
	
		if (waitKey(30) == 27) //wait for 'esc' key press for 30ms. If 'esc' key is pressed, break loop
		{
			cout << "esc key is pressed by user" << endl;
			break; 
		}
	}
	return 0;
}
