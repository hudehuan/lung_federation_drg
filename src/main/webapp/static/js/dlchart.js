/**
 * Created by xusui on 2017/8/16.
 */
(function(global,$){
    if (global.dlchart) {
        return;
    }
    var dlchart = global.dlchart = {
        // The current version of js being used
        version: "0.1"
    }
    dlchart.chartOption={};
    dlchart.getTarget=function(targetData,callback){
        var tlist=[],dlist=[];
        $(targetData).each(function(index,item){
            tlist.push(item.name);
            var values=callback&&callback(index,item);
            dlist.push(values);
        });
        return {legend:tlist,series:dlist};//包含两个对象，指标名称列表和series数据
    }
    dlchart.getColors=function(legend){
       var dlColors= ['#0470aa','#1177ae','#2985b7','#4394bf','#5ca2c8','#75b0d0','#8ebfd9','#c0dbea'];
        var colors=[];
        if(legend.length>=dlColors.length)
        {
            colors=dlColors;
        }
        else
        {
            for(var i=0;i<legend.length;i++){
                colors.push(dlColors[i]);
            }
        }
        return colors;
    }
    //深拷贝比对
    dlchart.extend=function(old,newd){
        if(newd)
        return $.extend(true,old,newd);
        else
            return old;
    }
    dlchart.Sum=function(arr){
        var sum=arr.reduce(function(previousValue, currentValue){
                return (parseFloat(currentValue) + parseFloat(previousValue)).toFixed(2);
        });
        return sum;
    }
    /**
     * dlchart.getReportData 列转对象数组
     * @param {Array} list  报表json数据
     * @returns [] json格式 {name:"",data:[]}
     */
    dlchart.getReportData=function(list){
        var str=list.title.column;
        var column=[],rows=list.rows.row;
        if(typeof str =="string")
        {
            column=str.split(',');
        }
        if(typeof str =="object")
        {
            column=str[0].split(',');
        }
        var datalist=[];
        //列转对象
        $(column).each(function(index,data){
            var title=data;
            var valuelist=[];
            for(var i=0;i<rows.length;i++){
                valuelist.push(rows[i].cell[index]);
            }
            datalist.push({name:title,data:valuelist});
        });
     return datalist;
    }
    /**
     * dlchart.CreateLineChart 折线图
     * @param {string} title 图形标题
     * @param {Array} xdata  X轴数组
     * @param {Array} targetData 数据展示 ,格式 {name:"",data:[]},dlchart.getReportData方法可直接返回改格式数据
     * @param {Object}calloption 用于新增echart属性，可覆盖
     * @returns []
     */
    dlchart.CreateLineChart=function(title,xdata,targetData,calloption,itemoption){
        var legend=[],series=[];
       //个性化series
        var targets=dlchart.getTarget(targetData,function(index,item){
            var obj={name:item.name,
                    type:'line',
                    stack: item.name,
                smooth:true,
                symbol : 'emptyCircle',
                symbolSize:10,
                    data:item.data};
            var newobj=obj;//合并传入的属性对象
            if(itemoption&&itemoption.index>=0)
            {
                if(itemoption.index==index)
                    newobj=dlchart.extend(obj,itemoption.option);
            }
            return newobj;
        });
        //颜色值
        var colors =dlchart.getColors(targets.legend);

        //属性
        var option = {
            title: {
                text: title
            },
            color:colors,
            tooltip: {
                trigger: 'axis'
            },
            legend: {
                data:targets.legend
            },
            xAxis: {
                type: 'category',
                boundaryGap: false,
                data: xdata
            },
            yAxis: {
                type: 'value',
                axisLabel: {
                    formatter: '{value}'
                }
            },
            series: targets.series
        };
        dlchart.chartOption= dlchart.extend(option,calloption);//合并传入的属性对象
        return dlchart.chartOption;
    }
    /**
     * dlchart.CreateBarChart 柱状图
     * @param {string} title 图形标题
     * @param {Array} xdata  X轴数组
     * @param {Array} targetData 数据展示 ,格式 [{name:"",data:[]}]
     * @param {Object}calloption 用于新增echart属性，可覆盖
     * @param {Object}itemoption 用于单个指标项属性，可覆盖
     * @param {Object}fzobj {name:"",value:}是否辅助
     * @returns []
     */
    dlchart.CreateBarChart=function(title,xdata,targetData,calloption,itemoption,fzobj){
        var fzlist=[];
        //是否有柱状图辅助
        if(fzobj)
        {
            var num= 0;
            $(targetData).each(function(index,item){
                num= dlchart.Sum(item.data);
                var data=[];
                data.unshift(0);
                $(item.data).each(function(i,d) {
                    num=(num-d).toFixed(2);;
                    data.push(num);
                })
                var obj={
                    name: '辅助',
                    type: 'bar',
                    stack:  item.name,
                    itemStyle: {
                        normal: {
                            barBorderColor: 'rgba(0,0,0,0)',
                            color: 'rgba(0,0,0,0)'
                        },
                        emphasis: {
                            barBorderColor: 'rgba(0,0,0,0)',
                            color: 'rgba(0,0,0,0)'
                        }
                    },
                    data: data
                }
                fzlist.push(obj);
            });
            xdata.unshift(fzobj.name);
        }
        //个性化series
        var targets=dlchart.getTarget(targetData,function(index,item){
            var data=item.data;
            if(fzobj)
                data.unshift(dlchart.Sum(data));
            var obj={name:item.name,
                type:'bar',
                stack: item.name,
                label: {
                    normal: {
                        show: true,
                        position: 'inside'
                    }
                },
                data:data
            };
            var newobj=obj;//合并传入的属性对象
            if(itemoption&&itemoption.index>=0)
            {
                if(itemoption.index==index)
                newobj=dlchart.extend(obj,itemoption.option);
            }
            return newobj;
        });
        $(fzlist).each(function(index,d){
            targets.series.unshift(d);
        });
        //颜色值
        var colors =dlchart.getColors(targets.legend);

        //属性
        var option = {
            title: {
                text: title
            },
            color:colors,
            tooltip: {
                trigger: 'axis'
            },
            legend: {
                data:targets.legend
            },
            xAxis: {
                type: 'category',
                data: xdata
            },
            yAxis: {
                type: 'value',
                axisLabel: {
                    formatter: '{value}'
                }
            },
            series: targets.series
        };
        dlchart.chartOption= dlchart.extend(option,calloption);//合并传入的属性对象
        return dlchart.chartOption;
    }
    /**
     * dlchart.CreatePieChart 饼图
     * @param {string} title 图形标题
     * @param {Array} xdata  X轴数组
     * @param {Array} targetData 数据展示 ,格式 [{name:"",data:[name:"",value:]}]
     * @param {Object}calloption 用于新增echart属性，可覆盖
     * @returns []
     */
    dlchart.CreatePieChart=function(title,xdata,targetData,calloption,itemoption){
        var legend=[],series=[];
        //个性化series
        var targets=dlchart.getTarget(targetData,function(index,item){
            var obj={name:item.name,
                type:'pie',
                radius: ['40%', '55%'],
                data:item.data
            };
            var newobj=obj;//合并传入的属性对象
            if(itemoption&&itemoption.index>=0)
            {
                if(itemoption.index==index)
                    newobj=dlchart.extend(obj,itemoption.option);
            }
            return newobj;
        });
        //颜色值
        var colors =dlchart.getColors(xdata);

        //属性
        var option = {
            color:colors,
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b}: {c} ({d}%)"
            },
            legend: {
                orient: 'horizontal',
                x:'left',
                y: 'bottom',
                data:xdata
            },
            series:targets.series
        };
        dlchart.chartOption= dlchart.extend(option,calloption);//合并传入的属性对象
        return dlchart.chartOption;
    }
    /**
     * dlchart.CreateCatterChart 散点图
     * @param {string} title 图形标题
     * @param {Object} xdata  格式 {x:"",y:""}
     * @param {Object} targetData 数据展示 ,格式 [{name:"",data:[[x,y,mc,legend],]}]
     * @param {Object}calloption 用于新增echart属性，可覆盖
     * @param {Object}itemOption 格式{index:0,option:{}}用于项目chart属性，可覆盖
     * @param {number}rx 系数用于泡泡大小
     * @returns []
     */
    dlchart.CreateCatterChart=function(title,xdata,targetData,calloption,itemOption,rx){
        //颜色值
        var colors =dlchart.getColors(targetData);
        rx=rx||400;
        //个性化series
        var targets=dlchart.getTarget(targetData,function(index,item){
            var obj={name:item.name,
                type: 'scatter',
                symbolSize: function (data) {
                    return data[data.length-1]/rx;
                },
                data:item.data,
                label: {
                emphasis: {
                    show: true,
                    position: 'top'
                }
            }, itemStyle: {
                normal: {
                    // color: function(params) {
                    //     var rnd =parseInt(Math.random()*(14-0+1)+0,10)
                    //     console.log(rnd)
                    //     // build a color map as your need.
                    //     var colorList = [
                    //         '#C1232B','#B5C334','#FCCE10','#E87C25','#27727B',
                    //         '#FE8463','#9BCA63','#FAD860','#F3A43B','#60C0DD',
                    //         '#D7504B','#C6E579','#F4E001','#F0805A','#26C0C0'
                    //     ];
                    //     return colorList[rnd]
                    // },
                    shadowBlur: 10,
                        shadowColor: 'rgba(120, 36, 50, 0.5)',
                        shadowOffsetY: 5,
                        color:colors[index]
                }
            }
            };
            var newobj=obj;//合并传入的属性对象

            if(itemOption) {
                if( Object.prototype.toString.call(itemOption) =='[object Array]' ){
                $(itemOption).each(function(i,item){
                    if(item.index>=0&&item.index==index)
                        newobj=dlchart.extend(obj,item.option);
                });
            }else{
                if(itemOption.index==index)
                    newobj=dlchart.extend(obj,itemOption.option);
            }
            }



            //if(itemOption&&itemOption.index>=0)
            //{
            //    if(itemOption.index==index)
            //        newobj=dlchart.extend(obj,itemOption.option);
            //}
            return newobj;
        });

        //属性
        var option =
        {
        legend: {
            data: targets.legend
        },
        xAxis: {
            show: true,     //显示横轴false-不显示，true-显示
                name:xdata.x,
                splitLine: {
                lineStyle: {
                    type: 'dashed'
                }
            }
        },
        yAxis: {
            show: true,     //显示横轴false-不显示，true-显示
                name:xdata.y,
                splitLine: {
                lineStyle: {
                    type: 'dashed'
                }
            },
            scale: true
        },
        textStyle:{
            color:'#000',
        },
        series:targets.series
    }
        dlchart.chartOption= dlchart.extend(option,calloption);//合并传入的属性对象
        return dlchart.chartOption;
    }
    /**
     * dlchart.CreateHeatMapChart 热力图
     * @param {string} title 图形标题
     * @param {Object} xdata  格式 {x:[],y:[],data:[]}
     * @param {Object}calloption 用于新增echart属性，可覆盖
     * @returns []
     */
    dlchart.CreateHeatMapChart=function(title,xdata,calloption,max){

        //属性
        var option = {
            tooltip: {
                position: 'top'
            },
            animation: false,
            grid: {
                height: '80%',
                y: '10%'
            },
            xAxis: {
                type: 'category',
                data: xdata.x,
                splitLine: {
                    interval :0,
                    show: true
                }
            },
            yAxis: {
                type: 'category',
                data: xdata.y,
                splitLine: {
                    interval :0,
                    show: true
                }
            },
            visualMap: {
                min: 0,
                max: max,
                calculable: true,
                orient: 'vertical',
                left: 'right',
                color:['#bf444c', '#d88273', '#FFFFFF'],
                bottom: '5%'
            },
            series: [{
                name: '',
                type: 'heatmap',
                data: xdata.data,
                label: {
                    normal: {
                        show: false
                    }
                },

                itemStyle: {
                    emphasis: {
                        shadowBlur: 10,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    }
                }
            }]
        };

        dlchart.chartOption= dlchart.extend(option,calloption);//合并传入的属性对象
        return dlchart.chartOption;
    }
    /**
     * dlchart.CreateRadarChart 雷达图
     * @param {string} title 图形标题
     * @param {Array} xdata  X轴数组
     * @param {Array} targetData 数据展示 ,格式 [{name:"",data:[name:"",value:]}]
     * @param {Object}calloption 用于新增echart属性，可覆盖
     * @returns []
     */
    dlchart.CreateRadarChart=function(title,xdata,targetData,calloption,itemoption){

        var legend=[],series=[];
        //个性化series
        var targets=dlchart.getTarget(targetData,function(index,item){

            var obj={name:item.name,
                type:'radar',

                data:item.data
            };
            var newobj=obj;//合并传入的属性对象
            if(itemoption&&itemoption.index>=0)
            {
                if(itemoption.index==index)
                    newobj=dlchart.extend(obj,itemoption.option);
            }
            return newobj;
        });
        //颜色值
        var colors =dlchart.getColors(targetData);
        //属性
        var option = {
            color:colors,
            tooltip: {},
            radar: {
                center : ['50%','55%'],
                indicator: xdata,
                axisLabel: {
                    // 坐标轴文本标签，详见axis.axisLabel
                    show: true,
                    textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
                        color: '#ccc'
                    },
                    formatter: function (value, index) {
                        // 格式化成月/日，只在第一个刻度显示年份
                        var texts = value;
                        if (index === 5||index === 1 ||index === 3) {
                            return texts;
                        }

                    }

                },
            },
            series:targets.series
        };
        dlchart.chartOption= dlchart.extend(option,calloption);//合并传入的属性对象
        return dlchart.chartOption;
    }
})(window,$);
