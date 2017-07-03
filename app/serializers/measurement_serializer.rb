class MeasurementSerializer < ActiveModel::Serializer
  attributes :id
  has_many :circles
  
  def circles
    object.circles.order('radius ASC')
  end
end
