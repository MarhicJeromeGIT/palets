class MeasurementsController < ApplicationController
  def new
    @measurement = Measurement.new
  end

  def show
    @measurement = Measurement.find(params[:id])
  end
  
  
  # curl -F photo='./public/palets/ecu01.jpg' 192.168.0.12:8080/measurements
  # curl -F "measurement[photo]=@/home/ubuntu/palets/public/palets/ecu01.jpg" 192.168.0.12:8080/measurements    
  def create
    @measurement = Measurement.new( measurement_params )

    # TODO    
    @measurement.save
    
    if request.format.html?
      redirect_to @measurement
    else
      data = {
        circles: @measurement.circles.to_json      
      }
      render status: :ok, json: @measurement
    end
  end
  
  private
  
  def measurement_params
    params.require(:measurement).permit(:photo)
  end
end
