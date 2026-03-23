Ext.ns("IamJairo.CodeServer");

Ext.define("IamJairo.CodeServer.AppInstance", {
    extend: "SYNO.SDS.AppInstance",
    appWindowName: "IamJairo.CodeServer.AppWindow",
    defaultWinSize: { width: 1280, height: 800 },
    constructor: function () {
        this.callParent(arguments);
    },
});

Ext.define("IamJairo.CodeServer.AppWindow", {
    extend: "SYNO.SDS.AppWindow",
    layout: 'fit',
    width: '100%',
    height: '100%',
    initComponent: function () {
        this.items = [
            {
                xtype: 'panel',
                border: false,
                html: '<iframe src="/code-server" style="width:100%;height:100%;border:none;"></iframe>'
            }
        ];
        this.callParent(arguments);
    },
    defaultWinSize: { width: 1280, height: 800 },
    constructor: function (config) {
        const t = this;
        t.callParent([t.fillConfig(config)]);
    },
    fillConfig: function (e) {
        return Ext.apply({}, e);
    },
    onDestroy: function () {
        IamJairo.CodeServer.AppWindow.superclass.onDestroy.call(this);
    },
    onOpen: function (a) {
        IamJairo.CodeServer.AppWindow.superclass.onOpen.call(this, a);
    },
});
