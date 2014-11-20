#ifndef CONSTANTS_H
#define CONSTANTS_H

const int WIDTH = 640;                      //Width of frame
const int HEIGHT = 480;                     //Height of frame
const bool SHOW_DEBUG_WINDOWS = !true;       //Show hsv_images or not
const bool PRINT_FRAME_RATE = true;
const bool PRINT_HSV_VALUES = !true;

enum METHOD { HOUGH, MOMENTS, MAX, CONTOURS_MOMENTS, CONTOURS_HOUGH };
const METHOD CHOSEN_METHOD = CONTOURS_MOMENTS;
const int SMALLEST_OBJECT = 200;            //Area of smallest object to track. Used in CONTOURS

const int HUE_MARGIN = 40;                  //If the hue of a new value is outside of the range by this margin
                                            //Assume it lays at the other side of the spectrum

#endif
