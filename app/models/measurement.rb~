require 'detector'

class Measurement < ApplicationRecord

  has_many :circles
  has_attached_file :photo
  validates_attachment_content_type :photo, content_type: /\Aimage/
  has_attached_file :processed_photo
  validates_attachment_content_type :processed_photo, content_type: /\Aimage/

  # Paperclip saves the attachments to disk in an after_save callback
  after_photo_post_process :create_circles
  
  def create_circles
    detector = Detector.first
    photo_path = photo.queued_for_write[:original]&.path || photo.path
    raise 'putain paperclip' unless photo_path
    
    circles.delete_all
    circle_list = detector.find_circles photo_path
    circle_list.each do |circle|
      circles << Circle.create(circle)
    end
    
    path = detector.draw_circles photo_path, circle_list
    self.processed_photo = File.open(path)
    self.processed = true
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
  
  def self.reprocess_all
    Measurement.all.each do |measurement|
      measurement.create_circles
    end
  end
end
