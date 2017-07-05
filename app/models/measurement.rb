require 'detector'

class Measurement < ApplicationRecord

  has_many :circles
  has_attached_file :photo
  validates_attachment_content_type :photo, content_type: /\Aimage/
  has_attached_file :processed_photo
  validates_attachment_content_type :processed_photo, content_type: /\Aimage/

  # Paperclip saves the attachments to disk in an after_save callback
  after_save :create_circles
  
  def create_circles
    return if circles.any?
    
    circle_list = Detector.find_circles photo.path, dp: 1, min_dist: 70, param1: 168, param2: 64
    circle_list.each do |circle|
      circles << Circle.create(circle)
    end
    
    path = Detector.draw_circles photo.path, circle_list
    self.processed_photo = File.open(path)
    self.save
  end

  # TEMP and RANDOM
  def ___find_circles
    geometry = Paperclip::Geometry.from_file(photo)
    width = geometry.width.to_i
    height = geometry.height.to_i
    
    [].tap do |circle_list|
      (1+rand(9)).times do |i|
        center_x = rand(width)
        center_y = rand(height)
        radius = 1 + rand(width*0.1)
        circle_list << { center_x: center_x, center_y: center_y, radius: radius }
      end
    end
  end
end
