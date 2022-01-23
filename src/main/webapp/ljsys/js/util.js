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
    if (worksheet['G9'] !== undefined) {
        plan.liner = worksheet['G9'].v;
    } else {
        alert("线长不能为空！");
        return
    }

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
    if (worksheet['!rows'] === undefined) {
        num = worksheet['!ref'].split(':')[1].match(/[0-9]+/ig);
    } else {
        num = worksheet['!rows'].length;
    }
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

function outputWorkbook2(workbook) {
    var persons = []; // 存储获取到的数据
    // 遍历每张表读取
    // 表格的表格范围，可用于判断表头是否数量是否正确
    var fromTo = '';
    for (var sheet in workbook.Sheets) {
        if (workbook.Sheets.hasOwnProperty(sheet)) {
            fromTo = workbook.Sheets[sheet]['!ref'];
            (fromTo);
            persons = persons.concat(XLSX.utils.sheet_to_json(workbook.Sheets[sheet]));
            // break; // 如果只取第一张表，就取消注释这行
        }
    }
    (persons)

}
