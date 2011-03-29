class GridsHeaders < ActiveRecord::Base
  #设置复合主键
  set_primary_keys :grid_id, :header_id
  belongs_to :header
  belongs_to :grid
end
