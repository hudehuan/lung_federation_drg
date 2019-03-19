/**
 自定义扩展类，主要用于一些功能函数调用
 //调用方式dLong.方法名
 * */
(function(global, undefined) {
	if(global.dLong) {
		return
	}
	var dLong = global.dLong = {
		// The current version of js being used
		version: "0.1"
    }
    dLong.methods={};
    //------------------质控平台专用js
    dLong.getGridData=function(table,pagecount,data){
    	var griddata = {};
    	var totalcount=pagecount;
    	if(data)
            totalcount=data.totalcount;
        griddata.total = totalcount;
        griddata.rows = [];
        $.each(table, function (i, item) {
            griddata.rows.push(item);
        });	
        return griddata;
    }
    
  //-----------------公共函数
 dLong.newVue=function(newoptions){
    if(newoptions.el.substr(0,1)!='#')
    newoptions.el="#"+newoptions.el;
    var options={
        methods:dLong.methods
    };
    options= dLong.extend(true,options,newoptions)
    var app = new Vue(options);
    return app;
 };
 //---将一些公用的方法集成到vue
 dLong.methods.toLowerCase=function(msg){
     if(msg)
    return msg.toLowerCase();
 }
 dLong.methods.toUpperCase=function(msg){
    if(msg)
    return msg.toUpperCase();
 }
 dLong.methods.substr=function(msg,index,len){
    if(msg)
    return msg.substr(index,len);
 }
 dLong.methods.indexOf=function(msg,str){
    if(msg)
    return msg.indexOf(str);
 }
 dLong.methods.escape=function(msg){
    if(msg)
    return escape(msg);
 }
 dLong.methods.unescape=function(msg){
    if(msg)
    return unescape(msg);
 }
 //=======================Layui集成
 dLong.layeropen=function(w, h, title, url,newoption) {
    //iframe窗
    var options={
        type: 2,
        title: title,
        closeBtn: 1, //不显示关闭按钮
        shade: [0.3, '#000000'],
        area: [w + 'px', h + 'px'],
        offset: 'auto', //右下角弹出
        shift: 0,
        content: url //iframe的url，no代表不显示滚动条
    }
    if(newoption)
    {
        options= dLong.extend(true,options,newoption)
    }
   var index= layer.open(options);
    return index;
}
dLong.layerOpenDiv=function(w,h,title,divobj,newoption) {
    var area=[w + 'px', h + 'px'];
    if (!h) {
        area = w + 'px';
    }
    var options={
        type: 1,
        title: title,
        area:area,
        shade: [0.3, '#000000'],
        content: divobj
    }
    if(newoption)
    {
        options= dLong.extend(true,options,newoption)
    }
    var index=layer.open(options);
    return index;
}
//layer弹窗方法包含 alert、confirm
dLong.layerSuccess=function(msg, callback) {
   return layer.alert(msg, { icon: 1 }, function (index) {
        callback && callback();
        layer.close(index);
    });
}
dLong.layerError=function(msg, callback) {
   return layer.alert(msg, { icon: 11 }, function (index) {
        callback && callback();
        layer.close(index);
    });
}
dLong.layerInfo=function(msg, callback) {
   return layer.alert(msg, { icon: 0 }, function (index) {
        callback && callback();
        layer.close(index);
    });
}
dLong.layerConfirm=function(msg, success, cancel) {
   return layer.confirm(msg, { icon: 4, title: '提示' }, function (index) {
        success && success();
        layer.close(index);
    }, cancel);
}
dLong.layerMsg=function(msg, time) {
    time = time || 2000;
   return layer.msg(msg, { time: time });
}
dLong.Loading=function(newoption){
   var options={shade: [0.4, '#eee'] };
    if(newoption)
    {
        options= dLong.extend(true,options,newoption)
    }
   return layer.load(2,options );
}
 //===================================ajax
 dLong.getJSON=function(url,data,callback,isshowloading){
    var index; 
    if(isshowloading)
    {
        //--加载框处理
        index = dLong.Loading();
    }
  $.getJSON(url,data,function(obj){
    layer.close(index);  
      callback&&callback(obj);
  })
 }
 dLong.post=function(url,data,callback,isshowloading){
    var index; 
    if(isshowloading)
    {
        //--加载框处理
        index = dLong.Loading();
    }
 $.post(url,data,function(obj){
    layer.close(index);  
     callback&&callback(obj); 
 })
}
dLong.ajax=function(url,data,callback,isshowloading){
    var index; 
    if(isshowloading)
    {
        //--加载框处理
        index = dLong.Loading();
    }
$.ajax({
    url: url,
    data: data,
    type: 'post',
    dataType: 'json',
    contentType: 'application/json; charset=utf8',
    success: function(data) {
        if (data == null) {                
            return;
        }
        layer.close(index);  
        callback&&callback(obj);
    },
    error: function(xhr) {
        layer.close(index);     
        alert("出错了!" + xhr.Message);      
    },
    complete: function(XHR, TS) { XHR = null }
});
}
    dLong.ajax=function(url,data,callback,isshowloading){
        var index;
        if(isshowloading)
        {
            //--加载框处理
            index = dLong.Loading();
        }
        $.ajax({
            url: url,
            data: data,
            type: 'post',
            dataType: 'json',
            contentType: 'application/json; charset=utf8',
            success: function(obj) {
                layer.close(index);
                callback&&callback(obj);
            },
            error: function(xhr) {
                layer.close(index);
                alert("出错了!" + xhr.Message);
            },
            complete: function(XHR, TS) { XHR = null }
        });
    }
    dLong.postajax=function(url,data,callback,isshowloading){
        var index;
        if(isshowloading)
        {
            //--加载框处理
            index = dLong.Loading();
        }
        $.ajax({
            url: url,
            data: JSON.stringify(data),
            type: 'post',
            dataType: 'json',
            success: function(obj) {
                layer.close(index);
                callback&&callback(obj);
            },
            error: function(xhr) {
                layer.close(index);
                alert("出错了!" + xhr.Message);
            },
            complete: function(XHR, TS) { XHR = null }
        });
    }
 //-----------------深拷贝方法
 var class2type = {};
 ['Boolean', 'Number', 'String', 'Function', 'Array', 'Date', 'RegExp', 'Object', 'Error'].forEach(function(name){
    class2type["[object " + name + "]"] = name.toLowerCase();
 })
 dLong.type = function(obj) {
    return obj == null ? String(obj) : class2type[{}.toString.call(obj)] || "object";
};
/**
 *  isArray
 */
dLong.isArray = Array.isArray ||
    function(object) {
        return object instanceof Array;
    };
/**
 *  isArrayLike 
 * @param {Object} obj
 */
dLong.isArrayLike = function(obj) {
    var length = !!obj && "length" in obj && obj.length;
    var type = dLong.type(obj);
    if (type === "function" || dLong.isWindow(obj)) {
        return false;
    }
    return type === "array" || length === 0 ||
        typeof length === "number" && length > 0 && (length - 1) in obj;
};
/**
 *  isWindow(需考虑obj为undefined的情况)
 */
dLong.isWindow = function(obj) {
    return obj != null && obj === obj.window;
};
/**
 *  isObject
 */
dLong.isObject = function(obj) {
    return dLong.type(obj) === "object";
};
/**
 *  isPlainObject
 */
dLong.isPlainObject = function(obj) {
    return dLong.isObject(obj) && !dLong.isWindow(obj) && Object.getPrototypeOf(obj) === Object.prototype;
};
/**
 *  isEmptyObject
 * @param {Object} o
 */
dLong.isEmptyObject = function(o) {
    for (var p in o) {
        if (p !== undefined) {
            return false;
        }
    }
    return true;
};
/**
 *  isFunction
 */
dLong.isFunction = function(value) {
    return dLong.type(value) === "function";
};
 dLong.extend  = function() {
    var options, name, src, copy, copyIsArray, clone,
        target = arguments[0] || {},
        i = 1,
        length = arguments.length,
        deep = false;
    /*
    变量 options：指向某个源对象。
    变量 name：表示某个源对象的某个属性名。
    变量 src：表示目标对象的某个属性的原始值。
    变量 copy：表示某个源对象的某个属性的值。
    变量 copyIsArray：指示变量 copy 是否是数组。
    变量 clone：表示深度复制时原始值的修正值。
    变量 target：指向目标对象,申明时先临时用第一个参数值。
    变量 i：表示源对象的起始下标，申明时先临时用第二个参数值。
    变量 length：表示参数的个数，用于修正变量 target。
    变量 deep：指示是否执行深度复制，默认为 false。

    ps:源对象指的是把自己的值付给别人的对象；目标对象指的是被源对象赋值的对象
    */
    // 如果第一个参数传入的是布尔值
    if ( typeof target === "boolean" ) {
        deep = target;//设置deep变量，确定是深拷贝还是浅拷贝
        target = arguments[1] || {};//将目标对象设为第二个参数值。
        i = 2;//源对象的起始下标设为2（即从第三个参数开始算源对象）
    }
    // Handle case when target is a string or something (possible in deep copy)
    //嗯，原英文解释的很清楚
    if ( typeof target !== "object" && !dLong.isFunction(target) ) {
        target = {};
    }
    // 如果没有目标对象，那么目标对象就是jquery对象
    if ( length === i ) {
        target = this;
        --i;
    }
    //拷贝的核心部分代码
    for ( ; i < length; i++ ) {//遍历源对象
        // Only deal with non-null/undefined values
        if ( (options = arguments[ i ]) != null ) {//options就是源对象
            // Extend the base object
            for ( name in options ) {//遍历源对象的属性名
                src = target[ name ];//获取目标对象上，属性名对应的属性
                copy = options[ name ];//获取源对象上，属性名对应的属性
                // 如果复制值copy 与目标对象target相等，
                //为了避免深度遍历时死循环，因此不会覆盖目标对象的同名属性。
                if ( target === copy ) {
                    continue;
                }
                //递归地将源对象上的属性值合并到目标对象上
                //如果是深拷贝，且待拷贝的对象存在，且是普通对象或是数组
                //这一个判断条件非常关键，这正是之前疑问的症结
                //首先，普通对象的定义是:通过 "{}" 或者 "new Object" 创建的
                //回到之前的疑问，目标对象tobeCloned的属性o对象的obj不是普通对象，也不是数组，所以程序不会走到下面的分支
                if ( deep && copy && ( dLong.isPlainObject(copy) || (copyIsArray = dLong.isArray(copy)) ) ) {
                    if ( copyIsArray ) {
                        //如果是数组
                        copyIsArray = false;
                        clone = src && dLong.isArray(src) ? src : [];

                    } else {
                        clone = src && dLong.isPlainObject(src) ? src : {};
                    }
                    // 递归地拷贝
                    target[ name ] = dLong.extend( deep, clone, copy );
                } else if ( copy !== undefined ) {
                //会走到这个分支，这个分支的处理很暴力，就是把源对象的属性，直接赋给源对象。
                //对于上文中tobeCloned对象的属性o，没有进一步递归地拷贝，而是直接把引用赋给源对象
                //所以改变tobeCloned的o属性时，目标对象的o属性也被改变了。
                    target[ name ] = copy;
                }
            }
        }
    }
    // Return the modified object
    return target;
};

  //限制访问的频率，主要用于搜索等业务
	dLong.debounce= function(func, wait, immediate) {
        // immediate默认为false
        var timeout, args, context, timestamp, result;
    
        var later = function() {
          // 当wait指定的时间间隔期间多次调用_.debounce返回的函数，则会不断更新timestamp的值，导致last < wait && last >= 0一直为true，从而不断启动新的计时器延时执行func
          var last = Date.now() - timestamp;
    
          if (last < wait && last >= 0) {
            timeout = setTimeout(later, wait - last);
          } else {
            timeout = null;
            if (!immediate) {
              result = func.apply(context, args);
              if (!timeout) context = args = null;
            }
          }
        };
        return function() {
          context = this;
          args = arguments;
          timestamp = Date.now();
          // 第一次调用该方法时，且immediate为true，则调用func函数
          var callNow = immediate && !timeout;
          // 在wait指定的时间间隔内首次调用该方法，则启动计时器定时调用func函数
          if (!timeout) timeout = setTimeout(later, wait);
          if (callNow) {
            result = func.apply(context, args);
            context = args = null;
          }
    
          return result;
        };
      };


})(this)

