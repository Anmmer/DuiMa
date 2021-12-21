// 读取 excel文件
function outputWorkbook(workbook) {
    let sheetNames = workbook.SheetNames; // 工作表名称集合
    let zn_title = ['物料编码', '项目名称', '楼栋楼层', '构件尺寸', '构件编号', '体积', '重量', '质检员', '日期'];
    let en_title = ['materialcode', 'projectname', 'build', 'size', 'preproductid', 'volume', 'weigh', 'qc', 'time'];
    // let excelDatas = [];
    // sheetNames.forEach(name => {
        let excelData = {};
        let worksheet = workbook.Sheets[sheetNames[0]]; // 只能通过工作表名称来获取指定工作表
        //检测excel表格式
        let plan = {};
        if (worksheet['A1'] !== undefined) {
            plan.planname = worksheet['A1'].v;
        } else {
            alert("计划名不能为空")
            return;
        }
        if (worksheet['B3'].v === '公司') {
            if (worksheet['B4'] !== undefined) {
                plan.company = worksheet['B4'].v;
            } else {
                plan.company = '';
            }
        } else {
            alert("excel格式不正确")
            return;
        }
        if (worksheet['C3'].v === '工厂') {
            if (worksheet['C4'] !== undefined) {
                plan.plant = worksheet['C4'].v;
            }else {
                plan.plant = '';
            }
        } else {
            alert("excel格式不正确")
            return;
        }

        let row = 10;
        let col = 66;
        for (let i = 0; i < zn_title.length; i++) {
            let s = String.fromCharCode(col) + row;
            if (worksheet[s].v !== zn_title[i]) {
                alert("excel格式不正确")
                return;
            }
            col++;
        }

        row++;
        col = 66;
        let keys = Object.keys(worksheet);
        let num = parseInt(keys[keys.length - 3].match(/[0-9]+/g));
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
            col = 66;
            preProduct.push(object);
        } while (row <= num)
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
            console.log(fromTo);
            persons = persons.concat(XLSX.utils.sheet_to_json(workbook.Sheets[sheet]));
            // break; // 如果只取第一张表，就取消注释这行
        }
    }
    console.log(persons)

}
