module DynamicGrids
  #User: Mouse
  #Comment: 创建dynamic_grids(动态表格)
  #date: 2011-03-22
  #grid_name： 获取Grid的种类
  #Model: 传入你需要获取数据的model名字
  #options: 传入附加的条件 
  def dynamic_grids model,grid_name,options = {  }
    default_options = { :order => params[:order], :offset => params[:offset].to_i, :limit => params[:limit].to_i }
    options = default_options.merge(options)
    fields,columns,results_field = find_fields_and_columns grid_name unless grid_name.nil?
    records,count = find_records model,options,results_field unless model.nil?
    render :json => {  
      :metaData => { 
        'totalProperty' => 'total',
        'root' => :content,
        'fields' => fields
      },
      :success => true,
      :total => count,
      :content => records,
      :columns => columns
    }
  end

  private
  #通过grid_name 来获取需要的表格名
  def find_fields_and_columns grid_name
    fields = []
    columns = []
    results_field = []
    Grid.where(:name => grid_name ).first.headers.order('grids_headers.order_by').each do |h|
      fields << { :name => h.index }
      results_field << h.index 
      columns << { 
        :header => h.name,
        :dataIndex => h.index,
        :column_name => h.column_name
      }
    end
    [fields,columns,results_field]
  end

  #通过model、options条件来回去表信息
  def find_records model,options,results_field
    records = []
    model.find(:all,options).each do |m|
      records << m.provide(results_field)
    end
    count  = records.count
    [records,count]
  end
end
