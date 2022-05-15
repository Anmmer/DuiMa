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
</div>
<script>
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
</script>
