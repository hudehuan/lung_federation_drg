package com.dldata.drgs.controller.pages;

import com.dldata.drgs.entity.SysDictionaryEntity;
import com.dldata.drgs.entity.SysDictionaryItemEntity;
import com.dldata.drgs.service.System.SysDictionaryItemService;
import com.dldata.drgs.service.System.SysDictionaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by 吴岳峰 on 2017/5/19.
 */
@Controller
@RequestMapping(value = "/V_SysDictionaryItem")
public class V_SysDictionaryItemController {

    @Autowired
    SysDictionaryItemService dictionaryItemService;
    @Autowired
    SysDictionaryService dictionaryService;


    @RequestMapping(value = "/toEdit")
    public String toEdit(String did,String itemId,Model model) {
        SysDictionaryEntity dic = dictionaryService.findOne(did);
        model.addAttribute("did",dic.getDid());
        model.addAttribute("dicName",dic.getDicName());
        if(itemId != null){
            SysDictionaryItemEntity dicItem = dictionaryItemService.findOne(itemId);
            if (dicItem != null) {
                model.addAttribute("dicItem",dicItem);
            }
        }
        return "System/SysDictionaryItemEdit";
    }
}
