package com.controller;


import com.entity.Emp;
import com.entity.Job;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.service.EmpService;
import com.service.JobService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.*;

@Controller
@RequestMapping("/emp")
public class EmpController {

    @Autowired
    EmpService empService;

    @Autowired
    JobService jobService;


    @GetMapping("toLogin")
    public String toLogin() {
        return "back_end/emp/login";
    }

    @PostMapping("/doLogin")
    public String login(@RequestParam(name = "username") Integer empId, @RequestParam(name = "password") String empPassword, Model model, HttpServletResponse response) throws IOException {

        if (empService.login(empId, empPassword)) {
            Cookie loginInfo = new Cookie("loginAlready", "true");
            loginInfo.setPath("/");
            response.addCookie(loginInfo);
            return "redirect:/emp/index";
        }
        return "redirect:/emp/toLogin";
    }

    @GetMapping("index")
    public String index() {
        return "management";
    }

    @PostMapping("/addEmp")
    public String addEmp(Model model) {

        Emp emp = new Emp();
        Job job = new Job();
        model.addAttribute("emp",emp);
        model.addAttribute("job",job);
        return "back_end/emp/addEmp";

    }

    @GetMapping("/addEmp")
    public String getEmp(Model model) {

        Emp emp = new Emp();
        Job job = new Job();
        model.addAttribute("emp",emp);
        model.addAttribute("job",job);
        return "back_end/emp/addEmp";

    }

    @PostMapping("/insertEmp")
    public String insertEmp(@Valid Emp emp, Model model) {

        empService.addEmp(emp);
        List<Emp> list = empService.getAll();
        model.addAttribute("empListDate", list);
        model.addAttribute("success", "新增成功");
        return "back_end/emp/listAllEmp";

    }

//    @PostMapping("/getbyId")
//    public String getbyId(@RequestParam("empId") Integer empId, Model model) {
//
//        EmpVO empVO = empService.getbyId(Integer.valueOf(empId));
//        model.addAttribute("EmpVO", empVO);
//        return "updateEmp";
//    }

    @PostMapping("getOne_For_Update")
    public String getOne_For_Update(@RequestParam("empId") String empId, ModelMap model) {

        // EmpService empSvc = new EmpService();
        Emp emp = empService.getbyId(Integer.valueOf(empId));
        model.addAttribute("emp", emp);
        return "back_end/emp/updateEmp"; // 查詢完成後轉交update_emp_input.html
    }


    @GetMapping("/toupdateEmp")
    public String updateEmp() {
        return "back_end/emp/updateEmp";
    }
    //ModelMap model
    @PostMapping("updateEmp")
    public String update(@Valid Emp emp)  {

        emp = empService.getbyId(Integer.valueOf(emp.getEmpId()));
        // EmpService empSvc = new EmpService();
        empService.updateEmp(emp);
//        model.addAttribute("success", "修改成功");

//        model.addAttribute("empVO", empVO);
        return  "back_end/emp/updateEmp"; // 修改成功後轉交listOneEmp.html
    }


    @PostMapping("/deleteEmp")
    public String deleteEmp(@RequestParam("empId") Integer empId, Model model) {
        empService.deleteEmp(Integer.valueOf(empId));
        List<Emp> list = empService.getAll();
        model.addAttribute("empListData", list);
        model.addAttribute("success", "刪除成功");
        return "back_end/emp/listAllEmp";
    }

//    @PostMapping("HUComposite")
//    public String listAllEmp(HttpServletRequest req, Model model) {
//        Map<String, String[]> map = req.getParameterMap();
//        List<EmpVO> list = empService.getAll();
//        model.addAttribute("empListData", list); // for listAllEmp.html 第85行用
//        return "listAllEmp";
//    }

    /*
     * 第一種作法 Method used to populate the List Data in view. 如 :
     * <form:select path="deptno" id="deptno" items="${deptListData}" itemValue="deptno" itemLabel="dname" />
     */
    @ModelAttribute("jobListData")
    protected List<Job> referenceListData() {
        // DeptService deptSvc = new DeptService();
        List<Job> list = jobService.getAll();
        return list;
    }

    /*
     * 【 第二種作法 】 Method used to populate the Map Data in view. 如 :
     * <form:select path="deptno" id="deptno" items="${depMapData}" />
     */
    @ModelAttribute("jobMapData") //
    protected Map<Integer, String> referenceMapData() {
        Map<Integer, String> map = new LinkedHashMap<Integer, String>();
        map.put(1, "主管");
        map.put(2, "辦公職員");
        map.put(3, "售票人員");
        map.put(4, "客服人員");
        return map;
    }

    // 去除BindingResult中某個欄位的FieldError紀錄
//    public BindingResult removeFieldError(EmpVO empVO, BindingResult result, String removedFieldname) {
//        List<FieldError> errorsListToKeep = result.getFieldErrors().stream()
//                .filter(fieldname -> !fieldname.getField().equals(removedFieldname))
//                .collect(Collectors.toList());
//        result = new BeanPropertyBindingResult(empVO, "empVO");
//        for (FieldError fieldError : errorsListToKeep) {
//            result.addError(fieldError);
//        }
//        return result;
//    }

    /*
     * This method will be called on select_page.html form submission, handling POST request
     */
    @PostMapping("listEmps_ByCompositeQuery")
    public String listAllEmp(HttpServletRequest req, Model model) {
        Map<String, String[]> map = req.getParameterMap();
        List<Emp> list = empService.getAll();
        model.addAttribute("empListData", list); // for listAllEmp.html 第85行用
        return "back_end/emp/listAllEmp";
    }

    @ResponseBody
    @GetMapping("applyResetPassword")
    public String applyResetPassword(@RequestParam Integer empId,@RequestParam String email) throws JsonProcessingException, UnsupportedEncodingException {
        return empService.resetPassword(empId, email);
    }

    @GetMapping("resetPasswordLink")
    public String resetPasswordLink(@RequestParam String param, RedirectAttributes redirectAttributes) throws JsonProcessingException {
        //todo 解碼

        //判斷是不是過期
        ObjectMapper objectMapper = new ObjectMapper();
        // 將JSON字符串轉換為Java對象
        Map<String, Object> map = objectMapper.readValue(param, HashMap.class);
        Integer empId = (Integer) map.get("empId");
        Long expired = (Long) map.get("expired");
        Date expiredDate = new Date(expired);
        boolean isExpired = (new Date()).after(expiredDate);
        if (isExpired) {
            //todo 將error取代為設計好的頁面名稱
            return "error";
        }// 將參數添加到重定向URL中
        redirectAttributes.addAttribute("empId", empId);
        redirectAttributes.addAttribute("expired", expired);

        return "redirect:/resetPasswordPage"; // 重定向到resetPasswordPage頁面
    }

    @GetMapping("/resetPasswordPage")
    public String resetPasswordPage(@RequestParam Integer empId, @RequestParam Long expired, Model model) {
        // 在這個方法中，你可以使用 empId 和 Expired 這兩個參數進行相關處理
        // 將需要的數據放入Model中，進行視圖渲染
        model.addAttribute("empId", empId);
        model.addAttribute("expired", expired);
        return "resetPasswordPage"; // 返回 resetPasswordPage 頁面
    }

    @GetMapping("doResetPassword")
    @ResponseBody
    public String doResetPassword(@RequestParam Integer empId, @RequestParam String password, @RequestParam String cPassword) {

        try {
            if (!password.equals(cPassword)) {
                throw new Exception();
            }
            Emp emp = empService.getbyId(empId);
            emp.setEmpPassword(password);
            empService.updateEmp(emp);
            return "修改好了";
        } catch (Exception e) {
            return "啊失敗了";
        }
    }

    @GetMapping("select_page")
    public String select_page(Model model) {
        List<Emp> empList = empService.getAll();
        List<Job> jobList = jobService.getAll();
        model.addAttribute("empListData", empList);
        model.addAttribute("jobListData", jobList); // 添加jobListData到模型中
        model.addAttribute("getOne_For_Display","false");
        return "back_end/emp/select_page";
    }


    @GetMapping("/listAllEmp")
    public String listAllEmp(Model model) {
        List<Emp> empList = empService.getAll();
        List<Job> jobList = jobService.getAll();
        model.addAttribute("empListData", empList);
        model.addAttribute("jobListData", jobList); // 添加jobListData到模型中
        return "back_end/emp/listAllEmp";
    }
    @ModelAttribute("empListData")  // for select_page.html 第97 109行用 // for listAllEmp.html 第85行用
    protected List<Emp> referenceListData(Model model) {

        List<Emp> list = empService.getAll();
        return list;
    }

    @ModelAttribute("jobListData") // for select_page.html 第135行用
    protected List<Job> referenceListData_Job(Model model) {
        model.addAttribute("job", new Job()); // for select_page.html 第133行用
        return jobService.getAll();
    }





}






