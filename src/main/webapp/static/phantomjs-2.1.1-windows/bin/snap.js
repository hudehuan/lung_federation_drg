"use strict";
var page = require('webpage').create(),
    system = require('system');

function someCallback(pageNum, numPages) {
    return "<h5> someCallback: " + pageNum + " / " + numPages + "</h5>";
}

if (system.args.length < 3) {
    console.log('Usage: printheaderfooter.js URL filename');
    phantom.exit(1);
} else {
    var address = system.args[1];
    var output = system.args[2];
    page.viewportSize = { width: 800, height: 1150 };
    page.paperSize = {
        format: 'A4',
         margin : { left: '6px',  top : '14px',  right : '6px',  bottom : '14px' },//设置上下左右边距
        header: {
            height: "10px",
            contents: phantom.callback(function(pageNum, numPages) {
                if (pageNum != 1) {//页头条件  控制在哪个页面显示
                    return "";
                }
                return "<h5 style='margin-left:10px'></h5>";//页头内容
            })
        },
        footer: {
            height: "10px",
            contents: phantom.callback(function(pageNum, numPages) {
                if (pageNum > numPages) {//页尾条件  控制在哪个页面显示
                    return "";
                }
                //页尾内容
                return "<h5 style='font-weight:normal;'><span style='float:right'>" + pageNum + " / " + numPages + "</span></h5>";
               //return "<div style='width:750;margin:0 auto;border-top:1px solid #000;position:relative;top:-7px'><span style='float:right;line-height:18px;'>" + pageNum + " / " + numPages + "</span></div>"
            })
        }
    };
    page.open(address, function (status) {
        if (status !== 'success') {
            console.log('Unable to load the address!');
        } else {
            if (page.evaluate(function(){return typeof PhantomJSPrinting == "object";})) {
                paperSize = page.paperSize;
                 paperSize.header.height = page.evaluate(function() {
                     return PhantomJSPrinting.header.height;
                });
                 paperSize.header.contents = phantom.callback(function(pageNum, numPages) {
                     return page.evaluate(function(pageNum, numPages){return PhantomJSPrinting.header.contents(pageNum, numPages);}, pageNum, numPages);
                 });
                paperSize.footer.height = page.evaluate(function() {
                    return PhantomJSPrinting.footer.height;
                });
                paperSize.footer.contents = phantom.callback(function(pageNum, numPages) {
                    return page.evaluate(function(pageNum, numPages){return PhantomJSPrinting.footer.contents(pageNum, numPages);}, pageNum, numPages);
                });
                page.paperSize = paperSize;
                console.log(page.paperSize.header.height);
                console.log(page.paperSize.footer.height);
            }
            window.setTimeout(function () {
                page.render(output);
                phantom.exit();
            }, 200);
        }
    });
}