/**
 * d3.tip http://labratrevenge.com/d3-tip/
 * Copyright (c) 2013-2017 Justin Palmer
 *
 * Tooltips for d3.js SVG visualizations
 */
// eslint-disable-next-line no-extra-semi
;(function(root, factory) {
  if (typeof define === 'function' && define.amd) {
    // AMD. Register as an anonymous module with d3 as a dependency.
    define([
      'd3-collection',
      'd3-selection'
    ], factory)
  } else if (typeof module === 'object' && module.exports) {
    /* eslint-disable global-require */
    // CommonJS
    var d3Collection = require('d3-collection'),
        d3Selection = require('d3-selection')
    module.exports = factory(d3Collection, d3Selection)
    /* eslint-enable global-require */
  } else {
    // Browser global.
    var d3 = root.d3
    // eslint-disable-next-line no-param-reassign
    root.d3.tip = factory(d3, d3)
  }
}(this, function(d3Collection, d3Selection) {
  // Public - contructs a new tooltip
  //
  // Returns a tip
  return function() {
    var direction   = d3TipDirection,
        offset      = d3TipOffset,
        html        = d3TipHTML,
        rootElement = document.body,
        node        = initNode(),
        svg         = null,
        point       = null,
        target      = null

    function tip(vis) {
      svg = getSVGNode(vis)
      if (!svg) return
      point = svg.createSVGPoint()
      rootElement.appendChild(node)
    }

    // Public - show the tooltip on the screen
    //
    // Returns a tip
    tip.show = function() {
      var args = Array.prototype.slice.call(arguments)
      if (args[args.length - 1] instanceof SVGElement) target = args.pop()

      var content = html.apply(this, args),
          poffset = offset.apply(this, args),
          dir     = direction.apply(this, args),
          nodel   = getNodeEl(),
          i       = directions.length,
          coords,
          scrollTop  = document.documentElement.scrollTop ||
            rootElement.scrollTop,
          scrollLeft = document.documentElement.scrollLeft ||
            rootElement.scrollLeft

      nodel.html(content)
        .style('opacity', 1).style('pointer-events', 'all')

      while (i--) nodel.classed(directions[i], false)
      coords = directionCallbacks.get(dir).apply(this)
      nodel.classed(dir, true)
        .style('top', (coords.top + poffset[0]) + scrollTop + 'px')
        .style('left', (coords.left + poffset[1]) + scrollLeft + 'px')

      return tip
    }

    // Public - hide the tooltip
    //
    // Returns a tip
    tip.hide = function() {
      var nodel = getNodeEl()
      nodel.style('opacity', 0).style('pointer-events', 'none')
      return tip
    }

    // Public: Proxy attr calls to the d3 tip container.
    // Sets or gets attribute value.
    //
    // n - name of the attribute
    // v - value of the attribute
    //
    // Returns tip or attribute value
    // eslint-disable-next-line no-unused-vars
    tip.attr = function(n, v) {
      if (arguments.length < 2 && typeof n === 'string') {
        return getNodeEl().attr(n)
      }

      var args =  Array.prototype.slice.call(arguments)
      d3Selection.selection.prototype.attr.apply(getNodeEl(), args)
      return tip
    }

    // Public: Proxy style calls to the d3 tip container.
    // Sets or gets a style value.
    //
    // n - name of the property
    // v - value of the property
    //
    // Returns tip or style property value
    // eslint-disable-next-line no-unused-vars
    tip.style = function(n, v) {
      if (arguments.length < 2 && typeof n === 'string') {
        return getNodeEl().style(n)
      }

      var args = Array.prototype.slice.call(arguments)
      d3Selection.selection.prototype.style.apply(getNodeEl(), args)
      return tip
    }

    // Public: Set or get the direction of the tooltip
    //
    // v - One of n(north), s(south), e(east), or w(west), nw(northwest),
    //     sw(southwest), ne(northeast) or se(southeast)
    //
    // Returns tip or direction
    tip.direction = function(v) {
      if (!arguments.length) return direction
      direction = v == null ? v : functor(v)

      return tip
    }

    // Public: Sets or gets the offset of the tip
    //
    // v - Array of [x, y] offset
    //
    // Returns offset or
    tip.offset = function(v) {
      if (!arguments.length) return offset
      offset = v == null ? v : functor(v)

      return tip
    }

    // Public: sets or gets the html value of the tooltip
    //
    // v - String value of the tip
    //
    // Returns html value or tip
    tip.html = function(v) {
      if (!arguments.length) return html
      html = v == null ? v : functor(v)

      return tip
    }

    // Public: sets or gets the root element anchor of the tooltip
    //
    // v - root element of the tooltip
    //
    // Returns root node of tip
    tip.rootElement = function(v) {
      if (!arguments.length) return rootElement
      rootElement = v == null ? v : functor(v)

      return tip
    }

    // Public: destroys the tooltip and removes it from the DOM
    //
    // Returns a tip
    tip.destroy = function() {
      if (node) {
        getNodeEl().remove()
        node = null
      }
      return tip
    }

    function d3TipDirection() { return 'n' }
    function d3TipOffset() { return [0, 0] }
    function d3TipHTML() { return ' ' }

    var directionCallbacks = d3Collection.map({
          n:  directionNorth,
          s:  directionSouth,
          e:  directionEast,
          w:  directionWest,
          nw: directionNorthWest,
          ne: directionNorthEast,
          sw: directionSouthWest,
          se: directionSouthEast
        }),
        directions = directionCallbacks.keys()

    function directionNorth() {
      var bbox = getScreenBBox()
      return {
        top:  bbox.n.y - node.offsetHeight,
        left: bbox.n.x - node.offsetWidth / 2
      }
    }

    function directionSouth() {
      var bbox = getScreenBBox()
      return {
        top:  bbox.s.y,
        left: bbox.s.x - node.offsetWidth / 2
      }
    }

    function directionEast() {
      var bbox = getScreenBBox()
      return {
        top:  bbox.e.y - node.offsetHeight / 2,
        left: bbox.e.x
      }
    }

    function directionWest() {
      var bbox = getScreenBBox()
      return {
        top:  bbox.w.y - node.offsetHeight / 2,
        left: bbox.w.x - node.offsetWidth
      }
    }

    function directionNorthWest() {
      var bbox = getScreenBBox()
      return {
        top:  bbox.nw.y - node.offsetHeight,
        left: bbox.nw.x - node.offsetWidth
      }
    }

    function directionNorthEast() {
      var bbox = getScreenBBox()
      return {
        top:  bbox.ne.y - node.offsetHeight,
        left: bbox.ne.x
      }
    }

    function directionSouthWest() {
      var bbox = getScreenBBox()
      return {
        top:  bbox.sw.y,
        left: bbox.sw.x - node.offsetWidth
      }
    }

    function directionSouthEast() {
      var bbox = getScreenBBox()
      return {
        top:  bbox.se.y,
        left: bbox.se.x
      }
    }

    function initNode() {
      var div = d3Selection.select(document.createElement('div'))
      div
        .style('position', 'absolute')
        .style('top', 0)
        .style('opacity', 0)
        .style('pointer-events', 'none')
        .style('box-sizing', 'border-box')

      return div.node()
    }

    function getSVGNode(element) {
      var svgNode = element.node()
      if (!svgNode) return null
      if (svgNode.tagName.toLowerCase() === 'svg') return svgNode
      return svgNode.ownerSVGElement
    }

    function getNodeEl() {
      if (node == null) {
        node = initNode()
        // re-add node to DOM
        rootElement.appendChild(node)
      }
      return d3Selection.select(node)
    }

    // Private - gets the screen coordinates of a shape
    //
    // Given a shape on the screen, will return an SVGPoint for the directions
    // n(north), s(south), e(east), w(west), ne(northeast), se(southeast),
    // nw(northwest), sw(southwest).
    //
    //    +-+-+
    //    |   |
    //    +   +
    //    |   |
    //    +-+-+
    //
    // Returns an Object {n, s, e, w, nw, sw, ne, se}
    function getScreenBBox() {
      var targetel   = target || d3Selection.event.target

      while (targetel.getScreenCTM == null && targetel.parentNode == null) {
        targetel = targetel.parentNode
      }

      var bbox       = {},
          matrix     = targetel.getScreenCTM(),
          tbbox      = targetel.getBBox(),
          width      = tbbox.width,
          height     = tbbox.height,
          x          = tbbox.x,
          y          = tbbox.y

      point.x = x
      point.y = y
      bbox.nw = point.matrixTransform(matrix)
      point.x += width
      bbox.ne = point.matrixTransform(matrix)
      point.y += height
      bbox.se = point.matrixTransform(matrix)
      point.x -= width
      bbox.sw = point.matrixTransform(matrix)
      point.y -= height / 2
      bbox.w = point.matrixTransform(matrix)
      point.x += width
      bbox.e = point.matrixTransform(matrix)
      point.x -= width / 2
      point.y -= height / 2
      bbox.n = point.matrixTransform(matrix)
      point.y += height
      bbox.s = point.matrixTransform(matrix)

      return bbox
    }

    // Private - replace D3JS 3.X d3.functor() function
    function functor(v) {
      return typeof v === 'function' ? v : function() {
        return v
      }
    }

    return tip
  }
// eslint-disable-next-line semi
}));

function createtips(data,callback){
    var tip = d3.tip()
        .attr('class', 'd3-tip')
        .html(function(d,i) {
            var json=getdatajson(data,i);
            var values=callback&&callback(json);
            values=values||d;
            return values;
        })
    return tip;
}
function getdatajson(data,i){
    var strjson="{";
    $(data).each(function(index,obj){
        strjson+='"d'+index+'":"'+obj[i]+'",';
    });
    strjson=strjson.slice(0,strjson.length-1)+"}";
    var json=JSON.parse(strjson);
    return json;
}
function d3charts(chartid,option){
    $("#"+chartid).html("");
    option=$.extend(true, initOption(), option);
    var _mindata=[],_maxdata=[],alldata=[];
    $.each(option.series, function(index,obj) {
        var array=obj.data.map(function(item){
            if(typeof item=="string")
                return parseFloat(item);
            else
                return (item);
        });
        alldata.push(array);
        _mindata.push(d3.min(array));
        _maxdata.push(d3.max(array));
    })
    if(option.fordata)
    {
        alldata.push(option.fordata);
    }

    var mindata=d3.min(_mindata);
    var maxdata=d3.max(_maxdata);
    var warnpath={x:0,y:0,x1:0,y1:0};
    mindata=mindata>=0?0:mindata;
    var width =$("#"+chartid).width();
    var height = $("#"+chartid).height();
    var padding = {left:$("#"+chartid).offset().left+option.left, top:$("#"+chartid).offset().top+option.top,right:option.left,bottom:option.top };
    //x轴的比例尺
    var xScale = d3.scale.ordinal()
        .domain(option.xAxis)
        .rangeRoundPoints([0, width - padding.left- padding.right ]);

    //y轴的比例尺
    var yScale = d3.scale.linear()
        .domain([mindata,maxdata])
        .range([height - padding.top- padding.bottom , mindata]).nice();

    //定义x轴
    var xAxis = d3.svg.axis()
        .scale(xScale)
        .orient("bottom").ticks(option.xAxis, 1);//.tickValues();

    //定义y轴
    var yAxis = d3.svg.axis()
        .scale(yScale)
        .orient("left");
    if(option.yAxis.formatter)
    {

        yAxis.tickFormat(function(d){return option.yAxis.formatter(d);});
    }

    var svg = d3.select("#"+chartid)
        .append("svg")
        .attr("width", width)
        .attr("height", height);
    var tip=createtips(alldata,option.tooltips.formatter);
    svg.call(tip);
    var line = d3.svg.line()
        .x(function(d,i) {  return xScale(option.xAxis[i]); })
        .y(function(d) { return yScale(d); })
        .interpolate("cardinal");//插值模式  ;

    //画线
    var path = svg.selectAll(".line")
        .data([option.yAxis.data])
        .enter()
        .append("path")
        .attr("transform","translate("+padding.left+","+padding.top+")")
        .attr("d",line)
        .attr("fill", "none")
        .attr("stroke", option.yAxis.line.color)
        .attr("stroke-width", option.yAxis.line.width)
    //添加x轴
    var sx=svg.append("g")
        .attr("class","axis")
        .attr("transform","translate(" + padding.left + "," + (height- padding.bottom) + ")")
        if(!option.xshow)
        {
            sx.attr("style","opacity: 0");
        }
        sx.call(xAxis);

    //添加y轴
    svg.append("g")
        .attr("class","axis")
        .attr("transform","translate(" + padding.left + "," + padding.top + ")")
        .call(yAxis);
    var markstart=[];
    var markend=[];
    $.each(option.series, function(index,obj) {
        var dot=svg.selectAll(".dot")
            .data(obj.data)
            .enter().append("circle")
            .attr("cx", line.x())
            .attr("cy", line.y())
            .attr("r", obj.width).attr("transform","translate(" + padding.left + "," + padding.top + ")")
            .attr("stroke",obj.stroke).attr("stroke-width","1.5px;").attr("fill",option.colors[index]);
        if(obj.mouse)
        {
            dot.on('mouseover', tip.show)
                .on('mouseout', tip.hide)
        }
        if(obj.click)
        {
            dot.on("click",function(d,i){
                var json=getdatajson(alldata,i);
                obj.click&&obj.click(json);
            })
        }

        //连接线
        if(option.linestyle.show)
        {
            if(option.linestyle.startindex==index)
            {
                for(var i=0;i<obj.data.length;i++)
                {
                    markstart.push({x:xScale(option.xAxis[i])+(padding.left),y:yScale(obj.data[i])+(padding.top)});
                }
            }
            if(option.linestyle.endindex==index)
            {
                for(var i=0;i<obj.data.length;i++)
                {
                    markend.push({x2:xScale(option.xAxis[i])+(padding.left),y2:yScale(obj.data[i])+(padding.top)});
                }
            }

        }
    });
    if(option.linestyle.show)
    {
        var markdata=$.extend(true,markstart,markend);
        svg.selectAll(".markline").data(markdata).enter()
            .append("path")
            .attr("stroke",option.linestyle.color)
            .attr("stroke-width",option.linestyle.width)
            .attr("d",function(d){
                return "M"+d.x +","+d.y+"L"+d.x2+","+d.y2+"Z";
            })
    }
    //legend
    var legend = svg.selectAll(".legend")
        .data(option.legend)
        .enter().append("g")
        .attr("class", "legend")
        .attr("transform", function(d, i) { return "translate(" + i * (option.titlewidth )+ ",0)"; });

    legend.append("circle")
        .attr("r", 4)
        .attr("cx", (width/2)-(option.titlewidth-15))
        .attr("cy", 9)
        .attr("stroke",function(d,i){return option.series[i].stroke}).attr("stroke-width","1.5px;")
        .style("fill", function(d,i){return option.colors[i]});

    legend.append("text")
        .attr("x", width/2)
        .attr("y", 9)
        .attr("dy", ".35em")
        .attr("font-size","12px")
        .attr("color","#333")
        .style("text-anchor", "end")
        .text(function(d) { return d; });
    //网格线
    var yInner = d3.svg.axis().scale(yScale)
        .tickSize(-(width-padding.left-padding.right),0,0)
        .tickFormat("")
        .orient("left")
        .ticks(10); //添加纵轴网格线
    var yBar=svg.append("g") .attr("class", "inner_line")
        .attr("transform", "translate("+padding.left+","+padding.top+")")
        .call(yInner);
    //警示线
    if(option.yAxis.warnline)
    {
        warnpath.x=xScale(option.xAxis[0])+(padding.left);
        warnpath.y=yScale(option.yAxis.warnline.value)+padding.top;
        warnpath.x1=width-padding.right;
        warnpath.y1=yScale(option.yAxis.warnline.value)+padding.top;
        svg.selectAll(".warnline").data([warnpath]).enter()
            .append("path")
            .attr("stroke",option.yAxis.warnline.color)
            .attr("stroke-width","1")
            .attr("stroke-dasharray","5,5")
            .attr("d",function(d){
                return "M"+d.x +","+d.y+"L"+d.x1+","+d.y1+"Z";
            })
    }

}
function initOption(){
    var  option={
        titlewidth:100,
        xshow:false,
        legend:["","",""],
        tooltips:{formatter:function(data){ return "门诊:"+data.d0+"住院:"+data.d1+"平均:"+data.d2}},
        colors:["#4682B4","#FFFFFF","#FF0000"],
        xAxis:[],
        yAxis:{data:[],formatter:null,
            line:{color:"#ccc",width: "1.5px"},warnline:{color:"#ff0000",value:0.1}},
        linestyle:{show:true,startindex:0,endindex:2,color:"#cec9c9"},
        series:[
            {name:"",width:4,stroke:"",data:[],mouse:true,click:function(data){}},
        ],
    };
    return option;
}