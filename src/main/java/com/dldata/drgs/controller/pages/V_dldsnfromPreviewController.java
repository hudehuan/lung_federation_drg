package com.dldata.drgs.controller.pages;


import com.dldata.drgs.entity.CustomFormFieldTemplateEntity;
import com.dldata.drgs.entity.CustomFormTemplateEntity;
import com.dldata.drgs.service.customform.CustomFormFieldTemplateService;
import com.dldata.drgs.service.customform.CustomFormTemplateService;
import net.sf.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 周鹏飞 on 2017/5/20.
 */

@Controller
@RequestMapping(value = "/v_DldsnformPreview")
public class V_dldsnfromPreviewController {


    @Autowired
    private CustomFormFieldTemplateService CustomFormFieldTemplateService;

    @Autowired
    private CustomFormTemplateService CustomFormTemplateService;


    @RequestMapping(value = "/toDldsnformPreview")

    public String toDldsnformPreview(String templateId, Model model){
        List<CustomFormFieldTemplateEntity> tempfieldlist = CustomFormFieldTemplateService.getAllByTemplateId(templateId);
        CustomFormTemplateEntity tempfrom = CustomFormTemplateService.getTemplateById(templateId);


      //  List<CustomFormFieldEntity> fieldlist = CustomFormFieldService.getAllFieldByFormId(tempfieldlist.get(0).getFormId());

        List<Map<String,String>> mapList = new ArrayList<Map<String,String>>();
        tempfieldlist.forEach(
                (p) -> {
                    Map<String, String> tmpmap = new HashMap<String, String>();
                    tmpmap.put("fieldCode", p.getFieldCode());
                    tmpmap.put("controlType", p.getControlType());
                    if (p.getdataSql().toLowerCase().indexOf("select")>-1 && p.getdataSql().toLowerCase().indexOf("from") >-1)
                    {
                        if (p.getdataSql().split("\\|").length>1)//有联动配置
                            tmpmap.put("dataSql", "(sql)"+p.getdataSql().split("\\|")[1]);
                        else
                            tmpmap.put("dataSql", "(sql)");
                    }
                    else
                       tmpmap.put("dataSql", p.getdataSql());
                    tmpmap.put("vcljs", p.getJs()); //这里有可能json数据报错，

                    mapList.add(tmpmap);
                }
        );

        if (mapList.size()>0)
        model.addAttribute("vcljson", JSONArray.fromObject(mapList).toString());
        tempfrom.getHtml();
        model.addAttribute("tempdata", tempfrom);

        return "customform/v_dldsnformPreview";
    }




}
