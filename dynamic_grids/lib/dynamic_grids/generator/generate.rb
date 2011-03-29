require 'rails/generators'
require 'rails/generators/migration'


#create all the necessary files
class CreateDynamicGrids < Rails::Generators::Base
  include Rails::Generators::Migration
  def self.source_root
    @source_root ||= File.join(File.dirname(__FILE__), 'templates')
  end

  #create menu model
  def create_model_file
    template 'grid.rb', 'app/models/grid.rb'
    template 'header.rb', 'app/models/header.rb'
    template 'grids_headers.rb', 'app/models/grids_headers.rb'
  end

  def self.next_migration_number(dirname)
     unless ActiveRecord::Base.timestamped_migrations
       Time.now.utc.strftime("%Y%m%d%H%M%S")
     else
       "%.3d" % (current_migration_number(dirname) + 1)
     end
  end

  def create_migration_file
    migration_template 'create_grids.rb', 'db/migrate/create_grids.rb'
    migration_template 'create_grids_headers.rb', 'db/migrate/create_grids_headers.rb'
    migration_template 'create_headers.rb', 'db/migrate/create_headers.rb'
  end

  def create_js_file
    directory "dynamic_grids_js", "public/javascripts/dynamic_grids_js"
  end

end
