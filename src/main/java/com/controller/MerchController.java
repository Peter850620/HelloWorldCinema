package com.controller;


import com.entity.Merch;
import com.service.MerchService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@Controller
@RequestMapping("/merch")
@Component
public class MerchController {

    @Autowired
    MerchService merchService10;

    @GetMapping("/merchId/{id}")
    public String showProductPage(@PathVariable Integer id, Model model) {
        Merch merch = merchService10.getbyMerchId(id);
        model.addAttribute("merch", merch);
        return "front_end/TestSingleMerch"; // 返回單獨商品頁面的HTML文件名
    }

    @GetMapping("/front")
    public String front() {
        return "front_end/TestMerchStore";
    }

    @GetMapping("/frontsingle")
    public String frontsingle() {
        return "front_end/TestSingleMerch";
    }

    @PostMapping("/toggleMerchStatus")
    public String toggleMerchStatus(@Valid Merch merchVo) {

        Merch merch = merchService10.getbyMerchId(merchVo.getMerchId());
        String text = "上架";
        if (merch.getMerchStatus().equals("上架")) {
            text = "下架";
        }
        merch.setMerchStatus(text);
        merchService10.updateMerch(merch);
        return "redirect:/merch/listAllMerch";
    }


    @PostMapping("/addMerch")
    public String addMerch(Model model) {

        Merch merch = new Merch();
        model.addAttribute(merch);
        return "addMerch";
    }

    @PostMapping("/insertMerch")
    public String insert(@Valid Merch merch, Model model) {
        merchService10.addMerch(merch);
        List<Merch> list = merchService10.getAll();
        model.addAttribute("merchListDate", list);
        model.addAttribute("success", "修改成功");
        return "back_end/listAllMerch";

    }

    @PostMapping("/getbyMerchId")
    public String getbyMerchId(@RequestParam("merchId") Integer merchId, Model model) {
        Merch merch = merchService10.getbyMerchId(merchId);
        model.addAttribute("Merch", merch);
        return "front_end/TestSingleMerch";

    }

    @PostMapping("/updateMerch")
    public String updateMerch(@Valid Merch merch, Model model) {

        merchService10.updateMerch(merch);
        model.addAttribute("success", "修改成功");
        merch = merchService10.getbyMerchId(Integer.valueOf(merch.getMerchId()));
        return "getbyMerchId";

    }

    @PostMapping("/deleteMerch")
    public String deleteMerch(@RequestParam("merchId") Integer merchId, Model model) {
        merchService10.deleteMerch(merchId);
        List<Merch> list = merchService10.getAll();
        model.addAttribute("merchListDate", list);
        model.addAttribute("success", "刪除成功");
        return "back_end/listAllMerch";


    }

    @GetMapping("/listAllMerch")
    public String listAllMerch(Model model) {
        List<Merch> merchList = merchService10.getAll();
        model.addAttribute("merchListData", merchList);
        return "back_end/listAllMerch";
    }

    @ModelAttribute("merchListData")  // for select_page.html 第97 109行用 // for listAllEmp.html 第85行用
    protected List<Merch> referenceListData(Model model) {

        List<Merch> list = merchService10.getAll();
        return list;
    }

    @PostMapping("/getbyMerchStatus")
    public String MerchStatus(Model model){
        List<Merch> merchlist = merchService10.getbyMerchStatus("上架");
        model.addAttribute("merchStatusList",merchlist);
        return "front_end/TestMerchStore";
    }


}
