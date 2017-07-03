class CreateMeasurements < ActiveRecord::Migration[5.1]
  def change
    create_table :measurements do |t|

      t.timestamps
      
      t.attachment :photo
      
    end
  end
end
