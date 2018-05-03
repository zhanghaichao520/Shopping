
$.SaveForm = function (options) {
    var defaults = {
        url: "",
        param: [],
        type: "post",
        dataType: "json",
        loading: "正在处理数据...",
        success: null,
        close: true
    };
    var options = $.extend(defaults, options);
    window.setTimeout(function () {
        $.ajax({
            url: options.url,
            data: options.param,
            type: options.type,
            dataType: options.dataType,
            success: function (data) {                
                if (data.type == "3") {
                    dialogAlert(data.message, -1);
                }                
                else {
                    if (data.type == "0")
                        dialogAlert(data.message, 0);
                    else
                        dialogMsg(data.message, 1);
                    options.success(data);
                    if (options.close == true) {
                        dialogClose();
                    }
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                dialogMsg(errorThrown, -1);
            }
        });
    }, 500);
}



$.SetForm = function (options) {
    var defaults = {
        url: "",
        param: [],
        type: "get",
        dataType: "json",
        success: null,
        async: false
    };
    var options = $.extend(defaults, options);
    $.ajax({
        url: options.url,
        data: options.param,
        type: options.type,
        dataType: options.dataType,
        async: options.async,
        success: function (data) {
            if (data != null && data.type == "3") {
                dialogAlert(data.message, -1);
            } else {
                options.success(data);
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            dialogMsg(errorThrown, -1);
        }
    });
}
$.RemoveForm = function (options) {
    var defaults = {
        msg: "注：您确定要删除吗？该操作将无法恢复",
        loading: "正在删除数据...",
        url: "",
        param: [],
        type: "post",
        dataType: "json",
        success: null
    };
    var options = $.extend(defaults, options);
    dialogConfirm(options.msg, function (r) {
        if (r) {
            window.setTimeout(function () {
                var postdata = options.param;
                $.ajax({
                    url: options.url,
                    data: postdata,
                    type: options.type,
                    dataType: options.dataType,
                    success: function (data) {
                        if (data.type == "3") {
                            dialogAlert(data.message, -1);
                        } else if (data.type == "0") {
                            dialogAlert(data.message, 0);
                        }
                        else {
                            dialogMsg(data.message, 1);
                            options.success(data);
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        dialogMsg(errorThrown, -1);
                    }
                });
            }, 500);
        }
    });
}
$.ConfirmAjax = function (options) {
    var defaults = {
        msg: "提示信息",
        loading: "正在处理数据...",
        url: "",
        param: [],
        type: "post",
        dataType: "json",
        success: null
    };
    var options = $.extend(defaults, options);
    dialogConfirm(options.msg, function (r) {
        if (r) {
            Loading(true, options.loading);
            window.setTimeout(function () {
                var postdata = options.param;
                $.ajax({
                    url: options.url,
                    data: postdata,
                    type: options.type,
                    dataType: options.dataType,
                    success: function (data) {
                        if (data.type == "3") {
                            dialogAlert(data.message, 0);
                        } else {
                            dialogMsg(data.message, 1);
                            options.success(data);
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        dialogMsg(errorThrown, -1);
                    }
                });
            }, 200);
        }
    });
}




