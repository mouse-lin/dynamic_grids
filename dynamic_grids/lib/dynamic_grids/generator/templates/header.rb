class Header < ActiveRecord::Base
  has_and_belongs_to_many :grids
  has_many :grids_headers, :class_name => 'GridsHeaders'
end
