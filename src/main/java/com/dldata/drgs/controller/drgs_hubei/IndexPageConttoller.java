package com.dldata.drgs.controller.drgs_hubei;

import com.dldata.drgs.entity.DicJgdmEntity;
import com.dldata.drgs.entity.SysUserInfoEntity;
import com.dldata.drgs.entity.SysUserInfoPtEntity;
import com.dldata.drgs.service.System.SysUserInfoPtService;
import com.dldata.drgs.service.System.SysUserInfoService;
import com.dldata.drgs.service.drgsDicData.DicJgdmService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by 吴岳峰 on 2017/08/02.
 */
@Controller
@RequestMapping(value = "/hubei/IndexPage")
public class IndexPageConttoller {
    @Autowired
    SysUserInfoService sysUserInfoService;
    @Autowired
    SysUserInfoPtService sysUserInfoPtService;
    @Autowired
    DicJgdmService dicJgdmService;
    @RequestMapping(value = "/toIndex/{indexpath}")
    public String toIndex(HttpServletRequest request,@PathVariable("indexpath") String indexpath,
                          ModelMap model,@CookieValue(value = "userid" ,defaultValue = "") String userid,
                          @CookieValue(value = "syscode" ,defaultValue = "") String syscode,
                          HttpServletResponse response) throws Exception {

        String url = request.getRequestURI();
        String urlParam = request.getQueryString();

        String reg = "[!$^*+|{}';'\",<>?~！#￥%……*——|{}【】‘；：”“'。，、？]";;
        HttpSession session = request.getSession();
        for(int i=0;i<urlParam.length();i++){
            String str = urlParam.substring(i,i+1);
            if(str.matches(reg)){
                session.setAttribute("paramsError","参数中含有非法字符！");
                response.sendRedirect("/");
                break;
            }
        }
        SysUserInfoPtEntity sysUserInfoPtEntity = sysUserInfoPtService.getAllByUserId(userid,syscode);
        SysUserInfoEntity sysUserInfoEntity = sysUserInfoService.getUserInfoByUserID(userid,syscode);
        if(sysUserInfoEntity.getLoginName().equalsIgnoreCase("admin")){
            model.addAttribute("peizhi","peizhi");
        }
        if(sysUserInfoPtEntity!=null && sysUserInfoPtEntity.getUserType() != null && sysUserInfoPtEntity.getUserType().equals("省级")){
            List<DicJgdmEntity> dicJgdmEntity = dicJgdmService.findInfoByUserId(userid);
            String shi = "";
            int num =0;
            for (DicJgdmEntity jgdmEntity : dicJgdmEntity) {
                if(!jgdmEntity.getShi().equals(jgdmEntity.getIssz())){
                    num++;
                }
            }
            if(dicJgdmEntity.size()>0&&dicJgdmEntity.size()==num){
                shi = dicJgdmEntity.get(0).getIssz();
            } else {
                    shi = dicJgdmEntity.get(0).getShi();
                }
            model.addAttribute("shi",shi);
        }
//        HttpSession session = request.getSession();
        session.setAttribute("indexUrl",url+"?"+urlParam);

        model.addAttribute("urlParam",urlParam);
        return "/drgs_hubei/index/"+indexpath;
    }

}
