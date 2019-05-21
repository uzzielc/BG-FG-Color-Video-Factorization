<h1>
  Background/Foreground Factorization for color video
</h1>

<h2>
  Source Code
</h2>

<p>The source code provided is written for use in matlab. The code will work for only color videos. Arbitrary dimensions of the video frame are handled by the algorithm. The main component of the code uses the SVD of each color channel so larger video files may take longer to be decomposed.
</p>

<p>
  The filenames for loading and writing the video files should changed if the code is to be used. 
</p>

<p>
The output of the algorithm will be a video file which shows the original video, the foreground approximation, and the background approximation side by side.
<p>

<h2>
Traffic.mp4
</h2>

An example of what the algorithm will produce after feeding in a video. 
