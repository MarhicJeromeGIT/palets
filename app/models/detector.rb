require 'opencv'

class Detector < ApplicationRecord
	
	#method (Integer) — Detection method to use. Currently, the only implemented method is CV_HOUGH_GRADIENT.
	#dp (Number) — Inverse ratio of the accumulator resolution to the image resolution. For example, if dp=1, the accumulator has the same resolution as the input image. If dp=2, the accumulator has half as big width and height.
	#min_dist (Number) — Minimum distance between the centers of the detected circles. If the parameter is too small, multiple neighbor circles may be falsely detected in addition to a true one. If it is too large, some circles may be missed.
	#param1 (Number) — First method-specific parameter. In case of CV_HOUGH_GRADIENT, it is the higher threshold of the two passed to the #canny detector (the lower one is twice smaller).
	#param2 (Number) — Second method-specific parameter. In case of CV_HOUGH_GRADIENT, it is the accumulator threshold for the circle centers at the detection stage. The smaller it is, the more false circles may be detected. Circles, corresponding to the larger accumulator values, will be returned first.
	
	
	def find_circles(image_path)
	  puts "Detector::find_circles for #{image_path}..."
	  cv_image = OpenCV::IplImage::load image_path
	  cv_gray = cv_image.BGR2GRAY
	  cv_gray = cv_gray.smooth OpenCV::CV_GAUSSIAN, 7, 7
	  
	  detect = cv_gray.hough_circles(OpenCV::CV_HOUGH_GRADIENT, dp, min_dist, param1, param2, min_radius, max_radius)
	  detect.map do |circle|
	    { center_x: circle.center.x, center_y: circle.center.y, radius: circle.radius }
	  end
	end
	
	def draw_circles(image_path, circles)
	
	  cv_image = OpenCV::IplImage::load image_path
	  cv_result = cv_image.clone
	  
	  circles.each do |circle|
	    center = OpenCV::CvPoint2D32f.new circle[:center_x], circle[:center_y]
       cv_result.circle! center, circle[:radius], :color => OpenCV::CvColor::Red, :thickness => 2
     end
  
	  path = "tmp/processed_#{File.basename(image_path)}.jpg"
	  cv_result.save path
	  path
	end

end
