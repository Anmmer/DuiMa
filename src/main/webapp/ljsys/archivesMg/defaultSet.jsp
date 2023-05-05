<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div style="height: 95%;width: 100%;">
    <div style="width:70%;margin: 0 auto">
        <div style="height:12%;padding-top:2%">
            <span style="font-weight: 700">开启隐蔽性检验：</span>
            <label for="yes">
                <input type="radio" name="concealed_process" id="yes" value="1" onclick="setData('yes')"/> 是
                <input type="radio" name="concealed_process" id="no" value="0" onclick="setData('no')"/> 否
            </label>
        </div>
    </div>
    <div style="width:70%;margin: 0 auto">
        <div style="height:12%;padding-top:2%">
            <span style="font-weight: 700">二维码标签格式输出：</span>
            <label for="yes1">
                <input type="radio" name="concealed_print" id="yes1" value="1" onclick="setPrintData('yes1')"/> PDF格式
                <input type="radio" name="concealed_print" id="no1" value="0" onclick="setPrintData('no1')"/> 图片格式
            </label>
        </div>
    </div>
</div>

<script>
    // window.onload = getData();
    // window.onload=getPrintData();
    window.onload=function (){
        getData();
        getPrintData();
    }

    function getData() {
        $.ajax({
            url: "${pageContext.request.contextPath}/GetDefaultSet",
            type: 'post',
            dataType: 'json',
            data: null,
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                if (res.data !== undefined) {
                    res.data.forEach((item) => {
                        if (item.name === 'concealed_process') {
                            item.on_or_off === '1' ? $('#yes').attr("checked", true) : $('#no').attr("checked", true);
                        }
                    })
                }
            }
        })
    }

    function setData(id) {
        let val = document.getElementById(id).value;
        $.ajax({
            url: "${pageContext.request.contextPath}/UpdateDefaultSet",
            type: 'post',
            dataType: 'json',
            data: {name: 'concealed_process', on_or_off: val},
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                if (res.flag) {
                    alert(res.message)
                }
            }
        })
    }

    function getPrintData() {
        $.ajax({
            url: "${pageContext.request.contextPath}/GetPrintSet",
            type: 'post',
            dataType: 'json',
            data: null,
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res1) {
                if (res1.data !== undefined) {
                    res1.data.forEach((item) => {
                        if (item.name === 'concealed_print') {
                            item.on_or_off === '1' ? $('#yes1').attr("checked", true) : $('#no1').attr("checked", true);
                        }
                    })
                }
            }
        })
    }

    function setPrintData(id) {
        let val = document.getElementById(id).value;
        $.ajax({
            url: "${pageContext.request.contextPath}/UpdatePrintSet",
            type: 'post',
            dataType: 'json',
            data: {name: 'concealed_print', on_or_off: val},
            contentType: 'application/x-www-form-urlencoded;charset=utf-8',
            success: function (res) {
                if (res.flag) {
                    alert(res.message)
                }
            }
        })
    }
</script>
