package com.controller;

import com.entity.Emp;
import com.entity.Job;
import com.service.EmpService;
import com.service.JobService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import javax.validation.constraints.Digits;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotEmpty;
import java.util.List;
import java.util.Set;

@Controller
@Validated
@RequestMapping("/emp")
public class EmpIdController {

    @Autowired
    EmpService empService;

    @Autowired
    JobService jobService;

    /*
     * This method will be called on select_page.html form submission, handling POST
     * request It also validates the user input
     */
    @PostMapping("getOne_For_Display")
    public String getOne_For_Display(
            /***************************1.接收請求參數 - 輸入格式的錯誤處理*************************/
            @NotEmpty(message="員工編號: 請勿空白")
            @Digits(integer = 4, fraction = 0, message = "員工編號: 請填數字-請勿超過{integer}位數")
            @Min(value = 7001, message = "員工編號: 不能小於{value}")
            @Max(value = 7777, message = "員工編號: 不能超過{value}")
            @RequestParam("empId") String empId,
            ModelMap model) {

        /***************************2.開始查詢資料*********************************************/
//		EmpService empSvc = new EmpService();
        Emp emp = empService.getbyId(Integer.valueOf(empId));

        List<Emp> list = empService.getAll();
        model.addAttribute("empListData", list);     // for select_page.html 第97 109行用
        model.addAttribute("jobVO", new Job());  // for select_page.html 第133行用
        List<Job> list2 = jobService.getAll();
        model.addAttribute("jobListData",list2);    // for select_page.html 第135行用

        if (emp == null) {
            model.addAttribute("errorMessage", "查無資料");
            return "back_end/emp/select_page";
        }

        /***************************3.查詢完成,準備轉交(Send the Success view)*****************/
        model.addAttribute("emp", emp);
        model.addAttribute("getOne_For_Display", "true"); // 旗標getOne_For_Display見select_page.html的第156行 -->

//		return "back-end/emp/listOneEmp";  // 查詢完成後轉交listOneEmp.html
        return "back_end/emp/select_page"; // 查詢完成後轉交select_page.html由其第158行insert listOneEmp.html內的th:fragment="listOneEmp-div
    }

    @ExceptionHandler(value = { ConstraintViolationException.class })
    //@ResponseStatus(value = HttpStatus.BAD_REQUEST)
    public ModelAndView handleError(HttpServletRequest req, ConstraintViolationException e, Model model) {
        Set<ConstraintViolation<?>> violations = e.getConstraintViolations();
        StringBuilder strBuilder = new StringBuilder();
        for (ConstraintViolation<?> violation : violations ) {
            strBuilder.append(violation.getMessage() + "<br>");
        }
        //==== 以下第92~96行是當前面第77行返回 /src/main/resources/templates/back-end/emp/select_page.html用的 ====
//	    model.addAttribute("empVO", new EmpVO());
//    	EmpService empSvc = new EmpService();
        List<Emp> list = empService.getAll();
        model.addAttribute("empListData", list);     // for select_page.html 第97 109行用
        model.addAttribute("job", new Job());  // for select_page.html 第133行用
        List<Job> list2 = jobService.getAll();
        model.addAttribute("jobListData",list2);    // for select_page.html 第135行用
        String message = strBuilder.toString();
        return new ModelAndView("back_end/emp/select_page", "errorMessage", "請修正以下錯誤:<br>"+message);
    }

}
