
$.fn.initSelect = function (options) {
    var defaults = {
        id: "id",
        text: "text",
        search: false,
        url: "",
        param: [],
        change: null
    };
    var options = $.extend(defaults, options);
    var $element = $(this);

    $.ajax({
        url: options.url,
        data: options.param,
        dataType: "json",
        async: false,
        success: function (data) {
            $.each(data, function (i) {
                $element.append($("<option></option>").val(data[i][options.id]).html(data[i][options.text]));
            });

        }
    });

}

$.fn.bindSelect = function (options) {
    var defaults = {
        id: "id",
        text: "text",
        search: false,
        url: "",
        param: [],
        change: null
    };
    var options = $.extend(defaults, options);
    var $element = $(this);
    if (options.url != "") {
        $.ajax({
            url: options.url,
            data: options.param,
            dataType: "json",
            async: false,
            success: function (data) {
                $.each(data, function (i) {
                    $element.append($("<option></option>").val(data[i][options.id]).html(data[i][options.text]));
                });
                $element.select2({
                    minimumResultsForSearch: options.search == true ? 0 : -1
                });
                $element.on("change", function (e) {
                    if (options.change != null) {
                        options.change(data[$(this).find("option:selected").index()]);
                    }
                    $("#select2-" + $element.attr('id') + "-container").html($(this).find("option:selected").text().replace(/　　/g, ''));
                });
            }
        });
    } else {
        $element.select2({
            minimumResultsForSearch: -1
        });
    }
}

$.fn.formValid = function () {
    return $(this).valid({
        errorPlacement: function (error, element) {
            element.parents('.formValue').addClass('has-error');
            element.parents('.has-error').find('i.error').remove();
            element.parents('.has-error').append('<i class="form-control-feedback fa fa-exclamation-circle error" data-placement="left" data-toggle="tooltip" title="' + error + '"></i>');
            $("[data-toggle='tooltip']").tooltip();
            if (element.parents('.input-group').hasClass('input-group')) {
                element.parents('.has-error').find('i.error').css('right', '33px')
            }
        },
        success: function (element) {
            element.parents('.has-error').find('i.error').remove();
            element.parent().removeClass('has-error');
        }
    });
}
$.fn.formSerialize = function (formdate) {

    var element = $(this);
    if (!!formdate) {
        for (var key in formdate) {
            var $id = element.find('#' + key);
            var value = $.trim(formdate[key]).replace(/&nbsp;/g, '');
            var type = $id.attr('type');
            if ($id.hasClass("select2-hidden-accessible")) {
                type = "select";
            }
            switch (type) {
                case "checkbox":
                    if (value == "1") {
                        $id.attr("checked", 'checked');
                    } else {
                        $id.removeAttr("checked");
                    }
                    break;
                case "select":
                    $id.val(value).trigger("change");
                    break;
                default:
                    $id.val(value);
                    break;
            }
        };
        return false;
    }


    var reVal = "";
    element.find('input,select,textarea,.ui-select').each(function (r) {
        
        var id = $(this).attr('id');
        var type = $(this).attr('type');
        switch (type) {
            case "checkbox":
                if ($("#" + id).is(":checked")) {
                    reVal += '"' + id + '"' + ':' + '"1",'
                } else {
                    reVal += '"' + id + '"' + ':' + '"0",'
                }
                break;
            case "select":
                var value = $("#" + id).attr('data-value');
                if (value == "") {
                    value = "&nbsp;";
                }
                reVal += '"' + id + '"' + ':' + '"' + $.trim(value) + '",'
                break;
            case "selectTree":
                var value = $("#" + id).attr('data-value');
                if (value == "") {
                    value = "&nbsp;";
                }
                reVal += '"' + id + '"' + ':' + '"' + $.trim(value) + '",'
                break;
            default:
                var value = $("#" + id).val();
                if (value == "") {
                    value = "&nbsp;";
                }
                reVal += '"' + id + '"' + ':' + '"' + $.trim(value) + '",'
                break;
        }
    });
    reVal = reVal.substr(0, reVal.length - 1);
    reVal = reVal.replace(/\\/g, '\\\\');
    reVal = reVal.replace(/\n/g, '\\n');

    var postdata = jQuery.parseJSON('{' + reVal + '}');
    return postdata;

};


$.fn.jqGridRowValue = function (code) {
    var $jgrid = $(this);
    var json = [];
    var selectedRowIds = $jgrid.jqGrid("getGridParam", "selarrrow");
    if (selectedRowIds != undefined && selectedRowIds != "") {
        var len = selectedRowIds.length;
        for (var i = 0; i < len ; i++) {
            var rowData = $jgrid.jqGrid('getRowData', selectedRowIds[i]);
            json.push(rowData[code]);
        }
    } else {
        var rowData = $jgrid.jqGrid('getRowData', $jgrid.jqGrid('getGridParam', 'selrow'));
        json.push(rowData[code]);
    }
    return String(json);
}
$.fn.jqGridRow = function () {
    var $jgrid = $(this);
    var json = [];
    var selectedRowIds = $jgrid.jqGrid("getGridParam", "selarrrow");
    if (selectedRowIds != "") {
        var len = selectedRowIds.length;
        for (var i = 0; i < len ; i++) {
            var rowData = $jgrid.jqGrid('getRowData', selectedRowIds[i]);
            json.push(rowData);
        }
    } else {
        var rowData = $jgrid.jqGrid('getRowData', $jgrid.jqGrid('getGridParam', 'selrow'));
        json.push(rowData);
    }
    return json;
}


dialogAlert = function (content, type) {
    if (type == -1) {
        type = 2;
    }
    top.layer.alert(content, {
        icon: type,
        title: "提示"
    });
}
dialogConfirm = function (content, callBack) {
    top.layer.confirm(content, {
        icon: 7,
        title: "提示",
        btn: ['确认', '取消'],
    }, function () {
        callBack(true);
    }, function () {
        callBack(false)
    });
}
dialogMsg = function (content, type) {
    if (type == -1) {
        type = 2;
    }
    top.layer.msg(content, { icon: type, time: 4000, shift: 5 });
}


reload = function () {
    location.reload();
    return false;
}
newGuid = function () {
    var guid = "";
    for (var i = 1; i <= 32; i++) {
        var n = Math.floor(Math.random() * 16.0).toString(16);
        guid += n;
        if ((i == 8) || (i == 12) || (i == 16) || (i == 20)) guid += "-";
    }
    return guid;
}

request = function (keyValue) {
    var search = location.search.slice(1);
    var arr = search.split("&");
    for (var i = 0; i < arr.length; i++) {
        var ar = arr[i].split("=");
        if (ar[0] == keyValue) {
            if (unescape(ar[1]) == 'undefined') {
                return "";
            } else {
                return unescape(ar[1]);
            }
        }
    }
    return "";
}


$.isNullOrEmpty = function (obj) {
    if ((typeof (obj) == "string" && obj == "") || obj == null || obj == undefined) {
        return true;
    }
    else {
        return false;
    }
}

$.windowWidth = function () {
    return $(window).width();
}
$.windowHeight = function () {
    return $(window).height();
}




checkedArray = function (id) {
    var isOK = true;
    if (id == undefined || id == "" || id == 'null' || id == 'undefined') {
        isOK = false;
        dialogMsg('您没有选中任何项,请您选中后再操作。', 0);
    }
    return isOK;
}
checkedRow = function (id) {
    var isOK = true;
    if (id == undefined || id == "" || id == 'null' || id == 'undefined') {
        isOK = false;
        dialogMsg('您没有选中任何数据项,请选中后再操作！', 0);
    } else if (id.split(",").length > 1) {
        isOK = false;
        dialogMsg('很抱歉,一次只能选择一条记录！', 0);
    }
    return isOK;
}

$.fn.tableUI = function (options) {
    var defaults = {
        trHeadColor: "headRow",
        trHoverColor: "hoverRow",
        trEvenColor: "evenRow",
        trOddColor: "oddRow",
        checkAllClass: ".checkAll",
        checkItemClass: ".checkItem",
        checkedTrColor: "checkdRow"
    }
    var options = $.extend(defaults, options);
    this.each(function () {
        var thisTable = $(this);
        thisTable.find("tr:even").addClass(options.trEvenColor);
        thisTable.find("tr:odd").addClass(options.trOddColor);
        // thisTable.find("tr:first").css("background-color", "Green");
        thisTable.find("tr:not(:first)").hover(function () {
            $(this).addClass(options.trHoverColor).css("cursor", "pointer");
        },
        function () {
            $(this).removeClass(options.trHoverColor);
        });
    });
    function GetCheckBoxIDs(ckAll, ckItem) {
        var v = [];
        ckItem.each(function () {
            if (this.checked) {
                $(this).closest("tr").addClass
                (options.checkedTrColor);
                v.push(this.value);
            } else {
                $(this).closest("tr").removeClass
                (options.checkedTrColor);
            }
        });
        ckAll.val(v.toString());
    };
    $(options.checkAllClass).click(function () {
        $ckAll = $(this).closest("table").find
        (options.checkAllClass);
        $ckItem = $(this).closest("table").find
        (options.checkItemClass);
        if (this.checked) {
            $ckItem.attr({
                "checked": true
            });
        } else {
            $ckItem.attr({
                "checked": false
            });
        }
        GetCheckBoxIDs($ckAll, $ckItem);
    });
    $(options.checkItemClass).click(function () {
        $ckAll = $(this).closest("table").find(options.checkAllClass);
        $ckItem = $(this).closest("table").find(options.checkItemClass);
        var flag = 1;
        $ckItem.each(function () {
            if (!this.checked) {
                flag = 0;
                return false;
            }
        });
        if (flag == 1) {
            $ckAll.attr({
                "checked": true
            });
        } else {
            $ckAll.attr({
                "checked": false
            });
        }
        GetCheckBoxIDs($ckAll, $ckItem);
    });
};