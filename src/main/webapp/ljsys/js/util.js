// 读取 excel文件
function outputWorkbook(workbook) {
    let sheetNames = workbook.SheetNames; // 工作表名称集合
    let zn_title = ['物料编码', '物料名称', '规格', '构建编号', '构建方量', '构建重量', '砼标号'];
    let en_title = ['materialcode', 'materialname', 'standard', 'preproductid', 'fangliang', 'weigh', 'concretegrade'];
    // let excelDatas = [];
    // sheetNames.forEach(name => {
    let excelData = {};
    let worksheet = workbook.Sheets[sheetNames[0]]; // 只能通过工作表名称来获取指定工作表
    //检测excel表格式
    let plan = {};
    if (worksheet['A8'] !== undefined) {
        plan.planname = worksheet['A8'].v.split('：')[1];
    } else {
        alert("项目名不能为空！")
        return;
    }
    if (worksheet['E7'] !== undefined) {
        plan.plant = worksheet['E7'].v;
    } else {
        alert("工厂不能为空！")
        return;
    }
    if (worksheet['H7'] !== undefined) {
        plan.line = worksheet['H7'].v;
    } else {
        alert("产线不能为空！")
        return;
    }
    if (worksheet['G8'] !== undefined) {
        plan.plantime = worksheet['G8'].v.split('：')[1];
    } else {
        alert("生产日期不能为空！");
        return
    }
    // if (worksheet['G9'] !== undefined) {
    //     plan.liner = worksheet['G9'].v;
    // } else {
    //     alert("线长不能为空！");
    //     return
    // }

    let row = 10;
    let col = 67;
    for (let i = 0; i < zn_title.length; i++) {
        let s = String.fromCharCode(col) + row;
        if (worksheet[s].v !== zn_title[i]) {
            alert("excel格式不正确")
            return;
        }
        col++;
    }

    row++;
    col = 67;
    let num;
    // if (worksheet['!rows'] === undefined) {
    num = worksheet['!ref'].split(':')[1].match(/[0-9]+/ig);
    // } else {
    //     num = worksheet['!rows'].length+10;
    // }
    let preProduct = [];
    do {
        let object = {};
        for (let i = 0; i < zn_title.length; i++) {
            let s = String.fromCharCode(col) + row;
            if (worksheet[s] !== undefined) {
                object[en_title[i]] = worksheet[s].v;
            } else {
                object[en_title[i]] = '';
            }
            col++;
        }
        row++;
        col = 67;
        preProduct.push(object);
    } while (row < num)
    plan.tasksqure = worksheet['G' + num].v;
    plan.tasknum = preProduct.length;
    excelData.plan = plan;
    excelData.preProduct = preProduct;
    // excelDatas.push(excelData);
    // });
    return excelData;
}

//检验权限
function checkAuthority(au) {
    var authority = JSON.parse(sessionStorage.getItem("authority"))
    flag = false;
    for (var i = 0; i < authority.length; i++) {
        if (authority[i].fa_id == au) flag = true;
    }
    return flag;
}

function outputWorkbook2(workbook) {
    let persons = []; // 存储获取到的数据
    let data = []
    let zn_title = ['构件编码', '构件名称', '构件规格', '图号', '类型', '楼栋', '楼层', '方量'];
    let en_title = ['materialcode', 'materialname', 'standard', 'drawing_no', 'build_type', 'building_no', 'floor_no', 'fangliang'];
    // 遍历每张表读取
    // 表格的表格范围，可用于判断表头是否数量是否正确
    var fromTo = '';
    for (var sheet in workbook.Sheets) {
        if (workbook.Sheets.hasOwnProperty(sheet)) {
            fromTo = workbook.Sheets[sheet]['!ref'];
            // (fromTo);
            persons = persons.concat(XLSX.utils.sheet_to_json(workbook.Sheets[sheet]));
            break; // 如果只取第一张表，就取消注释这行
        }
    }
    for (let d of persons) {
        if (d['构件编码'] == void 0 && d['构件名称'] == void 0 && d['构件规格'] == void 0
            && d['图号'] == void 0 && d['类型'] == void 0 && d['楼栋'] == void 0 && d['楼层'] == void 0 && d['方量'] == void 0)
            break
        if (d['构件编码'] == void 0) {
            alert("构件编码不能为空")
            return
        }
        if (d['构件名称'] == void 0) {
            alert("构件名称不能为空")
            return
        }
        if (d['构件规格'] == void 0) {
            alert("构件规格不能为空")
            return
        }
        if (d['图号'] == void 0) {
            alert("图号不能为空")
            return
        }
        if (d['类型'] == void 0) {
            alert("类型不能为空")
            return
        }
        if (d['楼栋'] == void 0) {
            alert("楼栋不能为空")
            return
        }
        if (d['楼层'] == void 0) {
            alert("楼层不能为空")
            return
        }
        if (d['方量'] == void 0) {
            alert("方量不能为空")
            return
        }
        let object = {};
        for (let i = 0; i < zn_title.length; i++) {
            let s = zn_title[i]
            if (d[s] !== undefined) {
                object[en_title[i]] = d[s];
            } else {
                object[en_title[i]] = '';
            }
        }
        data.push(object)
    }
    return data
}

function getQueryVariable(variable) {
    var query = window.location.href.split("?")[1];
    var vars = query.split("&");
    for (var i = 0; i < vars.length; i++) {
        var pair = vars[i].split("=");
        if (pair[0] == variable) return pair[1];
    }
    return (false);
}
