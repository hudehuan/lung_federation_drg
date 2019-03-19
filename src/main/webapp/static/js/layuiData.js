/**
 * Created by 吴岳峰 on 2017/08/26.
 */
function initLayuiTableData(data,dataIndex,fWidth,colWidth) {
    colWidth = colWidth||80;
    var title = []; //报表表头
    dataIndex = dataIndex||[];  //数据下标
    var cols =[];   //表头
    var tableData = [];  //数据

    if(Object.prototype.toString.call(data.title.column)=='[object Array]'){
        title = data.title.column[data.title.column.length-1].split(",");
    }else{
        title = data.title.column.split(",");  //报表表头
    }
    if(dataIndex.length>0){  //数据下标   有值时按下标，空时循环全部
        for(var i=0;i<dataIndex.length;i++){
            if(title[dataIndex[i]]!="#rspan"){
                if(i==0){
                    var tit = {"field":"td"+dataIndex[i],"title":title[dataIndex[i]],"width":fWidth,"align":"center",sort: true, fixed: 'left'};
                }else {
                    var tit = {"field":"td"+dataIndex[i],"title":title[dataIndex[i]],"width":colWidth,"align":"center",sort: true};
                }
                cols.push(tit);
            }
        }
    }else {
        for(var i=0;i<title.length;i++){
            dataIndex.push(i);
            if(title[i]!="#rspan"){
                if(i==0){
                    var tit = {"field":"td"+i,"title":title[i],"width":fWidth,"align":"center",sort: true, fixed: 'left'};
                }else {
                    var tit = {"field":"td"+i,"title":title[i],"width":colWidth,"align":"center",sort: true};
                }
                cols.push(tit);
            }

        }
    }
    for(var n=0;n<data.rows.row.length;n++){
        var json = "{";
        for(var m=0;m<dataIndex.length;m++){
            var val;
            if(Object.prototype.toString.call(data.rows.row[n].cell[dataIndex[m]])=='[object Object]'&&m<4){
                val = data.rows.row[n].cell[dataIndex[m]]['#text'];
            }else{
                val = data.rows.row[n].cell[dataIndex[m]];
            }
            if(parseFloat(val).toString() != "NaN"){
                val = Number(val);
                if( val==0){
                    val = '--';
                    json += '"td'+dataIndex[m]+'":"'+val+'"';
                }else{
                    json += '"td'+dataIndex[m]+'":'+val;
                }
            }else{
                json += '"td'+dataIndex[m]+'":"'+val+'"';
            }
            if(m<dataIndex.length-1){
                json +=',';
            }
        }
        json+="}";
        tableData.push(JSON.parse(json));
    }
    return {"cols":cols,"data":tableData};
}
//test
function test(loads) {
    if(loads==0){
        $("#loading").fadeOut("slow");
    }
}