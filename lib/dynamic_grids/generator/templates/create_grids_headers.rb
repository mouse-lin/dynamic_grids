class CreateGridsHeaders < ActiveRecord::Migration
  def self.up
    create_table :grids_headers, :id => false do |t|
      t.integer  :grid_id
      t.integer  :header_id
      t.integer  :order_by

      t.timestamps
    end
  end

  def self.down
    drop_table :grids_headers
  end
end
