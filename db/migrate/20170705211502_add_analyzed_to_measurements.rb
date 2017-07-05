class AddAnalyzedToMeasurements < ActiveRecord::Migration[5.1]
  def change
    add_column :measurements, :processed, :boolean, default: false
  end
end
