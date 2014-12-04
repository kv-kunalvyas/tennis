#include "opencv2/highgui/highgui.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include <opencv2/opencv.hpp>
#include <iostream>

using namespace cv;
using namespace std;

// global variables

// used to prevent shot predictions from occurring too close to each other
int frameDelay = 0;

// track shots predicted
int shotCounter = 0;

static void help()
{
    cout << "\nThis program determines types of tennis shots.\n"
            "Usage:\n"
            "./tracker <video_name>, Default is vid2.mp4\n" << endl;
}

Rect findPlayer(Mat img){
    CascadeClassifier cascade;
    cascade.load("haarcascade_upperbody.xml");
       
    Mat roi = img(Rect(img.cols/5, img.rows/3, (img.cols*0.6) , img.rows/2));
    rectangle(img, Point(img.cols/5, img.rows/3), Point((img.cols*0.6)+img.cols/5, img.rows/3 + img.rows/2), 255, 0, 255);
        
    vector<Rect> found;
    cascade.detectMultiScale(roi, found, 1.05, 20, 1, cvSize(32, 32), cvSize(64, 64));
        
        for (size_t i = 0; i < found.size(); i++){
		    Rect r = found[i];
            rectangle(roi, r.tl(), r.br(), CV_RGB(0, 255, 0), 1);
			
			// this returns rectangle representing player 
			// location in the original image
			return Rect((r.tl().x + img.cols/5),(r.tl().y + img.rows/3),
            (r.br().x + img.cols/5), (r.br().y + img.rows/3));
            
        }
       
    return Rect(0,0,0,0);
}

// openVideo takes the name of the file, opens it and returns a capture
VideoCapture openVideo(string fileName){
	// Read video from disk
	VideoCapture cap(fileName); //capture the video
	
	if ( !cap.isOpened() )  // if no video, exit program
	{
		cout << "Cannot open the video" << endl;
		return -1;
	}
	return cap;
} // end openVideo() 

// returns a Point indicating ball position
Point findBallPosition(Mat frame, Mat orig) {
	
	int x, y;
	vector<Vec3f> circles;
 
	// find ball candidates
    HoughCircles(frame, circles, CV_HOUGH_GRADIENT, 1, 30, 300, 1, 1, 6);
    
    // if there are too many detections, return Point(0,0)
    if ( circles.size() > 10 )
		return Point(0,0);
		
    // used to find the topmost point
    int min_y = 10000;
    
    // find topmost detection
    for( size_t i = 0; i < circles.size(); i++ )
    {
        Vec3i c = circles[i];
        if ( c[1] < min_y ) {
			min_y = y = c[1];
			x = c[0];
		}
		//cout << "Detection " << i << ": x=" << c[0] << " y=" << c[1] << endl;
    }
	
	// convert topmost detection to Point
	Point p = Point(x+orig.cols/5, y+orig.rows/3);
	return p;
}

enum Direction { TOWARDS, AWAY };

Direction findBallDirection(vector<Point> positions){
	
	int lastPosition = positions.size() - 1;
	
	if ( lastPosition < 2 ) return AWAY;
	
	if ( (positions[lastPosition].y - positions[lastPosition - 1].y) > 0 ) {
		return TOWARDS; 
	}
	else if ((positions[lastPosition].y - positions[lastPosition - 1].y) < 0 ) { 
		return AWAY;
	}
	
	return AWAY;
}

// predicts location of ball as it approaches player racket
Point getBallPrediction(vector<Point> positions, Rect playerPosition) {
	
	// index of last known ball position
	int lastPosition = positions.size() - 1;
	
	// coordinates of last 2 known ball positions
	int x1, x2, y1, y2;
	
	x1 = positions[lastPosition].x;
	x2 = positions[lastPosition-1].x;
	y1 = positions[lastPosition].y;
	y1 = positions[lastPosition-1].y;
	
	
	// slope of balls trajectory
	float m = 99999;
	
	if ( x2!=x1 )
		m = (y2-y1)/(x2-x1);
	
	// y=mx+b
	int xPrediction = -((y1-playerPosition.tl().y) / m) + x1 ;
	
	// cout << "predicted x: " << xPrediction << endl;
	
	return Point(xPrediction, playerPosition.tl().y);
}

enum ShotType { FOREHAND, BACKHAND };

// classify the shot as forehand or backhand
ShotType determineShotType(vector<Point> positions, Rect playerPosition) {
	
	// predicate ball position at time of hit
	Point ballPosition = getBallPrediction(positions, playerPosition);
	
	// determine players x location
	int xPlayerCoordinate = (playerPosition.tl().x + playerPosition.br().x) / 2; 
	
	// cout << "ball prediction: " << ballPosition.x << "   player: " << xPlayerCoordinate << endl;
	
	// clear vector of ball positions for next shot
	while (!positions.empty())
		positions.pop_back();
	
	// ball left of player = backhand
	if ( ballPosition.x < xPlayerCoordinate )
		return BACKHAND;
	
	return FOREHAND;
}

int main(int argc, char** argv)
{
	// variables
    vector<Point> ballPositions;
    Rect playerPosition = Rect(0,0,0,0);
    
    // open video as a capture
    VideoCapture cap = openVideo(argv[1]);
    
    // create windows for displaying frames    
    namedWindow("Tennis", CV_WINDOW_AUTOSIZE);
    namedWindow("Frame Subtraction", CV_WINDOW_AUTOSIZE);
    
    // img2 is the area of interest for player and ball detection
    Mat roi2;
    Mat img2;
    
    // trim and convert frame 2 to gray
    for (int i = 0; i < 450; i++)
    cap >> roi2;
    img2 = roi2(Rect(roi2.cols/5, roi2.rows/3, (roi2.cols*0.6) , roi2.rows/2));
    cvtColor(img2, img2, COLOR_BGR2GRAY);
      
      
    // looops through every frame of video for analysis  
    while (true)
    { 
		Mat roi;
        Mat img;
        
        // fetch and convert frame 1 for analysis
        cap >> roi;
        img = roi(Rect(roi.cols/5, roi.rows/3, (roi.cols*0.6) , roi.rows/2));
        cvtColor(img, img, COLOR_BGR2GRAY);
             
	// orig will be the later of the two frames, and will maintain color properties
	Mat orig;
	orig = roi;
	
    // if there's a problem with this frame, skip it
    if (!img.data)
       continue;
    
    // img3 will contain the result of frame subtraction    
	Mat img3 = 3*(img2-img);
    
    Point p = findBallPosition(img3, orig);
	Rect newPlayerPosition = findPlayer(orig);
	
	if ( newPlayerPosition.tl().x != 0 )
		playerPosition = newPlayerPosition;
	   
	Direction d = findBallDirection(ballPositions);
		       
	// if p is not (0,0) and p is not inside the player box, add it to 
	// the vector of ball locations
	if ( p.x == 0 && p.y == 0 ) {
		// cout << "Ball location not found" << endl;
	}
	else if ( p.x > playerPosition.tl().x &&  p.x < playerPosition.br().x 
				&& p.y > playerPosition.tl().y && p.y < playerPosition.br().y 
				&& ballPositions.size() > 2 && frameDelay <= 0 ) {
		
		// code here to determine whether we calculate a shot
		
		ShotType shot;
		
		if ( d == TOWARDS ) {
			shot = determineShotType(ballPositions, playerPosition);
			cout << "Shot# " << ++shotCounter << ":" << endl;
			if ( shot == FOREHAND ) {
				cout << "ITS A FOREHAND!" << endl;
			}
			else 
				cout << "ITS A BACKHAND!" << endl;
		}
		
		// reset frameDelay to prevent another shot prediction too soon
		frameDelay = 37;
	}
	else {
		//Point &location = new Point(p);
		ballPositions.push_back(p);
		// cout << "Estimated Ball Location " << ": x=" << p.x << " y=" << p.y << endl;
		//cout << "Estimated Player Location " << ": x1=" << playerPosition.tl().x << " x2=" << playerPosition.br().x << endl;
		
		// draw the ball location on the original frame
		circle( orig, p, 4, Scalar(0,0,255), 3, CV_AA);
		circle( orig, p, 2, Scalar(0,255,0), 3, CV_AA);
	}
		
	
	//display results	
       imshow("Tennis", orig);
       imshow("Frame Subtraction", img3);
       
       if (waitKey(100) >= 0){
            break;
        }
        
    // advance frame 2 to previous frame 1    
    img2=img;
    
    // decrement frameDelay
    frameDelay--;
    
    }

    return 0;
}
