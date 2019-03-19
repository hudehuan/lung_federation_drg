package com.dldata.drgs.controller.Login;

import com.dldata.drgs.service.System.SysSystemDefineService;
import com.dldata.drgs.utils.StringUtil;
import com.dldata.drgs.utils.SysConfig;
import com.dldata.drgs.utils.pubs.DirectoryConfig;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by 吴岳峰 on 2017/6/8.
 */
@Controller
@RequestMapping(value = "/")
public class LoginController {





    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    SysSystemDefineService sysSystemDefineService;

    @Autowired
    private DirectoryConfig directoryConfig;



    @RequestMapping(value = "")
    public ModelAndView home(ModelMap model, HttpServletRequest request, HttpServletResponse response)throws Exception{

        ModelAndView modelAndView = new ModelAndView();
//        List<SysSystemDefineEntity> sysSystemDefineEntities = new ArrayList<SysSystemDefineEntity>();

        String result;
        try {

//            sysSystemDefineEntities = sysSystemDefineService.getAllSystem();

//            if(sysSystemDefineEntities.size()==1){
            //如果只有定义了一个系统，那么直接跳转到这个系统
            String loginurl = directoryConfig.getLogin_url();  //sysSystemDefineEntities.get(0).getLoginUrl();//系统登录页面地址

            //子系统地址和端口
//                String client = "http://" + sysSystemDefineEntities.get(0).getRedirectIp() +":"+
//                        sysSystemDefineEntities.get(0).getRedirectPort() + "/"+ sysSystemDefineEntities.get(0).getRedirectUrl() ;

            //子系统系统编号
            String sysCode = SysConfig.SysCode;

            //跳转到登录处理controller
            String url = "redirect:/user/tologin/" + loginurl+ "?syscode=" + sysCode  ;// + "?client=" + client ;
            modelAndView.setViewName(url);
            //return  new ModelAndView(url);



//            }else{
            //ModelAndView modelAndView = new ModelAndView();
//                modelAndView.setViewName("index");
//                modelAndView.addObject("sysSystems",sysSystemDefineEntities);
            // model.addAttribute("sysSystems",sysSystemDefineEntities);

//                return modelAndView;
//            }
        }
        catch(Exception ex){
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\""+ ex.getMessage().replace("\r","").replace("\n","")+"}";
            StringUtil.writeToWeb(result, "html", response);

            logger.error("【执行"+this.getClass().getName()+".home() 方法失败 】异常："+ex.getMessage());
        }

//        ModelAndView modelAndView = new ModelAndView();
//        modelAndView.setViewName("index");
//        modelAndView.addObject("sysSystems",sysSystemDefineEntities);
//       // model.addAttribute("sysSystems",sysSystemDefineEntities);
//
        return modelAndView;
    }

}
