<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div style="height: 100%;width: 100%">
    <div style="width: 100%;height: 10px"></div>
    <div style="width: 100%;display: flex;flex-flow: row wrap">
        <div class="frame">
            <div class="title">总体浇捣情况统计（方量）</div>
            <div id="pour_all" class="pie"></div>
        </div>
        <div class="frame">
            <div class="title" style="line-height: 32px;">构件类型浇捣型统计（方量）</div>
            <div id="pour_type" class="pie"></div>
        </div>
        <div class="frame" style="width: 100%">
            <div class="title">项目浇捣情况统计（方量）</div>
            <div id="pour_planname" class="pie"></div>
        </div>
        <div class="frame" style="width: 50%">
            <div class="form-inline" style="width: 100%;margin-bottom:10px;display: flex">
                <div class="title" style="line-height: 32px;margin-right: 50px">项目构件类型浇捣统计（方量）</div>
                <div class="form-group">
                    <label>项目名称：</label>
                    <select style="height:32px;width: 150px" name="planname1"
                            id="planname1"
                            onchange="getPourPlannameTypeData()" class="form-control">
                    </select>
                </div>
            </div>
            <div id="pour_planname_type" class="pie"></div>
        </div>
    </div>


</div>
<script>
    window.onload = function () {
        getPourAllData()
        getPourPlanname()
        getPlanName()
        getPourType()
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
                getPourPlannameTypeData()
            }
        })
    }

    function getPourPlanname() {
        $.ajax({
            url: "${pageContext.request.contextPath}/Statistics",
            type: 'post',
            dataType: 'json',
            data: {type: "pourPlanname"},
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                let pour_planname = echarts.init(document.getElementById("pour_planname"));
                let emphasisStyle = {
                    itemStyle: {
                        shadowBlur: 10,
                        shadowColor: 'rgba(0,0,0,0.3)'
                    }
                };
                let option = {
                    legend: {
                        data: ['已浇捣', '未浇捣'],
                        left: '10%'
                    },
                    brush: {
                        toolbox: ['rect', 'polygon', 'lineX', 'lineY', 'keep', 'clear'],
                        xAxisIndex: 0
                    },
                    toolbox: {
                        feature: {
                            magicType: {
                                type: ['stack']
                            },
                            dataView: {}
                        }
                    },
                    tooltip: {},
                    xAxis: {
                        data: res.xAxisData,
                        name: '项目名称',
                        axisLabel: {
                            interval: 0,
                            rotate: 20,
                            margin: 2,
                        },
                        axisLine: {onZero: true},
                        splitLine: {show: false},
                        splitArea: {show: false}
                    },
                    yAxis: {},
                    grid: {
                        bottom: 100
                    },
                    series: [
                        {
                            name: '已浇捣',
                            type: 'bar',
                            stack: 'one',
                            emphasis: emphasisStyle,
                            data: res.data1
                        },
                        {
                            name: '未浇捣',
                            type: 'bar',
                            stack: 'one',
                            emphasis: emphasisStyle,
                            data: res.data2
                        },
                    ]
                };
                pour_planname.setOption(option)
            }
        })
    }

    function getPourAllData() {
        $.ajax({
            url: "${pageContext.request.contextPath}/Statistics",
            type: 'post',
            dataType: 'json',
            data: {type: "pourAll"},
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                let pour_all = echarts.init(document.getElementById("pour_all"));
                let option = {
                    tooltip: {
                        trigger: 'item'
                    },
                    legend: {
                        top: '5%',
                        left: 'center',
                        // doesn't perfectly work with our tricks, disable it
                        selectedMode: false
                    },
                    toolbox: {
                        feature: {
                            dataView: {}
                        }
                    },
                    series: [
                        {
                            name: '浇捣情况统计',
                            type: 'pie',
                            radius: ['40%', '70%'],
                            center: ['50%', '70%'],
                            // adjust the start angle
                            startAngle: 180,
                            label: {
                                show: true,
                                formatter(param) {
                                    // correct the percentage
                                    return param.name + ' (' + param.percent * 2 + '%)';
                                }
                            },
                            data: [
                                ...res.data,
                                {
                                    // make an record to fill the bottom 50%
                                    value: res.all,
                                    itemStyle: {
                                        // stop the chart from rendering this piece
                                        color: 'none',
                                        decal: {
                                            symbol: 'none'
                                        }
                                    },
                                    label: {
                                        show: false
                                    }
                                }
                            ]
                        }
                    ]
                };
                pour_all.setOption(option)
            }
        })
    }

    function getPourType() {
        $.ajax({
            url: "${pageContext.request.contextPath}/Statistics",
            type: 'post',
            dataType: 'json',
            data: {type: "pourType"},
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                let pour_planname = echarts.init(document.getElementById("pour_type"));
                let emphasisStyle = {
                    itemStyle: {
                        shadowBlur: 10,
                        shadowColor: 'rgba(0,0,0,0.3)'
                    }
                };
                let option = {
                    legend: {
                        data: ['已浇捣', '未浇捣'],
                        left: '10%'
                    },
                    brush: {
                        toolbox: ['rect', 'polygon', 'lineX', 'lineY', 'keep', 'clear'],
                        xAxisIndex: 0
                    },
                    toolbox: {
                        feature: {
                            magicType: {
                                type: ['stack']
                            },
                            dataView: {}
                        }
                    },
                    tooltip: {},
                    xAxis: {
                        data: res.xAxisData,
                        name: '构建类型',
                        axisLine: {onZero: true},
                        splitLine: {show: false},
                        splitArea: {show: false}
                    },
                    yAxis: {},
                    grid: {
                        bottom: 100
                    },
                    series: [
                        {
                            name: '已浇捣',
                            type: 'bar',
                            stack: 'one',
                            emphasis: emphasisStyle,
                            data: res.data1
                        },
                        {
                            name: '未浇捣',
                            type: 'bar',
                            stack: 'one',
                            emphasis: emphasisStyle,
                            data: res.data2
                        },
                    ]
                };
                pour_planname.setOption(option)
            }
        })
    }

    function getPourPlannameTypeData() {
        $.ajax({
            url: "${pageContext.request.contextPath}/Statistics",
            type: 'post',
            dataType: 'json',
            data: {type: "pourPlannameType", planname: $("#planname1 option:selected").text()},
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                let pour_planname = echarts.init(document.getElementById("pour_planname_type"));
                let emphasisStyle = {
                    itemStyle: {
                        shadowBlur: 10,
                        shadowColor: 'rgba(0,0,0,0.3)'
                    }
                };
                let option = {
                    legend: {
                        data: ['已浇捣', '未浇捣'],
                        left: '10%'
                    },
                    brush: {
                        toolbox: ['rect', 'polygon', 'lineX', 'lineY', 'keep', 'clear'],
                        xAxisIndex: 0
                    },
                    toolbox: {
                        feature: {
                            magicType: {
                                type: ['stack']
                            },
                            dataView: {}
                        }
                    },
                    tooltip: {},
                    xAxis: {
                        data: res.xAxisData,
                        name: '构建类型',
                        axisLine: {onZero: true},
                        splitLine: {show: false},
                        splitArea: {show: false}
                    },
                    yAxis: {},
                    grid: {
                        bottom: 100
                    },
                    series: [
                        {
                            name: '已浇捣',
                            type: 'bar',
                            stack: 'one',
                            emphasis: emphasisStyle,
                            data: res.data1
                        },
                        {
                            name: '未浇捣',
                            type: 'bar',
                            stack: 'one',
                            emphasis: emphasisStyle,
                            data: res.data2
                        },
                    ]
                };
                pour_planname.setOption(option)
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
        width: 40%;
        height: 400px;
        margin: 0 20px;
    }

    .pie {
        width: 100%;
        height: 370px;
    }
</style>