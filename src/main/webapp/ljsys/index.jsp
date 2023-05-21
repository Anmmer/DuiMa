<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html class="BodyStyle">
<head>
    <meta charset="utf-8">
    <title>主页</title>
    <link rel="stylesheet" href="css/style.css" type="text/css">
    <link rel="stylesheet" href="dist/css/bootstrap.css" type="text/css"/>
    <script type="text/javascript" src="./js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="./js/util.js"></script>
    <script type="text/javascript" src="./js/echarts.js"></script>
</head>
<body class="BodyStyle">
<div style="width: 100%;height: 100%">
    <div style="width: 100%;height: 10px"></div>
    <div style="width: 100%;display: flex;flex-flow: row wrap;justify-content: center">
        <div class="frame">
            <div class="form-inline" style="width: 100%;margin-bottom:20px;display: flex">
                <div class="form-group">
                    <select style="height:32px;width: 150px" name="type"
                            id="inWarehouseType"
                            onchange="getInWarehouse()" class="form-control">
                        <option value="inWarehouseDay">昨日入库统计</option>
                        <option value="inWarehouseMonth">本月入库统计</option>
                        <option value="inWarehouseYear">本年入库统计</option>
                    </select>
                </div>
            </div>
            <div id="inWarehouse" class="pie"></div>
        </div>

        <div class="frame">
            <div class="form-inline" style="width: 100%;margin-bottom:20px;display: flex">
                <div class="form-group">
                    <select style="height:32px;width: 150px" name="type"
                            id="outWarehouseType"
                            onchange="getOutWarehouse()" class="form-control">
                        <option value="outWarehouseDay">昨日发货统计</option>
                        <option value="outWarehouseMonth">本月发货统计</option>
                        <option value="outWarehouseYear">本年发货统计</option>
                    </select>
                </div>
            </div>
            <div id="outWarehouse" class="pie"></div>
        </div>
        <div class="frame" style="width: 1200px">
            <div class="pie" style="height: 440px;">
                <table class="table table-hover" style="text-align: center">
                    <tr id="table_head">

                    </tr>
                    <tbody>
                    <tr id="table_body">
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

</body>
<script type="text/javascript">
    window.onload = function () {
        getInWarehouse()
        getOutWarehouse()
        getWarehouse()
    }

    function getOutWarehouse() {
        $.ajax({
            url: "${pageContext.request.contextPath}/ReportDataStatistics",
            type: 'post',
            dataType: 'json',
            data: {type: $("#outWarehouseType option:selected").val()},
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                let outWarehouse = echarts.init(document.getElementById("outWarehouse"));
                let option = {
                    title: {
                        text: '出库数据统计(类型)',
                        subtext: '合计方量：' + (res.sum || 0),
                        left: 'center'
                    },
                    tooltip: {
                        trigger: 'item'
                    },
                    legend: {
                        orient: 'vertical',
                        left: 'left'
                    },
                    series: [
                        {
                            type: 'pie',
                            radius: '50%',
                            data: res.data,
                            label: {
                                alignTo: 'edge',
                                formatter: '{name|{b}}\n{time|{c} 方量}',
                                minMargin: 5,
                                edgeDistance: 10,
                                lineHeight: 15,
                                rich: {
                                    time: {
                                        fontSize: 10,
                                        color: '#999'
                                    }
                                }
                            },
                            labelLine: {
                                length: 15,
                                length2: 0,
                                maxSurfaceAngle: 80
                            },
                            emphasis: {
                                itemStyle: {
                                    shadowBlur: 10,
                                    shadowOffsetX: 0,
                                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                                }
                            }
                        }
                    ]
                };
                outWarehouse.setOption(option)
            }
        })
    }

    function getInWarehouse() {
        $.ajax({
            url: "${pageContext.request.contextPath}/ReportDataStatistics",
            type: 'post',
            dataType: 'json',
            data: {type: $("#inWarehouseType option:selected").val()},
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                let inWarehouse = echarts.init(document.getElementById("inWarehouse"));
                let option = {
                    title: {
                        text: '入库数据统计(产线)',
                        subtext: '合计方量：' + (res.sum || 0),
                        left: 'center'
                    },
                    tooltip: {
                        trigger: 'item'
                    },
                    legend: {
                        orient: 'vertical',
                        left: 'left'
                    },
                    series: [
                        {
                            type: 'pie',
                            radius: '50%',
                            data: res.data,
                            label: {
                                alignTo: 'edge',
                                formatter: '{name|{b}}\n{time|{c} 方量}',
                                minMargin: 5,
                                edgeDistance: 10,
                                lineHeight: 15,
                                rich: {
                                    time: {
                                        fontSize: 10,
                                        color: '#999'
                                    }
                                }
                            },
                            labelLine: {
                                length: 15,
                                length2: 0,
                                maxSurfaceAngle: 80
                            },
                            emphasis: {
                                itemStyle: {
                                    shadowBlur: 10,
                                    shadowOffsetX: 0,
                                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                                }
                            }
                        }
                    ]
                };
                inWarehouse.setOption(option)
            }
        })
    }

    function getWarehouse() {
        $.ajax({
            url: "${pageContext.request.contextPath}/ReportDataStatistics",
            type: 'post',
            dataType: 'json',
            data: {type: 'warehouse'},
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                let str1 = '<td class="tdStyle_title active" style="width: 150px" >昨日库存统计</td>'
                let str2 = "<td class='tdStyle_body' style='width: 150px'>方量:</td>"
                res.data.forEach((v, i) => {
                    str1 += '<td class="tdStyle_title active" >' + v.name + '</td>'
                    str2 += "<td class='tdStyle_body' >" + v.value + "</td>"
                })
                str1 += '<td class="tdStyle_title active" >合计</td>'
                str2 += "<td class='tdStyle_body' >" + res.sum + "</td>"
                $("#table_head").html(str1)
                $("#table_body").html(str2)
            }
        })
    }
</script>

<style>
    ::-webkit-scrollbar {
        /*滚动条整体样式*/
        width: 6px;
        /*高宽分别对应横竖滚动条的尺寸*/
        height: 6px;
    }

    ::-webkit-scrollbar-thumb {
        /*滚动条里面小方块*/
        border-radius: 10px;
        background-color: skyblue;
        background-image: -webkit-linear-gradient(45deg,
        rgba(255, 255, 255, 0.2) 25%,
        transparent 25%,
        transparent 50%,
        rgba(255, 255, 255, 0.2) 50%,
        rgba(255, 255, 255, 0.2) 75%,
        transparent 75%,
        transparent);
    }

    ::-webkit-scrollbar-track {
        /*滚动条里面轨道*/
        box-shadow: inset 0 0 5px rgba(0, 0, 0, 0.2);
        background: #ededed;
        border-radius: 10px;
    }

    .title {
        color: #777;
        margin-bottom: 10px;
    }

    .frame {
        width: 46%;
        height: 500px;
        margin: 0 20px 10px 20px;
    }

    .pie {
        width: 100%;
        height: 445px;
    }
</style>
</html>
