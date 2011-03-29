class CreateHeaders < ActiveRecord::Migration
  def self.up
    create_table :headers do |t|
      t.string  :name
      t.string  :index
      t.string  :column_name
      t.timestamps
    end
  end

  def self.down
    drop_table :headers
  end
end
