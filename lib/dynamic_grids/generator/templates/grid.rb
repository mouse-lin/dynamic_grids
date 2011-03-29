class Grid < ActiveRecord::Base
  has_and_belongs_to_many :headers
  has_many :grids_headers, :class_name => 'GridsHeaders'
end
