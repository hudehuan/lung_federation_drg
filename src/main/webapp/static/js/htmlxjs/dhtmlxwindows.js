//v.3.6 build 130417
/*
Copyright DHTMLX LTD. http://www.dhtmlx.com
You allowed to use this component or parts of it under GPL terms
To use it on other terms or get Professional edition of the component please contact us at sales@dhtmlx.com
*/
function dhtmlXWindowsSngl() { }
function dhtmlXWindowsBtn() { }
function dhtmlXWindows() {
    if (window.dhtmlXContainer) {
        this.engine = "dhx";
        var d = "_" + this.engine + "_Engine";
        if (this[d]) {
            this[d]();
            this._isIPad = navigator.userAgent.search(/iPad/gi) >= 0;
            var c = this;
            this.pathPrefix = "dhxwins_";
            this.imagePath = dhtmlx.image_path || "codebase/imgs/";
            this.setImagePath = function (a) {
                this.imagePath = a
            };
            this.skin = typeof dhtmlx != "undefined" && typeof dhtmlx.skin == "string" ? dhtmlx.skin : "dhx_skyblue";
            this.skinParams = {
                dhx_black: {
                    header_height: 21,
                    border_left_width: 2,
                    border_right_width: 2,
                    border_bottom_height: 2
                },
                dhx_blue: {
                    header_height: 21,
                    border_left_width: 2,
                    border_right_width: 2,
                    border_bottom_height: 2
                },
                dhx_skyblue: {
                    header_height: 21,
                    border_left_width: 2,
                    border_right_width: 2,
                    border_bottom_height: 2
                }
            };
            this.setSkin = function (a) {
                this.skin = a;
                this._engineRedrawSkin()
            };
            this.isWindow = function (a) {
                var b = this.wins[a] != null;
                return b
            };
            this.findByText = function (a) {
                var b = [],
                c;
                for (c in this.wins) this.wins[c].getText().search(a, "gi") >= 0 && (b[b.length] = this.wins[c]);
                return b
            };
            this.window = function (a) {
                var b = null;
                this.wins[a] != null && (b = this.wins[a]);
                return b
            };
            this.forEachWindow = function (a) {
                for (var b in this.wins) a(this.wins[b])
            };
            this.getBottommostWindow = function () {
                var a = this.getTopmostWindow(),
                b;
                for (b in this.wins) this.wins[b].zi < a.zi && (a = this.wins[b]);
                return a.zi != 0 ? a : null
            };
            this.getTopmostWindow = function (a) {
                var b = {
                    zi: 0
                },
                c;
                for (c in this.wins) this.wins[c].zi > b.zi && (a == !0 && !this._isWindowHidden(this.wins[c]) && (b = this.wins[c]), a != !0 && (b = this.wins[c]));
                return b.zi != 0 ? b : null
            };
            this.wins = {};
            for (var f in this.wins) delete this.wins[f];
            this.autoViewport = !0;
            this._createViewport = function () {
                this.vp = document.body;
                this._clearVPCss();
                this.vp._css = String(this.vp.className).length > 0 ? this.vp.className : "";
                this.vp.className += " dhtmlx_skin_" + this.skin + (this._r ? " dhx_wins_rtl" : "");
                this.modalCoverI = document.createElement("IFRAME");
                this.modalCoverI.frameBorder = "0";
                this.modalCoverI.className = "dhx_modal_cover_ifr";
                this.modalCoverI.setAttribute("src", "javascript:false;");
                this.modalCoverI.style.display = "none";
                this.modalCoverI.style.zIndex = 0;
                this.vp.appendChild(this.modalCoverI);
                this.modalCoverD = document.createElement("DIV");
                this.modalCoverD.className = "dhx_modal_cover_dv";
                this.modalCoverD.style.display = "none";
                this.modalCoverD.style.zIndex = 0;
                this.vp.appendChild(this.modalCoverD);
                this._vpcover = document.createElement("DIV");
                this._vpcover.className = "dhx_content_vp_cover";
                this._vpcover.style.display = "none";
                this.vp.appendChild(this._vpcover);
                this._carcass = document.createElement("DIV");
                this._carcass.className = "dhx_carcass_resmove";
                this._carcass.style.display = "none";
                if (_isIE) this._carcass.innerHTML = "<iframe border=0 frameborder=0 style='filter: alpha(opacity=0); width: 100%; height:100%; position: absolute; top: 0px; left: 0px; width: 100%; height: 100%; z-index:1;'></iframe><div style='position: absolute; top: 0px; left: 0px; width: 100%; height: 100%;z-index:2;background:white;filter:alpha(opacity=0);opacity:0;'></div>",
                navigator.userAgent.indexOf("MSIE 10") >= 0 || this._carcass.childNodes[0].setAttribute("src", "javascript:false;");
                this._carcass.onselectstart = function (a) {
                    a = a || event;
                    a.returnValue = !1
                };
                this.vp.appendChild(this._carcass)
            };
            this._clearVPCss = function () {
                this.vp.className = String(this.vp.className).replace(/[a-z_]{1,}/gi,
                function (a) {
                    return {
                        dhtmlx_skin_dhx_skyblue: 1,
                        dhtmlx_skin_dhx_blue: 1,
                        dhtmlx_skin_dhx_black: 1,
                        dhtmlx_skin_dhx_web: 1,
                        dhtmlx_skin_dhx_terrace: 1
                    }[a] == 1 ? "" : a
                })
            };
            this._autoResizeViewport = function () {
                for (var a in this.wins) this.wins[a]._isFullScreened && (this.wins[a].adjustContent(document.body, 0, 0, !1, 0), this.wins[a].updateNestedObjects()),
                this.wins[a]._isMaximized && this.wins[a].style.display != "none" && (this._restoreWindow(a), this._maximizeWindow(a));
                if (this.vp != document.body && this.autoViewport != !1) for (a in this.vp.style.width = (_isIE ? document.body.offsetWidth - 4 : window.innerWidth) + "px", this.vp.style.height = (_isIE ? document.body.offsetHeight - 4 : window.innerHeight) + "px", this.wins) {
                    var b = this.wins[a],
                    c = !1,
                    d = !1;
                    if (b.x > this.vp.offsetWidth - 10) b.x = this.vp.offsetWidth - 10,
                    c = !0;
                    var f = b._skinParams != null ? b._skinParams : this.skinParams[this.skin];
                    if (b.y + f.header_height > this.vp.offsetHeight) b.y = this.vp.offsetHeight - f.header_height,
                    d = !0; (c || d) && this._engineRedrawWindowPos(b)
                }
            };
            this.enableAutoViewport = function (a) {
                if (this.vp == document.body && (this.autoViewport = a, a == !1)) {
                    if (this.vp == document.body) document.body.className = this.vp._css;
                    this.vp.removeChild(this.modalCoverI);
                    this.vp.removeChild(this.modalCoverD);
                    this.vp.removeChild(this._vpcover);
                    this.vp.removeChild(this._carcass);
                    this.vp = null;
                    this.vp = document.createElement("DIV");
                    this.vp.autocreated = !0;
                    this.vp.className = "dhtmlx_winviewport dhtmlx_skin_" + this.skin + (this._r ? " dhx_wins_rtl" : "");
                    this.vp.style.left = "0px";
                    this.vp.style.top = "0px";
                    document.body.appendChild(this.vp);
                    this.vp.ax = 0;
                    this.vp.ay = 0;
                    this._autoResizeViewport();
                    this.vp.appendChild(this.modalCoverI);
                    this.vp.appendChild(this.modalCoverD);
                    this.vp.appendChild(this._vpcover);
                    this.vp.appendChild(this._carcass)
                }
            };
            this.attachViewportTo = function (a) {
                if (this.autoViewport == !1) this.vp.removeChild(this.modalCoverI),
                this.vp.removeChild(this.modalCoverD),
                this.vp.removeChild(this._vpcover),
                this.vp.removeChild(this._carcass),
                this.vp != document.body && this.vp.parentNode.removeChild(this.vp),
                this.vp = null,
                this.vp = typeof a == "string" ? document.getElementById(a) : a,
                this.vp.autocreated = !1,
                this._clearVPCss(),
                this.vp.className += " dhtmlx_skin_" + this.skin + (this._r ? " dhx_wins_rtl" : ""),
                this.vp.style.position = "relative",
                this.vp.style.overflow = "hidden",
                this.vp.ax = 0,
                this.vp.ay = 0,
                this.vp.appendChild(this.modalCoverI),
                this.vp.appendChild(this.modalCoverD),
                this.vp.appendChild(this._vpcover),
                this.vp.appendChild(this._carcass)
            };
            this.setViewport = function (a, b, c, d, f) {
                if (this.autoViewport == !1) this.vp.style.left = a + "px",
                this.vp.style.top = b + "px",
                this.vp.style.width = c + "px",
                this.vp.style.height = d + "px",
                f != null && f.appendChild(this.vp),
                this.vp.ax = getAbsoluteLeft(this.vp),
                this.vp.ay = getAbsoluteTop(this.vp)
            };
            this._effects = {
                move: !1,
                resize: !1
            };
            this.setEffect = function (a, b) {
                this._effects[a] != null && typeof b == "boolean" && (this._effects[a] = b)
            };
            this.getEffect = function (a) {
                return this._effects[a]
            };
            this.createWindow = function (a, b, g, d, f) {
                var e = document.createElement("DIV");
                e.className = "dhtmlx_window_inactive";
                e.dir = "ltr";
                for (var h in this.wins) if (this.wins[h].zi += this.zIndexStep, this.wins[h].style.zIndex = this.wins[h].zi, this.iframeMode && this.wins[h].ifr) this.wins[h].ifr.style.zIndex = this.wins[h].style.zIndex - 1;
                e.zi = this.zIndexStep;
                e.style.zIndex = e.zi;
                e.active = !1;
                e._isWindow = !0;
                e.isWindow = !0;
                e.w = Number(d);
                e.h = Number(f);
                e.x = b;
                e.y = g;
                this._engineFixWindowPosInViewport(e);
                e._isModal = !1;
                e._allowResize = !0;
                e.maxW = "auto";
                e.maxH = "auto";
                e.minW = 200;
                e.minH = 140;
                e.iconsPresent = !0;
                e.icons = [this.imagePath + this.pathPrefix + this.skin + "/active/icon_normal.gif", this.imagePath + this.pathPrefix + this.skin + "/inactive/icon_normal.gif"];
                e._allowMove = !0;
                e._allowMoveGlobal = !0;
                e._allowResizeGlobal = !0;
                e._keepInViewport = !1;
                var i = this.skinParams[this.skin];
                e.idd = a;
                this.vp.appendChild(e);
                this._engineSetWindowBody(e);
                this._engineRedrawWindowPos(e);
                this._engineRedrawWindowSize(e);
                this._engineUpdateWindowIcon(e, e.icons[0]);
                this._engineDiableOnSelectInWindow(e, !0);
                this.wins[a] = e;
                dhtmlxEventable(e);
                this._engineGetWindowHeader(e)[this._isIPad ? "ontouchstart" : "onmousedown"] = function (a) {
                    var a = a || event,
                    b = c.wins[this.idd];
                    b.isOnTop() || b.bringToTop();
                    if (!c._engineGetWindowHeaderState(b) && c._engineCheckHeaderMouseDown(b, a) && b._allowMove && b._allowMoveGlobal) {
                        c._wasMoved = !1;
                        b.moveOffsetX = b.x - (c._isIPad ? a.touches[0].clientX : a.clientX);
                        b.moveOffsetY = b.y - (c._isIPad ? a.touches[0].clientY : a.clientY);
                        c.movingWin = b;
                        if (c._effects.move == !1) c._carcass.x = c.movingWin.x,
                        c._carcass.y = c.movingWin.y,
                        c._carcass.w = parseInt(c.movingWin.style.width) + (_isIE ? 0 : -2),
                        c._carcass.h = parseInt(c.movingWin.style.height) + (_isIE ? 0 : -2),
                        c._carcass.style.left = c._carcass.x + "px",
                        c._carcass.style.top = c._carcass.y + "px",
                        c._carcass.style.width = c._carcass.w + "px",
                        c._carcass.style.height = c._carcass.h + "px",
                        c._carcass.style.zIndex = c._getTopZIndex(!0) + 1,
                        c._carcass._keepInViewport = e._keepInViewport;
                        c._blockSwitcher(!0);
                        c._vpcover.style.zIndex = c.movingWin.style.zIndex - 1;
                        c._vpcover.style.display = "";
                        a.returnValue = !1;
                        a.cancelBubble = !0;
                        return !1
                    }
                };
                this._engineGetWindowHeader(e).ondblclick = function (a) {
                    var b = c.wins[this.idd];
                    if (c._engineCheckHeaderMouseDown(b, a || event)) b._allowResizeGlobal && !b._isParked && (b._isMaximized == !0 ? c._restoreWindow(b.idd) : c._maximizeWindow(b.idd)),
                    b = null
                };
                e.setText = function (a) {
                    c._engineGetWindowLabel(this).innerHTML = a
                };
                e.getText = function () {
                    return c._engineGetWindowLabel(this).innerHTML
                };
                e.getId = function () {
                    return this.idd
                };
                e.show = function () {
                    c._showWindow(this)
                };
                e.hide = function () {
                    c._hideWindow(this)
                };
                e.minimize = function () {
                    c._restoreWindow(this.idd)
                };
                e.maximize = function () {
                    c._maximizeWindow(this.idd)
                };
                e.close = function () {
                    c._closeWindow(this.idd)
                };
                e.park = function () {
                    this._isParkedAllowed && c._parkWindow(this.idd)
                };
                e.stick = function () {
                    c._stickWindow(this.idd)
                };
                e.unstick = function () {
                    c._unstickWindow(this.idd)
                };
                e.isSticked = function () {
                    return this._isSticked
                };
                e.setIcon = function (a, b) {
                    c._setWindowIcon(e, a, b)
                };
                e.getIcon = function () {
                    return c._getWindowIcon(this)
                };
                e.clearIcon = function () {
                    c._clearWindowIcons(this)
                };
                e.restoreIcon = function () {
                    c._restoreWindowIcons(this)
                };
                e.keepInViewport = function (a) {
                    this._keepInViewport = a
                };
                e.setModal = function (a) {
                    a == !0 ? c.modalWin != null || c.modalWin == this || c._setWindowModal(this, !0) : c.modalWin == this && c._setWindowModal(this, !1)
                };
                e.isModal = function () {
                    return this._isModal
                };
                e.isHidden = function () {
                    return c._isWindowHidden(this)
                };
                e.isMaximized = function () {
                    return this._isMaximized
                };
                e.isParked = function () {
                    return this._isParked
                };
                e.allowPark = function () {
                    c._allowParking(this)
                };
                e.denyPark = function () {
                    c._denyParking(this)
                };
                e.isParkable = function () {
                    return this._isParkedAllowed
                };
                e.allowResize = function () {
                    c._allowReszieGlob(this)
                };
                e.denyResize = function () {
                    c._denyResize(this)
                };
                e.isResizable = function () {
                    return this._allowResizeGlobal
                };
                e.allowMove = function () {
                    if (!this._isMaximized) this._allowMove = !0;
                    this._allowMoveGlobal = !0
                };
                e.denyMove = function () {
                    this._allowMoveGlobal = !1
                };
                e.isMovable = function () {
                    return this._allowMoveGlobal
                };
                e.bringToTop = function () {
                    c._bringOnTop(this);
                    c._makeActive(this)
                };
                e.bringToBottom = function () {
                    c._bringOnBottom(this)
                };
                e.isOnTop = function () {
                    return c._isWindowOnTop(this)
                };
                e.isOnBottom = function () {
                    return c._isWindowOnBottom(this)
                };
                e.setPosition = function (a, b) {
                    this.x = a;
                    this.y = b;
                    c._engineFixWindowPosInViewport(this);
                    c._engineRedrawWindowPos(this)
                };
                e.getPosition = function () {
                    return [this.x, this.y]
                };
                e.setDimension = function (a, b) {
                    if (a != null) {
                        if (this.maxW != "auto" && a > this.maxW) a = this.maxW;
                        if (a < this.minW) a = this.minW;
                        this.w = a
                    }
                    if (b != null) {
                        if (this.maxH != "auto" && b > this.maxH) b = this.maxH;
                        if (b < this.minH) b = this.minH;
                        this.h = b
                    }
                    c._fixWindowDimensionInViewport(this);
                    c._engineFixWindowPosInViewport(this);
                    c._engineRedrawWindowSize(this);
                    this.updateNestedObjects()
                };
                e.getDimension = function () {
                    return [this.w, this.h]
                };
                e.setMaxDimension = function (a, b) {
                    this.maxW = isNaN(a) ? "auto" : a;
                    this.maxH = isNaN(b) ? "auto" : b;
                    c._engineRedrawWindowSize(this)
                };
                e.getMaxDimension = function () {
                    return [this.maxW, this.maxH]
                };
                e.setMinDimension = function (a, b) {
                    if (a != null) this.minW = a;
                    if (b != null) this.minH = b;
                    c._fixWindowDimensionInViewport(this);
                    c._engineRedrawWindowPos(this)
                };
                e.getMinDimension = function () {
                    return [this.minW, this.minH]
                };
                e._adjustToContent = function (a, b) {
                    c._engineAdjustWindowToContent(this, a, b)
                };
                e._doOnAttachMenu = function () {
                    c._engineRedrawWindowSize(this);
                    this.updateNestedObjects()
                };
                e._doOnAttachToolbar = function () {
                    c._engineRedrawWindowSize(this);
                    this.updateNestedObjects()
                };
                e._doOnAttachStatusBar = function () {
                    c._engineRedrawWindowSize(this);
                    this.updateNestedObjects()
                };
                e._doOnFrameMouseDown = function () {
                    this.bringToTop()
                };
                e._doOnFrameContentLoaded = function () {
                    c.callEvent("onContentLoaded", [this])
                };
                e.addUserButton = function (a, b, g, d) {
                    var e = c._addUserButton(this, a, b, g, d);
                    return e
                };
                e.removeUserButton = function (a) {
                    a = String(a).toLowerCase();
                    a == "minmax1" || a == "minmax2" || a == "park" || a == "close" || a == "stick" || a == "unstick" || a == "help" || btn != null && c._removeUserButton(this, a)
                };
                e.progressOn = function () {
                    c._engineSwitchWindowProgress(this, !0)
                };
                e.progressOff = function () {
                    c._engineSwitchWindowProgress(this, !1)
                };
                e.setToFullScreen = function (a) {
                    c._setWindowToFullScreen(this, a)
                };
                e.showHeader = function () {
                    c._engineSwitchWindowHeader(this, !0)
                };
                e.hideHeader = function () {
                    c._engineSwitchWindowHeader(this, !1)
                };
                e.progressOff();
                e.canStartResize = !1;
                e.onmousemove = function (a) {
                    if (_isIE && this._isMaximized) return !0;
                    var a = a || event,
                    b = a.target || a.srcElement;
                    String(b.className).search("dhtmlx_wins_resizer") < 0 && (b = null);
                    if (!this._allowResize || this._allowResizeGlobal == !1 || !b) {
                        if (b && b.style.cursor != "default") b.style.cursor = "default";
                        if (this.style.cursor != "default") this.style.cursor = "default";
                        this.canStartResize = !1;
                        return !0
                    }
                    if (c.resizingWin == null && c.movingWin == null && !this._isParked) {
                        if (c._isIPad) var g = a.touches[0].clientX,
                        d = a.touches[0].clientY;
                        else g = _isIE || _isOpera ? a.offsetX : a.layerX,
                        d = _isIE || _isOpera ? a.offsetY : a.layerY;
                        var m = c._engineAllowWindowResize(e, b, g, d);
                        if (m == null) {
                            this.canStartResize = !1;
                            if (b.style.cursor != "default") b.style.cursor = "default";
                            if (this.style.cursor != "default") this.style.cursor = "default"
                        } else {
                            c.resizingDirs = m;
                            var f = {
                                x: a.clientX,
                                y: a.clientY
                            };
                            switch (c.resizingDirs) {
                                case "border_left":
                                    b.style.cursor = "w-resize";
                                    this.resizeOffsetX = this.x - f.x;
                                    break;
                                case "border_right":
                                    b.style.cursor = "e-resize";
                                    this.resizeOffsetXW = this.x + this.w - f.x;
                                    break;
                                case "border_top":
                                    b.style.cursor = "n-resize";
                                    this.resizeOffsetY = this.y - f.y;
                                    break;
                                case "border_bottom":
                                    b.style.cursor = "n-resize";
                                    this.resizeOffsetYH = this.y + this.h - f.y;
                                    break;
                                case "corner_left":
                                    b.style.cursor = "sw-resize";
                                    this.resizeOffsetX = this.x - a.clientX;
                                    this.resizeOffsetYH = this.y + this.h - f.y;
                                    break;
                                case "corner_up_left":
                                    b.style.cursor = "nw-resize";
                                    this.resizeOffsetY = this.y - f.y;
                                    this.resizeOffsetX = this.x - f.x;
                                    break;
                                case "corner_right":
                                    b.style.cursor = "nw-resize";
                                    this.resizeOffsetXW = this.x + this.w - f.x;
                                    this.resizeOffsetYH = this.y + this.h - f.y;
                                    break;
                                case "corner_up_right":
                                    b.style.cursor = "sw-resize",
                                    this.resizeOffsetY = this.y - f.y,
                                    this.resizeOffsetXW = this.x + this.w - f.x
                            }
                            this.canStartResize = !0;
                            this.style.cursor = b.style.cursor;
                            a.cancelBubble = !0;
                            return a.returnValue = !1
                        }
                    }
                };
                e.onmousedown = function (a) {
                    c._getActive() != this && c._makeActive(this);
                    c._bringOnTop(this);
                    if (this.canStartResize) {
                        c._blockSwitcher(!0);
                        c.resizingWin = this;
                        if (!c._effects.resize) c._carcass.x = c.resizingWin.x,
                        c._carcass.y = c.resizingWin.y,
                        c._carcass.w = Number(c.resizingWin.w) + (_isIE ? 0 : -2),
                        c._carcass.h = Number(c.resizingWin.h) + (_isIE ? 0 : -2),
                        c._carcass.style.left = c._carcass.x + "px",
                        c._carcass.style.top = c._carcass.y + "px",
                        c._carcass.style.width = c._carcass.w + "px",
                        c._carcass.style.height = c._carcass.h + "px",
                        c._carcass.style.zIndex = c._getTopZIndex(!0) + 1,
                        c._carcass.style.cursor = this.style.cursor,
                        c._carcass._keepInViewport = this._keepInViewport,
                        c._carcass.style.display = "";
                        c._vpcover.style.zIndex = c.resizingWin.style.zIndex - 1;
                        c._vpcover.style.display = "";
                        this.vs[this.av].layout && this.callEvent("_onBeforeTryResize", [this]);
                        a = a || event
                    }
                };
                this._addDefaultButtons(e.idd);
                e.button = function (a) {
                    var a = String(a).toLowerCase(),
                    b = null;
                    this.btns[a] != null && (b = this.btns[a]);
                    return b
                };
                e.center = function () {
                    c._centerWindow(this, !1)
                };
                e.centerOnScreen = function () {
                    c._centerWindow(this, !0)
                };
                e._attachContent("empty", null);
                e._redraw = function () {
                    c._engineRedrawWindowSize(this)
                };
                e.bringToTop();
                this._engineRedrawWindowSize(e);
                return this.wins[a]
            };
            this.zIndexStep = 50;
            this._getTopZIndex = function (a) {
                var b = 0,
                c;
                for (c in this.wins) if (a == !0) {
                    if (this.wins[c].zi > b) b = this.wins[c].zi
                } else if (this.wins[c].zi > b && !this.wins[c]._isSticked) b = this.wins[c].zi;
                return b
            };
            this.movingWin = null;
            this._moveWindow = function (a) {
                if (this.movingWin != null) {
                    if (!this.movingWin._allowMove || !this.movingWin._allowMoveGlobal) return;
                    if (this._effects.move == !0) {
                        if (this._engineGetWindowHeader(this.movingWin).style.cursor != "move") this._engineGetWindowHeader(this.movingWin).style.cursor = "move";
                        this._wasMoved = !0;
                        this.movingWin.x = (this._isIPad ? a.touches[0].clientX : a.clientX) + this.movingWin.moveOffsetX;
                        this.movingWin.y = (this._isIPad ? a.touches[0].clientY : a.clientY) + this.movingWin.moveOffsetY;
                        this._engineFixWindowPosInViewport(this.movingWin);
                        this._engineRedrawWindowPos(this.movingWin)
                    } else {
                        if (this._carcass.style.display != "") this._carcass.style.display = "";
                        if (this._carcass.style.cursor != "move") this._carcass.style.cursor = "move";
                        if (this._engineGetWindowHeader(this.movingWin).style.cursor != "move") this._engineGetWindowHeader(this.movingWin).style.cursor = "move";
                        this._carcass.x = (this._isIPad ? a.touches[0].clientX : a.clientX) + this.movingWin.moveOffsetX;
                        this._carcass.y = (this._isIPad ? a.touches[0].clientY : a.clientY) + this.movingWin.moveOffsetY;
                        this._wasMoved = !0;
                        this._engineFixWindowPosInViewport(this._carcass);
                        this._carcass.style.left = this._carcass.x + "px";
                        this._carcass.style.top = this._carcass.y + "px"
                    }
                }
                if (this.resizingWin != null && this.resizingWin._allowResize) {
                    var b = {
                        x: a.clientX,
                        y: a.clientY
                    };
                    if (this.resizingDirs == "border_left" || this.resizingDirs == "corner_left" || this.resizingDirs == "corner_up_left") if (this._effects.resize) {
                        var c = b.x + this.resizingWin.resizeOffsetX,
                        d = c > this.resizingWin.x ? -1 : 1;
                        newW = this.resizingWin.w + Math.abs(c - this.resizingWin.x) * d;
                        newW < this.resizingWin.minW && d < 0 ? (this.resizingWin.x = this.resizingWin.x + this.resizingWin.w - this.resizingWin.minW, this.resizingWin.w = this.resizingWin.minW) : (this.resizingWin.w = newW, this.resizingWin.x = c);
                        this._engineRedrawWindowPos(this.resizingWin);
                        this._engineRedrawWindowSize(this.resizingWin)
                    } else {
                        c = b.x + this.resizingWin.resizeOffsetX;
                        d = c > this._carcass.x ? -1 : 1;
                        newW = this._carcass.w + Math.abs(c - this._carcass.x) * d;
                        if (newW > this.resizingWin.maxW) newW = this.resizingWin.maxW,
                        c = this._carcass.x + this._carcass.w - this.resizingWin.maxW;
                        newW < this.resizingWin.minW && d < 0 ? (this._carcass.x = this._carcass.x + this._carcass.w - this.resizingWin.minW, this._carcass.w = this.resizingWin.minW) : (this._carcass.w = newW, this._carcass.x = c);
                        this._carcass.style.left = this._carcass.x + "px";
                        this._carcass.style.width = this._carcass.w + "px"
                    }
                    if (this.resizingDirs == "border_right" || this.resizingDirs == "corner_right" || this.resizingDirs == "corner_up_right") if (this._effects.resize) {
                        c = b.x - (this.resizingWin.x + this.resizingWin.w) + this.resizingWin.resizeOffsetXW;
                        newW = this.resizingWin.w + c;
                        if (newW < this.resizingWin.minW) newW = this.resizingWin.minW;
                        this.resizingWin.w = newW;
                        this._engineRedrawWindowPos(this.resizingWin);
                        this._engineRedrawWindowSize(this.resizingWin)
                    } else {
                        c = b.x - (this._carcass.x + this._carcass.w) + this.resizingWin.resizeOffsetXW;
                        newW = this._carcass.w + c;
                        if (newW < this.resizingWin.minW) newW = this.resizingWin.minW;
                        if (this.resizingWin.maxW != "auto" && newW > this.resizingWin.maxW) newW = this.resizingWin.maxW;
                        this._carcass.w = newW;
                        this._carcass.style.width = this._carcass.w + "px"
                    }
                    if (this.resizingDirs == "border_bottom" || this.resizingDirs == "corner_left" || this.resizingDirs == "corner_right") if (this._effects.resize) {
                        c = b.y - (this.resizingWin.y + this.resizingWin.h) + this.resizingWin.resizeOffsetYH;
                        newH = this.resizingWin.h + c;
                        if (newH < this.resizingWin.minH) newH = this.resizingWin.minH;
                        this.resizingWin.h = newH;
                        this._engineRedrawWindowPos(this.resizingWin);
                        this._engineRedrawWindowSize(this.resizingWin)
                    } else {
                        c = b.y - (this._carcass.y + this._carcass.h) + this.resizingWin.resizeOffsetYH;
                        newH = this._carcass.h + c;
                        if (newH < this.resizingWin.minH) newH = this.resizingWin.minH;
                        if (newH > this.resizingWin.maxH) newH = this.resizingWin.maxH;
                        this._carcass.h = newH;
                        this._carcass.style.height = this._carcass.h + "px"
                    }
                    if ((this.resizingDirs == "border_top" || this.resizingDirs == "corner_up_right" || this.resizingDirs == "corner_up_left") && !this._effects.resize) {
                        c = b.y + this.resizingWin.resizeOffsetY;
                        d = c > this.resizingWin.y ? -1 : 1;
                        newH = this.resizingWin.h + Math.abs(c - this.resizingWin.y) * d;
                        if (newH > this.resizingWin.maxH) newH = this.resizingWin.maxH,
                        c = this.resizingWin.y + this.resizingWin.h - this.resizingWin.maxH;
                        newH < this.resizingWin.minH && d < 0 ? (this._carcass.y = this._carcass.y + this._carcass.h - this.resizingWin.minH, this._carcass.h = this.resizingWin.minH) : (this._carcass.h = newH + (_isIE ? 0 : -2), this._carcass.y = c);
                        this._carcass.style.top = this._carcass.y + "px";
                        this._carcass.style.height = this._carcass.h + "px"
                    }
                }
            };
            this._stopMove = function () {
                if (this.movingWin != null) {
                    if (this._effects.move) {
                        var a = this.movingWin;
                        this.movingWin = null;
                        this._blockSwitcher(!1);
                        this._engineGetWindowHeader(a).style.cursor = "";
                        _isFF && (a.h++, c._engineRedrawWindowPos(a), a.h--, c._engineRedrawWindowPos(a))
                    } else this._carcass.style.cursor = "",
                    this._carcass.style.display = "none",
                    a = this.movingWin,
                    this._engineGetWindowHeader(a).style.cursor = "",
                    this.movingWin = null,
                    this._blockSwitcher(!1),
                    a.setPosition(parseInt(this._carcass.style.left), parseInt(this._carcass.style.top));
                    this._vpcover.style.display = "none";
                    this._wasMoved && (a.checkEvent("onMoveFinish") ? a.callEvent("onMoveFinish", [a]) : this.callEvent("onMoveFinish", [a]));
                    this._wasMoved = !1
                }
                if (this.resizingWin != null) a = this.resizingWin,
                this.resizingWin = null,
                this._blockSwitcher(!1),
                this._effects.resize ? a.updateNestedObjects() : (this._carcass.style.display = "none", a.setDimension(this._carcass.w + (_isIE ? 0 : 2), this._carcass.h + (_isIE ? 0 : 2)), a.setPosition(this._carcass.x, this._carcass.y)),
                a.vs[a.av].layout && a.vs[a.av].layout.callEvent("onResize", []),
                this._vpcover.style.display = "none",
                a.checkEvent("onResizeFinish") ? a.callEvent("onResizeFinish", [a]) : this.callEvent("onResizeFinish", [a])
            };
            this._fixWindowDimensionInViewport = function (a) {
                if (a.w < a.minW) a.w = a.minW;
                if (!a._isParked && a.h < a.minH) a.h = a.minH
            };
            this._bringOnTop = function (a) {
                var b = a.zi,
                c = this._getTopZIndex(a._isSticked),
                d;
                for (d in this.wins) if (this.wins[d] != a && (a._isSticked || !a._isSticked && !this.wins[d]._isSticked) && this.wins[d].zi > b) if (this.wins[d].zi -= this.zIndexStep, this.wins[d].style.zIndex = this.wins[d].zi, this.iframeMode && this.wins[d].ifr) this.wins[d].ifr.style.zIndex = this.wins[d].style.zIndex - 1;
                a.zi = c;
                a.style.zIndex = a.zi;
                if (this.iframeMode && a.ifr) a.ifr.style.zIndex = c - 1
            };
            this._makeActive = function (a, b) {
                for (var c in this.wins) if (this.wins[c] == a) {
                    var d = !1;
                    this.wins[c].className != "dhtmlx_window_active" && !b && (d = !0);
                    this.wins[c].className = "dhtmlx_window_active";
                    this._engineUpdateWindowIcon(this.wins[c], this.wins[c].icons[0]);
                    d == !0 && (a.checkEvent("onFocus") ? a.callEvent("onFocus", [a]) : this.callEvent("onFocus", [a]))
                } else this.wins[c].className = "dhtmlx_window_inactive",
                this._engineUpdateWindowIcon(this.wins[c], this.wins[c].icons[1])
            };
            this._getActive = function () {
                var a = null,
                b;
                for (b in this.wins) this.wins[b].className == "dhtmlx_window_active" && (a = this.wins[b]);
                return a
            };
            this._centerWindow = function (a, b) {
                if (a._isMaximized != !0) {
                    if (b == !0) var c = _isIE ? document.body.offsetWidth : window.innerWidth,
                    d = _isIE ? document.body.offsetHeight : window.innerHeight;
                    else c = this.vp == document.body ? document.body.offsetWidth : Number(parseInt(this.vp.style.width)) && String(this.vp.style.width).search("%") == -1 ? parseInt(this.vp.style.width) : this.vp.offsetWidth,
                    d = this.vp == document.body ? document.body.offsetHeight : Number(parseInt(this.vp.style.height)) && String(this.vp.style.height).search("%") == -1 ? parseInt(this.vp.style.height) : this.vp.offsetHeight;
                    var f = Math.round(c / 2 - a.w / 2),
                    e = Math.round(d / 2 - a.h / 2);
                    a.x = f;
                    a.y = e;
                    this._engineFixWindowPosInViewport(a);
                    this._engineRedrawWindowPos(a)
                }
            };
            this._addDefaultButtons = function (a) {
                var b = this.wins[a],
                d = this._engineGetWindowButton(b, "stick");
                d.title = this.i18n.stick;
                d.isVisible = !1;
                d.style.display = "none";
                d._isEnabled = !0;
                d.isPressed = !1;
                d.label = "stick";
                d._doOnClick = function () {
                    this.isPressed = !0;
                    c._stickWindow(this.winId)
                };
                var f = this._engineGetWindowButton(b, "sticked");
                f.title = this.i18n.unstick;
                f.isVisible = !1;
                f.style.display = "none";
                f._isEnabled = !0;
                f.isPressed = !1;
                f.label = "sticked";
                f._doOnClick = function () {
                    this.isPressed = !1;
                    c._unstickWindow(this.winId)
                };
                var j = this._engineGetWindowButton(b, "help");
                j.title = this.i18n.help;
                j.isVisible = !1;
                j.style.display = "none";
                j._isEnabled = !0;
                j.isPressed = !1;
                j.label = "help";
                j._doOnClick = function () {
                    c._needHelp(this.winId)
                };
                var e = this._engineGetWindowButton(b, "park");
                e.titleIfParked = this.i18n.parkdown;
                e.titleIfNotParked = this.i18n.parkup;
                e.title = e.titleIfNotParked;
                e.isVisible = !0;
                e._isEnabled = !0;
                e.isPressed = !1;
                e.label = "park";
                e._doOnClick = function () {
                    c._parkWindow(this.winId)
                };
                var h = this._engineGetWindowButton(b, "minmax1");
                h.title = this.i18n.maximize;
                h.isVisible = !0;
                h._isEnabled = !0;
                h.isPressed = !1;
                h.label = "minmax1";
                h._doOnClick = function () {
                    c._maximizeWindow(this.winId)
                };
                var i = this._engineGetWindowButton(b, "minmax2");
                i.title = this.i18n.restore;
                i.isVisible = !1;
                i.style.display = "none";
                i._isEnabled = !0;
                i.isPressed = !1;
                i.label = "minmax2";
                i._doOnClick = function () {
                    c._restoreWindow(this.winId)
                };
                var l = this._engineGetWindowButton(b, "close");
                l.title = this.i18n.close;
                l.isVisible = !0;
                l._isEnabled = !0;
                l.isPressed = !1;
                l.label = "close";
                l._doOnClick = function () {
                    c._closeWindow(this.winId)
                };
                var k = this._engineGetWindowButton(b, "dock");
                k.title = this.i18n.dock;
                k.style.display = "none";
                k.isVisible = !1;
                k._isEnabled = !0;
                k.isPressed = !1;
                k.label = "dock";
                k._doOnClick = function () { };
                b._isSticked = !1;
                b._isParked = !1;
                b._isParkedAllowed = !0;
                b._isMaximized = !1;
                b._isDocked = !1;
                b.btns = {};
                b.btns.stick = d;
                b.btns.sticked = f;
                b.btns.help = j;
                b.btns.park = e;
                b.btns.minmax1 = h;
                b.btns.minmax2 = i;
                b.btns.close = l;
                b.btns.dock = k;
                for (var n in b.btns) b.btns[n].winId = b.idd,
                this._attachEventsOnButton(b.idd, n);
                b = d = f = j = e = h = i = l = k = null
            };
            this._attachEventsOnButton = function (a, b) {
                var d = this.wins[a].btns[b];
                this._isIPad ? (d.ontouchstart = function (a) {
                    a.cancelBubble = !0;
                    return a.returnValue = !1
                },
                d.ontouchend = function (a) {
                    a.cancelBubble = !0;
                    a.returnValue = !1;
                    if (!this._isEnabled) return !1;
                    this.checkEvent("onClick") ? this.callEvent("onClick", [c.wins[this.winId], this]) : this._doOnClick();
                    return !1
                }) : (d.onmouseover = function () {
                    this.className = this._isEnabled ? "dhtmlx_wins_btns_button dhtmlx_button_" + this.label + "_over_" + (this.isPressed ? "pressed" : "default") : "dhtmlx_wins_btns_button dhtmlx_button_" + this.label + "_disabled"
                },
                d.onmouseout = function () {
                    this._isEnabled ? (this.isPressed = !1, this.className = "dhtmlx_wins_btns_button dhtmlx_button_" + this.label + "_default") : this.className = "dhtmlx_wins_btns_button dhtmlx_button_" + this.label + "_disabled"
                },
                d.onmousedown = function () {
                    this._isEnabled ? (this.isPressed = !0, this.className = "dhtmlx_wins_btns_button dhtmlx_button_" + this.label + "_over_pressed") : this.className = "dhtmlx_wins_btns_button dhtmlx_button_" + this.label + "_disabled"
                },
                d.onmouseup = function () {
                    if (this._isEnabled) {
                        var a = this.isPressed;
                        this.isPressed = !1;
                        this.className = "dhtmlx_wins_btns_button dhtmlx_button_" + this.label + "_over_default";
                        a && (this.checkEvent("onClick") ? this.callEvent("onClick", [c.wins[this.winId], this]) : this._doOnClick())
                    } else this.className = "dhtmlx_wins_btns_button dhtmlx_button_" + this.label + "_disabled"
                });
                d.show = function () {
                    c._showButton(c.wins[this.winId], this.label, !0)
                };
                d.hide = function () {
                    c._hideButton(c.wins[this.winId], this.label, !0)
                };
                d.enable = function () {
                    c._enableButton(c.wins[this.winId], this.label)
                };
                d.disable = function () {
                    c._disableButton(c.wins[this.winId], this.label)
                };
                d.isEnabled = function () {
                    return this._isEnabled
                };
                d.isHidden = function () {
                    return !this.isVisible
                };
                dhtmlxEventable(d);
                d = null
            };
            this._parkWindow = function (a, b) {
                var c = this.wins[a];
                if (c._isParkedAllowed || b) if (!this.enableParkEffect || !c.parkBusy) {
                    if (c._isParked) this.enableParkEffect && !b ? (c.parkBusy = !0, this._doParkDown(c)) : (c.h = c.lastParkH, this._engineRedrawWindowSize(c), this._engineDoOnWindowParkDown(c), c.updateNestedObjects(), c.btns.park.title = c.btns.park.titleIfNotParked, c._allowResizeGlobal == !0 && (this._enableButton(c, "minmax1"), this._enableButton(c, "minmax2")), c._isParked = !1, b || (c.checkEvent("onParkDown") ? c.callEvent("onParkDown", [c]) : this.callEvent("onParkDown", [c])));
                    else if (this.enableParkEffect && !b) if (c.lastParkH = String(c.h).search(/\%$/) == -1 ? c.h : c.offsetHeight, c._allowResizeGlobal == !0 && (this._disableButton(c, "minmax1"), this._disableButton(c, "minmax2")), this.enableParkEffect) c.parkBusy = !0,
                    this._doParkUp(c);
                    else {
                        var d = c._skinParams != null ? c._skinParams : this.skinParams[this.skin];
                        c.h = d.header_height + d.border_bottom_height;
                        c.btns.park.title = c.btns.park.titleIfParked
                    } else c.lastParkH = String(c.h).search(/\%$/) == -1 ? c.h : c.offsetHeight,
                    c.h = this._engineGetWindowParkedHeight(c),
                    this._engineRedrawWindowSize(c),
                    this._engineDoOnWindowParkUp(c),
                    c.btns.park.title = c.btns.park.titleIfParked,
                    c._isParked = !0,
                    b || (c.checkEvent("onParkUp") ? c.callEvent("onParkUp", [c]) : this.callEvent("onParkUp", [c]));
                    c = null
                }
            };
            this._allowParking = function (a) {
                a._isParkedAllowed = !0;
                this._enableButton(a, "park")
            };
            this._denyParking = function (a) {
                a._isParkedAllowed = !1;
                this._disableButton(a, "park")
            };
            this.enableParkEffect = !1;
            this.parkSpeed = this.parkStartSpeed = 80;
            this.parkTM = null;
            this.parkTMTime = 5;
            this._doParkUp = function (a) {
                if (String(a.h).search(/\%$/) != -1) a.h = a.offsetHeight;
                a.h -= this.parkSpeed;
                var b = this._engineGetWindowParkedHeight(a);
                a.h <= b ? (a.h = b, this._engineGetWindowButton(a, "park").title = this._engineGetWindowButton(a, "park").titleIfParked, a._isParked = !0, a.parkBusy = !1, this._engineRedrawWindowSize(a), this._engineDoOnWindowParkUp(a), a.checkEvent("onParkUp") ? a.callEvent("onParkUp", [a]) : this.callEvent("onParkUp", [a])) : (this._engineRedrawWindowSize(a), this.parkTM = window.setTimeout(function () {
                    c._doParkUp(a)
                },
                this.parkTMTime))
            };
            this._doParkDown = function (a) {
                a.h += this.parkSpeed;
                a.h >= a.lastParkH ? (a.h = a.lastParkH, this._engineGetWindowButton(a, "park").title = this._engineGetWindowButton(a, "park").titleIfNotParked, a._allowResizeGlobal == !0 && (this._enableButton(a, "minmax1"), this._enableButton(a, "minmax2")), a._isParked = !1, a.parkBusy = !1, this._engineRedrawWindowSize(a), a.updateNestedObjects(), this._engineDoOnWindowParkDown(a), a.checkEvent("onParkDown") ? a.callEvent("onParkDown", [a]) : this.callEvent("onParkDown", [a])) : (this._engineRedrawWindowSize(a), this.parkTM = window.setTimeout(function () {
                    c._doParkDown(a)
                },
                this.parkTMTime))
            };
            this._enableButton = function (a, b) {
                var c = this._engineGetWindowButton(a, b);
                if (c) c._isEnabled = !0,
                c.className = "dhtmlx_wins_btns_button dhtmlx_button_" + c.label + "_default",
                c = null
            };
            this._disableButton = function (a, b) {
                var c = this._engineGetWindowButton(a, b);
                if (c) c._isEnabled = !1,
                c.className = "dhtmlx_wins_btns_button dhtmlx_button_" + a.btns[b].label + "_disabled",
                c = null
            };
            this._allowReszieGlob = function (a) {
                a._allowResizeGlobal = !0;
                this._enableButton(a, "minmax1");
                this._enableButton(a, "minmax2")
            };
            this._denyResize = function (a) {
                a._allowResizeGlobal = !1;
                this._disableButton(a, "minmax1");
                this._disableButton(a, "minmax2")
            };
            this._maximizeWindow = function (a) {
                var b = this.wins[a];
                if (b._allowResizeGlobal != !1) {
                    var c = b._isParked;
                    c && this._parkWindow(b.idd, !0);
                    b.lastMaximizeX = b.x;
                    b.lastMaximizeY = b.y;
                    b.lastMaximizeW = b.w;
                    b.lastMaximizeH = b.h;
                    b.maxW != "auto" && b.maxW != "auto" ? (b.x = Math.round(b.x + (b.w - b.maxW) / 2), b.y = Math.round(b.y + (b.h - b.maxH) / 2), b._allowMove = !0) : (b.x = 0, b.y = 0, b._allowMove = !1);
                    b._isMaximized = !0;
                    b._allowResize = !1;
                    b.w = b.maxW == "auto" ? this.vp == document.body ? "100%" : this.vp.style.width != "" && String(this.vp.style.width).search("%") == -1 ? parseInt(this.vp.style.width) : this.vp.offsetWidth : b.maxW;
                    b.h = b.maxH == "auto" ? this.vp == document.body ? "100%" : this.vp.style.height != "" && String(this.vp.style.width).search("%") == -1 ? parseInt(this.vp.style.height) : this.vp.offsetHeight : b.maxH;
                    this._hideButton(b, "minmax1");
                    this._showButton(b, "minmax2");
                    this._engineRedrawWindowPos(b);
                    c ? this._parkWindow(b.idd, !0) : (this._engineRedrawWindowSize(b), b.updateNestedObjects());
                    b.checkEvent("onMaximize") ? b.callEvent("onMaximize", [b]) : this.callEvent("onMaximize", [b]);
                    b = null
                }
            };
            this._restoreWindow = function (a) {
                var b = this.wins[a];
                if (b._allowResizeGlobal != !1) {
                    b.layout && b.layout._defineWindowMinDimension(b);
                    var c = b._isParked;
                    c && this._parkWindow(b.idd, !0);
                    b.maxW != "auto" && b.maxW != "auto" ? (b.x = Math.round(b.x + (b.w - b.lastMaximizeW) / 2), b.y = Math.round(b.y + (b.h - b.lastMaximizeH) / 2)) : (b.x = b.lastMaximizeX, b.y = b.lastMaximizeY);
                    b.w = b.lastMaximizeW;
                    b.h = b.lastMaximizeH;
                    b._isMaximized = !1;
                    b._allowMove = b._allowMoveGlobal;
                    b._allowResize = !0;
                    this._fixWindowDimensionInViewport(b);
                    this._hideButton(b, "minmax2");
                    this._showButton(b, "minmax1");
                    this._engineRedrawWindowPos(b);
                    c ? this._parkWindow(b.idd, !0) : (this._engineRedrawWindowSize(b), b.updateNestedObjects());
                    b.checkEvent("onMinimize") ? b.callEvent("onMinimize", [b]) : this.callEvent("onMinimize", [b]);
                    b = null
                }
            };
            this._showButton = function (a, b, c) {
                var d = this._engineGetWindowButton(a, b);
                if (d && !(!c && d._userHide || d.isVisible === !0)) d.isVisible = !0,
                d.style.display = "",
                d.style.visibility = "visible",
                d._userHide = c != !0,
                this._engineRedrawWindowTitle(a),
                d = null
            };
            this._hideButton = function (a, b, c) {
                var d = this._engineGetWindowButton(a, b);
                if (d && (c || d.isVisible !== !1)) d.isVisible = !1,
                d.style.display = "none",
                d.style.visibility = "hidden",
                d._userHide = c == !0,
                this._engineRedrawWindowTitle(a),
                d = null
            };
            this._showWindow = function (a) {
                a.style.display = "";
                a.checkEvent("onShow") ? a.callEvent("onShow", [a]) : this.callEvent("onShow", [a]);
                var b = this._getActive();
                b == null ? (this._bringOnTop(a), this._makeActive(a)) : this._isWindowHidden(b) && (this._bringOnTop(a), this._makeActive(a));
                if (this.iframeMode && a.ifr) a.ifr.style.display = ""
            };
            this._hideWindow = function (a) {
                a.style.display = "none";
                a.checkEvent("onHide") ? a.callEvent("onHide", [a]) : this.callEvent("onHide", [a]);
                var b = this.getTopmostWindow(!0);
                b != null && (this._bringOnTop(b), this._makeActive(b));
                if (this.iframeMode && a.ifr) a.ifr.style.display = "none"
            };
            this._isWindowHidden = function (a) {
                var b = a.style.display == "none";
                return b
            };
            this._closeWindow = function (a) {
                var b = this.wins[a];
                if (this._focusFixIE) this._focusFixIE.style.top = (this.vp == document.body ? 0 : getAbsoluteTop(this.vp)) + Number(b.y) + "px",
                this._focusFixIE.focus();
                if (b.checkEvent("onClose")) {
                    if (!b.callEvent("onClose", [b])) return
                } else if (!this.callEvent("onClose", [b])) return;
                b = null;
                this._removeWindowGlobal(a);
                var c = {
                    zi: 0
                },
                d;
                for (d in this.wins) this.wins[d].zi > c.zi && (c = this.wins[d]);
                c != null && this._makeActive(c)
            };
            this._needHelp = function (a) {
                var b = this.wins[a];
                b.checkEvent("onHelp") ? b.callEvent("onHelp", [b]) : this.callEvent("onHelp", [b]);
                b = null
            };
            this._setWindowIcon = function (a, b, c) {
                a.iconsPresent = !0;
                a.icons[0] = this.imagePath + b;
                a.icons[1] = this.imagePath + c;
                this._engineUpdateWindowIcon(a, a.icons[a.isOnTop() ? 0 : 1])
            };
            this._getWindowIcon = function (a) {
                return a.iconsPresent ? [a.icons[0], a.icons[1]] : [null, null]
            };
            this._clearWindowIcons = function (a) {
                a.iconsPresent = !1;
                a.icons[0] = this.imagePath + this.pathPrefix + this.skin + "/active/icon_blank.gif";
                a.icons[1] = this.imagePath + this.pathPrefix + this.skin + "/inactive/icon_blank.gif";
                this._engineUpdateWindowIcon(a, a.icons[a.isOnTop() ? 0 : 1])
            };
            this._restoreWindowIcons = function (a) {
                a.iconsPresent = !0;
                a.icons[0] = this.imagePath + this.pathPrefix + this.skin + "/active/icon_normal.gif";
                a.icons[1] = this.imagePath + this.pathPrefix + this.skin + "/inactive/icon_normal.gif";
                this._engineUpdateWindowIcon(a, a.icons[a.className == "dhtmlx_window_active" ? 0 : 1])
            };
            this._attachWindowContentTo = function (a, b, c, d) {
                var f = this._engineGetWindowContent(a).parentNode;
                f.parentNode.removeChild(f);
                a.hide();
                f.style.left = "0px";
                f.style.top = "0px";
                f.style.width = (c != null ? c : b.offsetWidth) + "px";
                f.style.height = (d != null ? d : b.offsetHeight) + "px";
                f.style.position = "relative";
                b.appendChild(f);
                this._engineGetWindowContent(a).style.width = f.style.width;
                this._engineGetWindowContent(a).style.height = f.style.height
            };
            this._setWindowToFullScreen = function (a, b) {
                if (b == !0 && !a._isFullScreened) a._p1 = a.vs[a.av].dhxcont.nextSibling,
                a._p1.parentNode.removeChild(a.vs[a.av].dhxcont),
                a.hide(),
                a._isFullScreened = !0,
                a._FSoffsetHeight = a._offsetHeight,
                a._FSoffsetHeightSaved = a._offsetHeightSaved,
                a._FSoffsetLeft = a._offsetLeft,
                a._FSoffsetWidth = a._offsetWidth,
                a._offsetHeight = 0,
                a._offsetHeightSaved = 0,
                a._offsetLeft = 0,
                a._offsetWidth = 0,
                a.vs[a.av].dhxcont.style.position = "absolute",
                document.body.appendChild(a.vs[a.av].dhxcont),
                a.adjustContent(document.body, 0, 0, !1, 0),
                a.updateNestedObjects();
                if (b == !1 && a._isFullScreened) a._p1.parentNode.insertBefore(a.vs[a.av].dhxcont, a._p1),
                a._p1 = null,
                a._isFullScreened = !1,
                a._offsetHeight = a._FSoffsetHeight,
                a._offsetHeightSaved = a._FSoffsetHeightSaved,
                a._offsetLeft = a._FSoffsetLeft,
                a._offsetWidth = a._FSoffsetWidth,
                a._FSoffsetHeight = a._FSoffsetHeightSaved = a._FSoffsetLeft = a._FSoffsetWidth = null,
                a.show(),
                a.setDimension(a.w, a.h),
                a.bringToTop()
            };
            this._isWindowOnTop = function (a) {
                var b = this.getTopmostWindow() == a;
                return b
            };
            this._bringOnBottom = function (a) {
                for (var b in this.wins) if (this.wins[b].zi < a.zi) this.wins[b].zi += this.zIndexStep,
                this.wins[b].style.zIndex = this.wins[b].zi;
                a.zi = 50;
                a.style.zIndex = a.zi;
                this._makeActive(this.getTopmostWindow())
            };
            this._isWindowOnBottom = function (a) {
                var b = !0,
                c;
                for (c in this.wins) this.wins[c] != a && (b = b && this.wins[c].zi > a.zi);
                return b
            };
            this._stickWindow = function (a) {
                var b = this.wins[a];
                b._isSticked = !0;
                this._hideButton(b, "stick");
                this._showButton(b, "sticked");
                this._bringOnTop(b);
                b = null
            };
            this._unstickWindow = function (a) {
                var b = this.wins[a];
                b._isSticked = !1;
                this._hideButton(b, "sticked");
                this._showButton(b, "stick");
                this._bringOnTopAnyStickedWindows();
                b = null
            };
            this._addUserButton = function (a, b, c, d) {
                var b = String(b).toLowerCase(),
                f = this._engineAddUserButton(a, b, c);
                f.title = d;
                f.isVisible = !0;
                f._isEnabled = !0;
                f.isPressed = !1;
                f.label = b;
                a.btns[b] = f;
                a.btns[b].winId = a.idd;
                a.btns[b]._doOnClick = function () { };
                this._attachEventsOnButton(a.idd, b);
                f = null
            };
            this._removeUserButton = function (a, b) {
                this._removeButtonGlobal(a, b)
            };
            this._blockSwitcher = function (a) {
                for (var b in this.wins) a == !0 ? this.wins[b].showCoverBlocker() : this.wins[b].hideCoverBlocker()
            };
            this.modalWin = this.resizingWin = null;
            this.resizingDirs = "none";
            if (_isIE) this._focusFixIE = document.createElement("INPUT"),
            this._focusFixIE.className = "dhx_windows_ieonclosefocusfix",
            this._focusFixIE.style.position = "absolute",
            this._focusFixIE.style.width = "1px",
            this._focusFixIE.style.height = "1px",
            this._focusFixIE.style.border = "none",
            this._focusFixIE.style.background = "none",
            this._focusFixIE.style.left = "-10px",
            this._focusFixIE.style.fontSize = "1px",
            document.body.appendChild(this._focusFixIE);
            this._createViewport();
            this._doOnMouseUp = function () {
                c != null && c._stopMove()
            };
            this._doOnMoseMove = function (a) {
                a = a || event;
                c != null && c._moveWindow(a)
            };
            this._resizeTM = null;
            this._resizeTMTime = 200;
            this._lw = null;
            this._doOnResize = function () {
                if (c._lw != document.documentElement.clientHeight) window.clearTimeout(c._resizeTM),
                c._resizeTM = window.setTimeout(function () {
                    c._autoResizeViewport()
                },
                c._resizeTMTime);
                c._lw = document.documentElement.clientHeight
            };
            this._doOnUnload = function () {
                c.unload()
            };
            this._doOnSelectStart = function (a) {
                a = a || event;
                if (c.movingWin != null || c.resizingWin != null) a.returnValue = !1
            };

            if (_isIE) {
                if (window.attachEvent)
                    document.body.attachEvent("onselectstart", this._doOnSelectStart);
                else
                    document.body.addEventListener("onselectstart", this._doOnSelectStart);
            }
            dhtmlxEvent(window, "resize", this._doOnResize);
            dhtmlxEvent(document.body, "unload", this._doOnUnload);
            this._isIPad ? (document.addEventListener("touchmove", this._doOnMoseMove, !1), document.addEventListener("touchend", this._doOnMouseUp, !1)) : (dhtmlxEvent(document.body, "mouseup", this._doOnMouseUp), dhtmlxEvent(this.vp, "mousemove", this._doOnMoseMove), dhtmlxEvent(this.vp, "mouseup", this._doOnMouseUp));
            this._setWindowModal = function (a, b) {
                b == !0 ? (this._makeActive(a), this._bringOnTop(a), this.modalWin = a, a._isModal = !0, this.modalCoverI.style.zIndex = a.zi - 2, this.modalCoverI.style.display = "", this.modalCoverD.style.zIndex = a.zi - 2, this.modalCoverD.style.display = "") : (this.modalWin = null, a._isModal = !1, this.modalCoverI.style.zIndex = 0, this.modalCoverI.style.display = "none", this.modalCoverD.style.zIndex = 0, this.modalCoverD.style.display = "none")
            };
            this._bringOnTopAnyStickedWindows = function () {
                var a = [],
                b;
                for (b in this.wins) this.wins[b]._isSticked && (a[a.length] = this.wins[b]);
                for (var c = 0; c < a.length; c++) this._bringOnTop(a[c]);
                if (a.length == 0) for (b in this.wins) this.wins[b].className == "dhtmlx_window_active" && this._bringOnTop(this.wins[b])
            };
            this.unload = function () {
                this._clearAll()
            };
            this._removeButtonGlobal = function (a, b) {
                if (this.wins[a] && this.wins[a].btns[b]) {
                    var c = this.wins[a].btns[b];
                    c.title = null;
                    c.isVisible = null;
                    c._isEnabled = null;
                    c.isPressed = null;
                    c.label = null;
                    c._doOnClick = null;
                    c.detachAllEvents();
                    c.attachEvent = null;
                    c.callEvent = null;
                    c.checkEvent = null;
                    c.detachEvent = null;
                    c.detachAllEvents = null;
                    c.disable = null;
                    c.enable = null;
                    c.eventCatcher = null;
                    c.hide = null;
                    c.isEnabled = null;
                    c.isHidden = null;
                    c.show = null;
                    c.onmousedown = null;
                    c.onmouseout = null;
                    c.onmouseover = null;
                    c.onmouseup = null;
                    c.ontouchstart = null;
                    c.ontouchend = null;
                    c.parentNode && c.parentNode.removeChild(c);
                    c = null;
                    this.wins[a].btns[b] = null;
                    delete this.wins[a].btns[b]
                }
            };
            this._removeWindowGlobal = function (a) {
                var b = this.wins[a];
                this.modalWin == b && this._setWindowModal(b, !1);
                if (this.iframeMode && b.ifr) b.ifr.parentNode.removeChild(b.ifr),
                b.ifr = null;
                var c = b.coverBlocker(),
                c = c.onselectstart = null;
                this._engineDiableOnSelectInWindow(b, !1);
                b._dhxContDestruct();
                this._engineGetWindowHeader(b).onmousedown = null;
                this.resizingWin = this.movingWin = this._engineGetWindowHeader(b).ondblclick = null;
                for (var d in b.btns) this._removeButtonGlobal(b, d);
                b.btns = null;
                b.detachAllEvents();
                b._adjustToContent = null;
                b._doOnAttachMenu = null;
                b._doOnAttachStatusBar = null;
                b._doOnAttachToolbar = null;
                b._doOnFrameMouseDown = null;
                b._doOnFrameContentLoaded = null;
                b._redraw = null;
                b.addUserButton = null;
                b.allowMove = null;
                b.allowPark = null;
                b.allowResize = null;
                b.attachEvent = null;
                b.bringToBottom = null;
                b.bringToTop = null;
                b.callEvent = null;
                b.center = null;
                b.centerOnScreen = null;
                b.checkEvent = null;
                b.clearIcon = null;
                b.close = null;
                b.denyMove = null;
                b.denyPark = null;
                b.denyResize = null;
                b.detachEvent = null;
                b.detachAllEvents = null;
                b.eventCatcher = null;
                b.getDimension = null;
                b.getIcon = null;
                b.getId = null;
                b.getMaxDimension = null;
                b.getMinDimension = null;
                b.getPosition = null;
                b.getText = null;
                b.hide = null;
                b.hideHeader = null;
                b.isHidden = null;
                b.isMaximized = null;
                b.isModal = null;
                b.isMovable = null;
                b.isOnBottom = null;
                b.isOnTop = null;
                b.isParkable = null;
                b.isParked = null;
                b.isResizable = null;
                b.isSticked = null;
                b.keepInViewport = null;
                b.maximize = null;
                b.minimize = null;
                b.park = null;
                b.progressOff = null;
                b.progressOn = null;
                b.removeUserButton = null;
                b.restoreIcon = null;
                b.setDimension = null;
                b.setIcon = null;
                b.setMaxDimension = null;
                b.setMinDimension = null;
                b.setModal = null;
                b.setPosition = null;
                b.setText = null;
                b.setToFullScreen = null;
                b.show = null;
                b.showHeader = null;
                b.stick = null;
                b.unstick = null;
                b.onmousemove = null;
                b.onmousedown = null;
                b.icons = null;
                b.button = null;
                b._dhxContDestruct = null;
                b.dhxContGlobal.obj = null;
                b.dhxContGlobal.setContent = null;
                b.dhxContGlobal.dhxcont = null;
                b.dhxContGlobal = null;
                if (b._frame) {
                    for (; b._frame.childNodes.length > 0;) b._frame.removeChild(b._frame.childNodes[0]);
                    b._frame = null
                }
                this._parseNestedForEvents(b);
                b._content = null;
                b.innerHTML = "";
                b.parentNode.removeChild(b);
                b = null;
                this.wins[a] = null;
                delete this.wins[a]
            };
            this._removeEvents = function (a) {
                a.onmouseover = null;
                a.onmouseout = null;
                a.onmousemove = null;
                a.onclick = null;
                a.ondblclick = null;
                a.onmouseenter = null;
                a.onmouseleave = null;
                a.onmouseup = null;
                a.onmousewheel = null;
                a.onmousedown = null;
                a.onselectstart = null;
                a.onfocus = null;
                a.style.display = "";
                a = null
            };
            this._parseNestedForEvents = function (a) {
                this._removeEvents(a);
                for (var b = 0; b < a.childNodes.length; b++) a.childNodes[b].tagName != null && this._parseNestedForEvents(a.childNodes[b]);
                a = null
            };
            this._clearAll = function () {
                this._clearDocumentEvents();
                for (var a in this.wins) this._removeWindowGlobal(a);
                this.wins = null;
                for (this._parseNestedForEvents(this._carcass) ; this._carcass.childNodes.length > 0;) this._carcass.removeChild(this._carcass.childNodes[0]);
                this._carcass.onselectstart = null;
                this._carcass.parentNode.removeChild(this._carcass);
                this._carcass = null;
                this._parseNestedForEvents(this._vpcover);
                this._vpcover.parentNode.removeChild(this._vpcover);
                this._vpcover = null;
                this._parseNestedForEvents(this.modalCoverD);
                this.modalCoverD.parentNode.removeChild(this.modalCoverD);
                this.modalCoverD = null;
                this._parseNestedForEvents(this.modalCoverI);
                this.modalCoverI.parentNode.removeChild(this.modalCoverI);
                this.modalCoverI = null;
                this.vp.autocreated == !0 && this.vp.parentNode.removeChild(this.vp);
                this.vp = null;
                for (a in this.skinParams) delete this.skinParams[a];
                c = this.window = this.unload = this.setViewport = this.setSkin = this.setImagePath = this.setEffect = this.isWindow = this.getTopmostWindow = this.getEffect = this.getBottommostWindow = this.forEachWindow = this.findByText = this.eventCatcher = this.enableAutoViewport = this.detachEvent = this.createWindow = this.checkEvent = this.callEvent = this.attachViewportTo = this.attachEvent = this._unstickWindow = this._stopMove = this._stickWindow = this._showWindow = this._showButton = this._setWindowToFullScreen = this._setWindowModal = this._setWindowIcon = this._restoreWindowIcons = this._restoreWindow = this._removeWindowGlobal = this._removeUserButton = this._removeEvents = this._removeButtonGlobal = this._parseNestedForEvents = this._parkWindow = this._needHelp = this._moveWindow = this._maximizeWindow = this._makeActive = this._isWindowOnTop = this._isWindowOnBottom = this._isWindowHidden = this._hideWindow = this._hideButton = this._getWindowIcon = this._getTopZIndex = this._getActive = this._genStr = this._fixWindowDimensionInViewport = this._engineUpdateWindowIcon = this._engineSwitchWindowProgress = this._engineSwitchWindowHeader = this._engineSetWindowBody = this._engineRedrawWindowTitle = this._engineRedrawWindowSize = this._engineRedrawWindowPos = this._engineRedrawSkin = this._engineGetWindowParkedHeight = this._engineGetWindowLabel = this._engineGetWindowHeaderState = this._engineGetWindowHeader = this._engineGetWindowContent = this._engineGetWindowButton = this._engineFixWindowPosInViewport = this._engineDoOnWindowParkUp = this._engineDoOnWindowParkDown = this._engineDiableOnSelectInWindow = this._engineCheckHeaderMouseDown = this._engineAllowWindowResize = this._engineAdjustWindowToContent = this._engineAddUserButton = this._enableButton = this._doParkUp = this._doParkDown = this._doOnUnload = this._doOnSelectStart = this._doOnResize = this._doOnMouseUp = this._doOnMoseMove = this._disableButton = this._dhx_Engine = this._denyResize = this._denyParking = this._createViewport = this._closeWindow = this._clearWindowIcons = this._clearDocumentEvents = this._clearAll = this._centerWindow = this._bringOnTopAnyStickedWindows = this._bringOnTop = this._bringOnBottom = this._blockSwitcher = this._autoResizeViewport = this._attachWindowContentTo = this._attachEventsOnButton = this._allowReszieGlob = this._allowParking = this._addUserButton = this._addDefaultButtons = this._engineSkinParams = this._effects = this.skinParams = null
            };
            this._clearDocumentEvents = function () {
                _isIE ? (window.detachEvent("onresize", this._doOnResize), document.body.detachEvent("onselectstart", this._doOnSelectStart), document.body.detachEvent("onmouseup", this._doOnMouseUp), document.body.detachEvent("onunload", this._doOnUnload), this.vp.detachEvent("onmousemove", this._doOnMoseMove), this.vp.detachEvent("onmouseup", this._doOnMouseUp)) : (window.removeEventListener("resize", this._doOnResize, !1), document.body.removeEventListener("mouseup", this._doOnMouseUp, !1), document.body.removeEventListener("unload", this._doOnUnload, !1), this.vp.removeEventListener("mousemove", this._doOnMoseMove, !1), this.vp.removeEventListener("mouseup", this._doOnMouseUp, !1))
            };
            this._genStr = function (a) {
                for (var b = "",
                c = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789",
                d = 0; d < a; d++) b += c.charAt(Math.round(Math.random() * (c.length - 1)));
                return b
            };
            dhtmlxEventable(this);
            return this
        } else alert(this.i18n.noenginealert)
    } else alert(this.i18n.dhx)
}
dhtmlXWindows.prototype._dhx_Engine = function () {
    this._engineEnabled = !0;
    this._engineName = "dhx";
    this._engineSkinParams = {
        dhx_blue: {
            hh: 21,
            lbw: 2,
            rbw: 2,
            lch: 2,
            lcw: 14,
            rch: 14,
            rcw: 14,
            bbh: 2,
            mnh: 23,
            tbh: 25,
            sbh: 20,
            noh_t: null,
            noh_h: null
        },
        dhx_black: {
            hh: 21,
            lbw: 2,
            rbw: 2,
            lch: 2,
            lcw: 14,
            rch: 14,
            rcw: 14,
            bbh: 2,
            mnh: 23,
            tbh: 25,
            sbh: 20,
            noh_t: null,
            noh_h: null
        },
        dhx_skyblue: {
            hh: 29,
            lbw: 2,
            rbw: 2,
            lch: 2,
            lcw: 14,
            rch: 14,
            rcw: 14,
            bbh: 2,
            mnh: 23,
            tbh: 25,
            sbh: 20,
            noh_t: 5,
            noh_h: -10
        },
        dhx_web: {
            hh: 27,
            lbw: 5,
            rbw: 5,
            lch: 5,
            lcw: 14,
            rch: 14,
            rcw: 14,
            bbh: 5,
            mnh: 23,
            tbh: 25,
            sbh: 20,
            noh_t: 5,
            noh_h: -10
        },
        dhx_terrace: {
            hh: 37,
            lbw: 5,
            rbw: 5,
            lch: 5,
            lcw: 14,
            rch: 14,
            rcw: 14,
            bbh: 5,
            mnh: 23,
            tbh: 25,
            sbh: 20,
            noh_t: 5,
            noh_h: -10
        }
    };
    this._isIE6 = !1;
    if (_isIE) this._isIE6 = window.XMLHttpRequest == null ? !0 : !1;
    this._engineSetWindowBody = function (d) {
        d.innerHTML = "<div iswin='1' class='dhtmlx_wins_body_outer' style='position: relative;'>" + (this._isIE6 ? "<iframe src='javascript:false;' frameborder='0' class='dhtmlx_wins_ie6_cover_fix' onload='this.contentWindow.document.body.style.overflow=\"hidden\";'></iframe>" : "") + "<div class='dhtmlx_wins_icon'></div><div class='dhtmlx_wins_progress'></div><div class='dhtmlx_wins_title'>dhtmlxWindow</div><div class='dhtmlx_wins_btns'><div class='dhtmlx_wins_btns_button dhtmlx_button_sticked_default'></div><div class='dhtmlx_wins_btns_button dhtmlx_button_stick_default'></div><div class='dhtmlx_wins_btns_button dhtmlx_button_help_default'></div><div class='dhtmlx_wins_btns_button dhtmlx_button_park_default'></div><div class='dhtmlx_wins_btns_button dhtmlx_button_minmax2_default'></div><div class='dhtmlx_wins_btns_button dhtmlx_button_minmax1_default'></div><div class='dhtmlx_wins_btns_button dhtmlx_button_close_default'></div><div class='dhtmlx_wins_btns_button dhtmlx_button_dock_default'></div></div><div class='dhtmlx_wins_body_inner'></div><div winResT='yes' class='dhtmlx_wins_resizer_t' style='display:none;'></div><div winResL='yes' class='dhtmlx_wins_resizer_l'></div><div winResR='yes' class='dhtmlx_wins_resizer_r'></div><div winResB='yes' class='dhtmlx_wins_resizer_b'></div><div class='white_line'></div><div class='white_line2'></div></div>";
        d.dhxContGlobal = new dhtmlXContainer(d);
        if (this.skin == "dhx_skyblue") d.dhxContGlobal.obj._offsetWidth = -10,
        d.dhxContGlobal.obj._offsetHeight = -5,
        d.dhxContGlobal.obj._offsetLeft = 5,
        d.dhxContGlobal.obj._offsetHeightSaved = d.dhxContGlobal.obj._offsetHeight;
        if (this.skin == "dhx_web") d.dhxContGlobal.obj._offsetWidth = -10,
        d.dhxContGlobal.obj._offsetHeight = -5,
        d.dhxContGlobal.obj._offsetLeft = 5,
        d.dhxContGlobal.obj._offsetHeightSaved = d.dhxContGlobal.obj._offsetHeight;
        d.skin = this.skin;
        d.dhxContGlobal.setContent(d.childNodes[0].childNodes[this._isIE6 ? 5 : 4]);
        var c = d.coverBlocker();
        c.onselectstart = function (c) {
            c = c || event;
            c.returnValue = !1;
            c.cancelBubble = !0
        };
        c = null;
        if (this.iframeMode) d.ifr = document.createElement("IFRAME"),
        d.ifr.style.position = "absolute",
        d.ifr.style.left = d.style.left,
        d.ifr.style.top = d.style.top,
        d.ifr.style.width = d.style.width,
        d.ifr.style.height = d.style.height,
        d.ifr.style.zIndex = d.style.zIndex - 1,
        d.ifr.style.backgroundColor = "white",
        d.ifr.frameBorder = 0,
        d.ifr.setAttribute("src", "javascript:false;"),
        d.parentNode.appendChild(d.ifr)
    };
    this._engineDiableOnSelectInWindow = function (d, c) {
        var f = [];
        f[0] = d.childNodes[0].childNodes[this._isIE6 ? 1 : 0];
        f[1] = d.childNodes[0].childNodes[this._isIE6 ? 2 : 1];
        f[2] = d.childNodes[0].childNodes[this._isIE6 ? 3 : 2];
        f[3] = d.childNodes[0].childNodes[this._isIE6 ? 4 : 3];
        f[4] = d.childNodes[0].childNodes[this._isIE6 ? 6 : 5];
        f[5] = d.childNodes[0].childNodes[this._isIE6 ? 7 : 6];
        f[6] = d.childNodes[0].childNodes[this._isIE6 ? 8 : 7];
        f[7] = d.childNodes[0].childNodes[this._isIE6 ? 9 : 8];
        for (var a = 0; a < f.length; a++) f[a].onselectstart = c ?
        function (a) {
            a = a || event;
            return a.returnValue = !1
        } : null,
        f[a] = null;
        f = null
    };
    this._engineGetWindowHeader = function (d) {
        d.childNodes[0].idd = d.idd;
        return d.childNodes[0]
    };
    this._engineRedrawWindowSize = function (d) {
        d.style.width = String(d.w).search("%") == -1 ? d.w + "px" : d.w;
        d.style.height = String(d.h).search("%") == -1 ? d.h + "px" : d.h;
        var c = d.childNodes[0];
        c.style.width = d.clientWidth + "px";
        c.style.height = d.clientHeight + "px";
        if (c.offsetWidth > d.clientWidth) c.style.width = d.clientWidth * 2 - c.offsetWidth + "px";
        if (c.offsetHeight > d.clientHeight) {
            var f = d.clientHeight * 2 - c.offsetHeight;
            f < 0 && (f = 0);
            c.style.height = f + "px"
        }
        var a = d._noHeader == !0 ? d._hdrSize : this._engineSkinParams[this.skin].hh;
        if (this.iframeMode && d.ifr) d.ifr.style.width = d.style.width,
        d.ifr.style.height = d.style.height;
        this._engineRedrawWindowTitle(d);
        d.adjustContent(c, a)
    };
    this._engineRedrawWindowPos = function (d) {
        if (!d._isFullScreened && (d.style.left = d.x + "px", d.style.top = d.y + "px", this.iframeMode && d.ifr)) d.ifr.style.top = d.style.top,
        d.ifr.style.left = d.style.left
    };
    this._engineFixWindowPosInViewport = function (d) {
        var c = d._noHeader == !0 ? d._hdrSize : this._engineSkinParams[this.skin].hh;
        if (d._keepInViewport) {
            if (d.x < 0) d.x = 0;
            if (d.x + d.w > this.vp.offsetWidth) d.x = this.vp.offsetWidth - d.w;
            if (d.y + d.h > this.vp.offsetHeight) d.y = this.vp.offsetHeight - d.h;
            if (d.y < 0) d.y = 0
        } else {
            if (d.y + c > this.vp.offsetHeight) d.y = this.vp.offsetHeight - c;
            if (d.y < 0) d.y = 0;
            if (d.x + d.w - 10 < 0) d.x = 10 - d.w;
            if (d.x > this.vp.offsetWidth - 10) d.x = this.vp.offsetWidth - 10
        }
    };
    this._engineCheckHeaderMouseDown = function (d, c) {
        if (this._isIPad) {
            var f = c.touches[0].clientX,
            a = c.touches[0].clientY,
            b = c.target || c.srcElement;
            return b == d.childNodes[0] || b == d.childNodes[0].childNodes[0] || b == d.childNodes[0].childNodes[2] || b == d.childNodes[0].childNodes[3] ? !0 : !1
        } else f = _isIE || _isOpera ? c.offsetX : c.layerX,
        a = _isIE || _isOpera ? c.offsetY : c.layerY,
        b = c.target || c.srcElement;
        var g = d._noHeader == !0 ? d._hdrSize : this._engineSkinParams[this.skin].hh;
        return a <= g && (b == d.childNodes[0] || b == d.childNodes[0].childNodes[this._isIE6 ? 1 : 0] || b == d.childNodes[0].childNodes[this._isIE6 ? 3 : 2] || b == d.childNodes[0].childNodes[this._isIE6 ? 4 : 3]) ? !0 : !1
    };
    this._engineGetWindowContent = function () {
        alert("_engineGetWindowContent")
    };
    this._engineGetWindowButton = function (d, c) {
        for (var c = String(c).toLowerCase(), f = null, a = "dhtmlx_button_" + c + "_", b = 0; b < d.childNodes[0].childNodes[this._isIE6 ? 4 : 3].childNodes.length; b++) {
            var g = d.childNodes[0].childNodes[this._isIE6 ? 4 : 3].childNodes[b];
            String(g.className).search(a) != -1 && (f = g);
            g = null
        }
        return f
    };
    this._engineAddUserButton = function (d, c, f) {
        isNaN(f) && (f = 0);
        var a = document.createElement("DIV");
        a.className = "dhtmlx_wins_btns_button dhtmlx_button_" + c + "_default";
        var b = d.childNodes[0].childNodes[this._isIE6 ? 4 : 3],
        f = b.childNodes.length - f;
        f < 0 && (f = 0);
        f >= b.childNodes.length ? b.appendChild(a) : b.insertBefore(a, b.childNodes[f]);
        this._engineRedrawWindowTitle(d);
        return a
    };
    this._engineGetWindowParkedHeight = function () {
        return this._engineSkinParams[this.skin].hh + 1
    };
    this._engineDoOnWindowParkDown = function (d) {
        d.childNodes[0].childNodes[this._isIE6 ? 6 : 5].style.display = d._noHeader == !0 ? "" : "none";
        d.childNodes[0].childNodes[this._isIE6 ? 7 : 6].style.display = "";
        d.childNodes[0].childNodes[this._isIE6 ? 8 : 7].style.display = "";
        d.childNodes[0].childNodes[this._isIE6 ? 9 : 8].style.display = ""
    };
    this._engineDoOnWindowParkUp = function (d) {
        d.childNodes[0].childNodes[this._isIE6 ? 6 : 5].style.display = "none";
        d.childNodes[0].childNodes[this._isIE6 ? 7 : 6].style.display = "none";
        d.childNodes[0].childNodes[this._isIE6 ? 8 : 7].style.display = "none";
        d.childNodes[0].childNodes[this._isIE6 ? 9 : 8].style.display = "none"
    };
    this._engineUpdateWindowIcon = function (d, c) {
        d.childNodes[0].childNodes[this._isIE6 ? 1 : 0].style.backgroundImage = "url('" + c + "')"
    };
    this._engineAllowWindowResize = function (d, c, f, a) {
        if (c.getAttribute) {
            var b = this._engineSkinParams[this.skin],
            g = d._noHeader == !0 ? d._hdrSize : this._engineSkinParams[this.skin].hh;
            return c.getAttribute("winResL") != null && c.getAttribute("winResL") == "yes" && a >= g ? a >= d.h - b.lch ? "corner_left" : a <= b.lch && d._noHeader == !0 ? "corner_up_left" : "border_left" : c.getAttribute("winResR") != null && c.getAttribute("winResR") == "yes" && a >= g ? a >= d.h - b.rch ? "corner_right" : a <= b.rch && d._noHeader == !0 ? "corner_up_right" : "border_right" : c.getAttribute("winResT") != null && c.getAttribute("winResT") == "yes" && d._noHeader == !0 ? f <= b.lcw ? "corner_up_left" : f >= d.w - b.rcw ? "corner_up_right" : "border_top" : c.getAttribute("winResB") != null && c.getAttribute("winResB") == "yes" ? f <= b.lcw ? "corner_left" : f >= d.w - b.rcw ? "corner_right" : "border_bottom" : null
        }
    };
    this._engineAdjustWindowToContent = function (d, c, f) {
        var a = c + d.w - d.vs[d.av].dhxcont.clientWidth,
        b = f + d.h - d.vs[d.av].dhxcont.clientHeight;
        d.setDimension(a, b)
    };
    this._engineRedrawSkin = function () {
        this.vp.className = (this.vp == document.body && this.vp._css ? this.vp._css + " " : "") + "dhtmlx_winviewport dhtmlx_skin_" + this.skin + (this._r ? " dhx_wins_rtl" : "");
        var d = this._engineSkinParams[this.skin],
        c;
        for (c in this.wins) this.skin == "dhx_skyblue" ? (this.wins[c].dhxContGlobal.obj._offsetTop = this.wins[c]._noHeader ? d.noh_t : null, this.wins[c].dhxContGlobal.obj._offsetWidth = -10, this.wins[c].dhxContGlobal.obj._offsetHeight = this.wins[c]._noHeader ? d.noh_h : -5, this.wins[c].dhxContGlobal.obj._offsetLeft = 5, this.wins[c].dhxContGlobal.obj._offsetHeightSaved = -5) : (this.wins[c].dhxContGlobal.obj._offsetWidth = null, this.wins[c].dhxContGlobal.obj._offsetHeight = null, this.wins[c].dhxContGlobal.obj._offsetLeft = null, this.wins[c].dhxContGlobal.obj._offsetTop = null, this.wins[c].dhxContGlobal.obj._offsetHeightSaved = null),
        this.wins[c].skin = this.skin,
        this._restoreWindowIcons(this.wins[c]),
        this._engineRedrawWindowSize(this.wins[c])
    };
    this._engineSwitchWindowProgress = function (d, c) {
        c == !0 ? (d.childNodes[0].childNodes[this._isIE6 ? 1 : 0].style.display = "none", d.childNodes[0].childNodes[this._isIE6 ? 2 : 1].style.display = "") : (d.childNodes[0].childNodes[this._isIE6 ? 2 : 1].style.display = "none", d.childNodes[0].childNodes[this._isIE6 ? 1 : 0].style.display = "")
    };
    this._engineSwitchWindowHeader = function (d, c) {
        if (!d._noHeader) d._noHeader = !1;
        if (c == d._noHeader) {
            d._noHeader = c == !0 ? !1 : !0;
            d._hdrSize = 0;
            d.childNodes[0].childNodes[this._isIE6 ? 5 : 4].className = "dhtmlx_wins_body_inner" + (d._noHeader ? " dhtmlx_wins_no_header" : "");
            d.childNodes[0].childNodes[this._isIE6 ? 6 : 5].style.display = d._noHeader ? "" : "none";
            d.childNodes[0].childNodes[this._isIE6 ? 1 : 0].style.display = d._noHeader ? "none" : "";
            d.childNodes[0].childNodes[this._isIE6 ? 3 : 2].style.display = d._noHeader ? "none" : "";
            d.childNodes[0].childNodes[this._isIE6 ? 4 : 3].style.display = d._noHeader ? "none" : "";
            var f = this._engineSkinParams[this.skin];
            d._noHeader ? (d.dhxContGlobal.obj._offsetHeightSaved = d.dhxContGlobal.obj._offsetHeight, d.dhxContGlobal.obj._offsetHeight = f.noh_h, d.dhxContGlobal.obj._offsetTop = f.noh_t) : (d.dhxContGlobal.obj._offsetHeight = d.dhxContGlobal.obj._offsetHeightSaved, d.dhxContGlobal.obj._offsetTop = null);
            this._engineRedrawWindowSize(d)
        }
    };
    this._engineGetWindowHeaderState = function (d) {
        return d._noHeader ? !0 : !1
    };
    this._engineGetWindowLabel = function (d) {
        return d.childNodes[0].childNodes[this._isIE6 ? 3 : 2]
    };
    this._engineRedrawWindowTitle = function (d) {
        if (d._noHeader !== !0) {
            var c = d.childNodes[0].childNodes[this._isIE6 ? 1 : 0].offsetWidth,
            f = d.childNodes[0].childNodes[this._isIE6 ? 4 : 3].offsetWidth,
            a = d.offsetWidth - c - f - 24;
            a < 0 ? a = "100%" : a += "px";
            d.childNodes[0].childNodes[this._isIE6 ? 3 : 2].style.width = a
        }
    }
};
dhtmlXWindows.prototype.i18n = {
    dhxcontaler: "dhtmlxcontainer.js is missed on the page",
    noenginealert: "No dhtmlxWindows engine was found.",
    stick: "Stick",
    unstick: "Unstick",
    help: "Help",
    parkdown: "Park Down",
    parkup: "Park Up",
    maximize: "Maximize",
    restore: "Restore",
    close: "Close",
    dock: "Dock"
}; (function () {
    dhtmlx.extend_api("dhtmlXWindows", {
        _init: function () {
            return []
        },
        _patch: function (c) {
            c.old_createWindow = c.createWindow;
            c.createWindow = function (c) {
                if (arguments.length > 1) return this.old_createWindow.apply(this, arguments);
                var a = this.old_createWindow(c.id, c.x || c.left, c.y || c.top, c.width, c.height);
                a.allowMoveA = function (a) {
                    a ? this.allowMove() : this.denyMove()
                };
                a.allowParkA = function (a) {
                    a ? this.allowPark() : this.denyPark()
                };
                a.allowResizeA = function (a) {
                    a ? this.allowResize() : this.denyResize()
                };
                for (var b in c) if (d[b]) a[d[b]](c[b]);
                else b.indexOf("on") == 0 && a.attachEvent(b, c[b]);
                return a
            }
        },
        animation: "setEffect",
        image_path: "setImagePath",
        skin: "setSkin",
        viewport: "_viewport",
        wins: "_wins"
    },
    {
        _viewport: function (c) {
            c.object ? (this.enableAutoViewport(!1), this.attachViewportTo(c.object)) : (this.enableAutoViewport(!1), this.setViewport(c.left, c.top, c.width, c.height, c.parent))
        },
        _wins: function (c) {
            for (var d = 0; d < c.length; d++) {
                var a = c[d];
                this.createWindow(a.id, a.left, a.top, a.width, a.height);
                a.text && this.window(a.id).setText(a.text);
                a.keep_in_viewport && this.window(a.id).keepInViewport(!0);
                a.deny_resize && this.window(a.id).denyResize();
                a.deny_park && this.window(a.id).denyPark();
                a.deny_move && this.window(a.id).denyMove()
            }
        }
    });
    var d = {
        move: "allowMoveA",
        park: "allowParkA",
        resize: "allowResizeA",
        center: "center",
        modal: "setModal",
        caption: "setText",
        header: "showHeader"
    }
})();

//v.3.6 build 130417
/*
Copyright DHTMLX LTD. http://www.dhtmlx.com
You allowed to use this component or parts of it under GPL terms
To use it on other terms or get Professional edition of the component please contact us at sales@dhtmlx.com
*/
