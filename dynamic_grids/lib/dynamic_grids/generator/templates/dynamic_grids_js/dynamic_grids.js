Wando.grid.DynamicGridPanel = Ext.extend(Ext.grid.EditorGridPanel, {

    //在这里不采取封装Grid的配置属性，只定义某些需要用到项
    initComponent: function() {
        var store = new Ext.data.JsonStore({
            url: this.storeUrl,
            reader: new Ext.data.JsonReader()
        });

        var config = {
            enableColLock: false,
            loadMask: true,
            ds: store,
            bbar: Wando.createPagingToolbar(store),
            columns: [],
        };

        Ext.apply(this, config);
        Ext.apply(this.initialConfig, config);

        Wando.grid.DynamicGridPanel.superclass.initComponent.apply(this, arguments);
    },

    onRender: function(ct, position) {
        var _this = this;
        this.colModel.defaultSortable = true;
        Wando.grid.DynamicGridPanel.superclass.onRender.call(this, ct, position);
        this.el.mask('加载中...');
        this.store.on('metachange',
        function() {
            if (typeof(this.store.reader.jsonData.columns) === 'object') {
                var columns = [];
                if (this.rowNumberer) {
                    columns.push(new Ext.grid.RowNumberer());
                }
                if (this.checkboxSelModel) {
                    columns.push(new Ext.grid.CheckboxSelectionModel());
                }

                Ext.each(this.store.reader.jsonData.columns,
                function(column) {
                    var column_name = column["column_name"]
                    if(_this.columnsConfig)
                        Ext.apply(this,_this.columnsConfig[column_name]);
                    columns.push(column);
                });
                this.getColumnModel().setConfig(columns);
            }
            this.el.unmask();
        },
        this);
        this.store.load({
            params: {
                offset: 0,
                limit: Wando.pageSize
            }
        });
    }
});
