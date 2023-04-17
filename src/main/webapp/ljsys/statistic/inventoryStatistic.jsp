<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div style="height: 100%;width: 100%">
    <div style="width: 100%;height: 10px"></div>
    <div style="width: 100%;display: flex;flex-flow: row wrap">
        <div class="frame">
            <div class="title">项目库存信息统计（个）</div>
            <div id="inventory_planname" class="pie"></div>
        </div>
        <div class="frame">
            <div class="title">库存按构件类型统计（个）</div>
            <div id="inventory_type" class="pie"></div>
        </div>
        <div class="frame">
            <div class="title">仓库构件数量统计（个）</div>
            <div id="inventory_factory" class="pie"></div>
        </div>
        <div class="frame" style="height: 450px;">
            <div class="title">仓库构件数量统计（个）</div>
            <div id="inventory_planname_type" class="pie" style="height: 440px;"></div>
        </div>
    </div>
</div>

<script>
    window.onload = function () {
        getInventoryPlanname()
        getInventoryType()
        getInventoryFactory()
        getPlannameTypeData()
    }

    function getPlanName() {
        $.ajax({
            url: "${pageContext.request.contextPath}/GetPlanName",
            type: 'post',
            dataType: 'json',
            data: {
                'pageCur': 1,
                'pageMax': 999
            },
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                $('#planname1').empty()
                $('#planname1').append($("<option value=''></option>"))
                if (res.data.length !== 0) {
                    for (let v of res.data) {
                        let item = $("<option value='" + v['id'] + "'>" + v['planname'] + "</option>")
                        $('#planname1').append(item)
                    }
                }
                getPlannameTypeData()
            }
        })
    }

    function getInventoryPlanname() {
        $.ajax({
            url: "${pageContext.request.contextPath}/Statistics",
            type: 'post',
            dataType: 'json',
            data: {type: "inventoryPlanname"},
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                let inventory_planname = echarts.init(document.getElementById("inventory_planname"));
                let option = {
                    xAxis: {
                        type: 'category',
                        data: res.xAxis
                    },
                    yAxis: {
                        type: 'value'
                    },
                    toolbox: {
                        feature: {
                            dataView: {}
                        }
                    },
                    series: [
                        {
                            data: res.data,
                            type: 'line',
                            smooth: true
                        }
                    ]
                };
                inventory_planname.setOption(option)
            }
        })
    }

    function getInventoryType() {
        $.ajax({
            url: "${pageContext.request.contextPath}/Statistics",
            type: 'post',
            dataType: 'json',
            data: {type: "inventoryType"},
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                let inventory_type = echarts.init(document.getElementById("inventory_type"));
                let option = {
                    xAxis: {
                        type: 'category',
                        data: res.xAxis
                    },
                    yAxis: {
                        type: 'value'
                    },
                    toolbox: {
                        feature: {
                            dataView: {}
                        }
                    },
                    series: [
                        {
                            data: res.data,
                            type: 'bar',
                            showBackground: true,
                            backgroundStyle: {
                                color: 'rgba(180, 180, 180, 0.2)'
                            }
                        }
                    ]
                };
                inventory_type.setOption(option)
            }
        })
    }

    function getInventoryFactory() {
        $.ajax({
            url: "${pageContext.request.contextPath}/Statistics",
            type: 'post',
            dataType: 'json',
            data: {type: "inventoryFactory"},
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                let inventory_type = echarts.init(document.getElementById("inventory_factory"));
                let option = {
                    xAxis: {
                        type: 'category',
                        data: res.xAxis
                    },
                    yAxis: {
                        type: 'value'
                    },
                    toolbox: {
                        feature: {
                            dataView: {}
                        }
                    },
                    series: [
                        {
                            data: res.data,
                            type: 'bar',
                            showBackground: true,
                            backgroundStyle: {
                                color: 'rgba(180, 180, 180, 0.2)'
                            }
                        }
                    ]
                };
                inventory_type.setOption(option)
            }
        })
    }

    function getPlannameTypeData() {
        $.ajax({
            url: "${pageContext.request.contextPath}/Statistics",
            type: 'post',
            dataType: 'json',
            data: {type: "inventoryPlannameType"},
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                let inventory_planname = echarts.init(document.getElementById("inventory_planname_type"));
                let arr = res.data.map((val) => {
                    return {
                        ...val,
                        type: 'bar',
                        stack: 'total',
                        label: {
                            show: true
                        },
                        emphasis: {
                            focus: 'series'
                        },
                    }
                })
                let option = {
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {
                            // Use axis to trigger tooltip
                            type: 'shadow' // 'shadow' as default; can also be 'line' or 'shadow'
                        }
                    },
                    legend: {},
                    toolbox: {
                        feature: {
                            dataView: {}
                        }
                    },
                    grid: {
                        left: '3%',
                        right: '4%',
                        bottom: '3%',
                        containLabel: true
                    },
                    xAxis: {
                        type: 'value'
                    },
                    yAxis: {
                        type: 'category',
                        data: res.yAxis
                    },
                    series: [...arr]
                };

                inventory_planname.setOption(option)
            }
        })
    }

</script>
<style>
    .title {
        color: #777;
        margin-bottom: 10px;
    }

    .frame {
        width: 46%;
        height: 360px;
        margin: 0 20px;
    }

    .pie {
        width: 100%;
        height: 330px;
    }
</style>