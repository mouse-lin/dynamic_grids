class CreateGrids < ActiveRecord::Migration
  def self.up
    create_table :grids do |t|
      t.string  :name
      t.string  :title

      t.timestamps
    end
  end

  def self.down
    drop_table :grids
  end
end
