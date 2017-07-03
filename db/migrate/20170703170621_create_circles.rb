class CreateCircles < ActiveRecord::Migration[5.1]
  def change
    create_table :circles do |t|

      t.timestamps
      t.references :measurement

      t.integer :center_y
      t.integer :center_x
      t.integer :radius
    end
  end
end
