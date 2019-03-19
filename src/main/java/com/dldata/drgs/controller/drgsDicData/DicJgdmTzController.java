package com.dldata.drgs.controller.drgsDicData;

import com.dldata.drgs.entity.DicJgdmTzEntity;
import com.dldata.drgs.service.drgsDicData.DicJgdmTzService;
import com.dldata.drgs.utils.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Random;

/**
 * Created by 吴岳峰 on 2017/09/15.
 */
@Controller
@RequestMapping("/DicJgdmTz")
public class DicJgdmTzController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    private DicJgdmTzService dicJgdmTzService;

    @RequestMapping(value = "/getRandPass")
    public void getRandPass( String  jgdm,HttpServletRequest request,
                             HttpServletResponse response) throws Exception {
        String result;

        try {
            DicJgdmTzEntity dicJgdmTzEntity = dicJgdmTzService.findByJgdm(jgdm);

            String base = "0123456789abcdefghijklmnopqrstuvwxyz0123456789";
            Random random = new Random();
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < 6; i++) {
                int number = random.nextInt(base.length());
                sb.append(base.charAt(number));
            }
            if(dicJgdmTzEntity==null){
                dicJgdmTzEntity = new DicJgdmTzEntity();
                dicJgdmTzEntity.setDm(jgdm);
            }

            dicJgdmTzEntity.setRandPass( sb.toString());
            dicJgdmTzService.save(dicJgdmTzEntity);
            result = "{\"success\":true,\"msg\":\"密码生成成功！\"}";
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行" + this.getClass().getName() + ".deleteUserInfo() 方法失败 】异常：" + ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

    @RequestMapping(value = "/getMenuRole")
    public void getMenuRole( String  jgdm,HttpServletRequest request,
                             HttpServletResponse response) throws Exception {
        String result;

        try {
            DicJgdmTzEntity dicJgdmTzEntity = dicJgdmTzService.findByJgdm(jgdm);

            if(dicJgdmTzEntity==null){
                dicJgdmTzEntity = new DicJgdmTzEntity();
                dicJgdmTzEntity.setDm(jgdm);
            }
            if(dicJgdmTzEntity.getMenuRole()!=null&&dicJgdmTzEntity.getMenuRole()){
                dicJgdmTzEntity.setMenuRole(false);
            }else{
                dicJgdmTzEntity.setMenuRole(true);
            }
            dicJgdmTzService.save(dicJgdmTzEntity);
            result = "{\"success\":true,\"msg\":\"密码生成成功！\"}";
        } catch (Exception ex) {
            result = "{\"success\":false,\"msg\":\"系统错误，请稍候再试！\"}";
            logger.error("【执行" + this.getClass().getName() + ".deleteUserInfo() 方法失败 】异常：" + ex.getMessage());
        }
        StringUtil.writeToWeb(result, "html", response);
    }

}
