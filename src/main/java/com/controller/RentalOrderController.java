package com.controller;

import java.time.LocalDate;
import java.util.Date;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.service.MemService;
import com.service.RentalOrderService;
import com.entity.RentalOrder;
import com.entity.Mem;



@Controller
@RequestMapping("/rental")
public class RentalOrderController {

	@Autowired
	RentalOrderService rentalOrderSvc;

	@Autowired
	MemService memSvc;

	@GetMapping("/select")
	public String select_page(Model model) {
		return "back_end/rental/selectRentalOrder";
	}

	@PostMapping("getOne_For_Display")
	public String getOne_For_Display(@RequestParam("rentalId") Integer rentalId, Model model) {
		RentalOrder rentalOrder = rentalOrderSvc.getRentalOrderById(rentalId);
		model.addAttribute("rentalOrder", rentalOrder);
		return "back_end/rental/listOneRentalOrder";
	}

	@PostMapping("listRentalOrders_ByCompositeQuery")
	public String listAllRentalOrder(HttpServletRequest req, Model model) {
		Map<String, String[]> map = req.getParameterMap();
		List<RentalOrder> list = rentalOrderSvc.getAllRentalOrder(map);
		List<RentalOrder> list2 = rentalOrderSvc.getAllRentalOrder();
		model.addAttribute("AllRentalOrderListData", list2);
		if (list.isEmpty()) {
			model.addAttribute("errorMsgs", "查無相關資料");
			return "back_end/rental/selectRentalOrder";
		} else {
			model.addAttribute("AllRentalOrderListData", list);
			return "back_end/rental/listAllRentalOrder";
		}
	}

	@GetMapping("/listAllRentalOrder")
	public String listAllRentalOrder(Model model) {
		return "back_end/rental/listAllRentalOrder";
	}

	@ModelAttribute("AllRentalOrderListData")
	protected List<RentalOrder> referenceListData(Model model) {

		List<RentalOrder> list = rentalOrderSvc.getAllRentalOrder();
		return list;
	}

	@GetMapping("get_RentalOrder_For_Review")
	public String getRentalOrderForReview(Model model) {
		List<RentalOrder> rentalOrderForR = new ArrayList<>();
		rentalOrderForR.addAll(rentalOrderSvc.getRentalOrderByResult("審核中"));

		List<RentalOrder> list = rentalOrderSvc.getAllRentalOrder();
		model.addAttribute("AllRentalOrderListData", list);

		if (rentalOrderForR.isEmpty()) {
			model.addAttribute("errorMsgs", "查無相關資料");
			return "back_end/rental/selectRentalOrder";
		} else {
			model.addAttribute("listAllRentalOrder", rentalOrderForR);
			return "back_end/rental/listAllRentalOrder";
		}
	}

	@PostMapping("getOne_For_Update")
	public String getOne_For_Update(@RequestParam("rentalId") Integer rentalId, Model model) {
		RentalOrder rentalOrder = rentalOrderSvc.getRentalOrderById(rentalId);
		model.addAttribute("rentalOrder", rentalOrder);
		return "back_end/rental/update_rental";
	}

	@PostMapping("update")
	public String update(RentalOrder rentalOrder, BindingResult result, Model model) {
		if (result.hasErrors()) {
			model.addAttribute("errorMsgs", result.getAllErrors());
			return "back_end/rental/update_rental";
		}

		rentalOrderSvc.updateRentalOrder(rentalOrder);
		;

		model.addAttribute("successMsgs", "- (修改成功)");
		model.addAttribute("rentalOrder", rentalOrder);
		return "back_end/rental/listOneRentalOrder";
	}

	// ===========FrontEnd==============================
	@GetMapping("f/RentalOrder_For_M")
	public String getRentalOrderByMem(Model model, HttpSession session) {
		Mem mem = (Mem) session.getAttribute("loginSuccess");
		List<RentalOrder> rentalOrders = rentalOrderSvc.getRentalOrderByMemId(mem.getMemId());

		if (rentalOrders.isEmpty()) {
			model.addAttribute("errorMsgs", "查無相關資料");
			model.asMap().remove("AllRentalOrderListData");
			return "front_end/rental/listAllRentalOrderM";
		} else {
			model.addAttribute("AllRentalOrderListData", rentalOrders);
			return "front_end/rental/listAllRentalOrderM";
		}
	}

	@PostMapping("cancel")
	public String cancelRentalOrder(@RequestParam Integer rentalId, Model model, HttpSession session) {
		RentalOrder rentalOrder = rentalOrderSvc.getRentalOrderById(rentalId);
		rentalOrder.setResult("取消訂單");
		rentalOrderSvc.updateRentalOrder(rentalOrder);

		Mem mem = (Mem) session.getAttribute("loginSuccess");
		List<RentalOrder> rentalOrders = rentalOrderSvc.getRentalOrderByMemId(mem.getMemId());
		model.addAttribute("AllRentalOrderListData", rentalOrders);
		
		return "front_end/rental/listAllRentalOrderM";
	}
	@PostMapping("goToPayment")
	public String goToPaymen(@RequestParam Integer rentalId, Model model, HttpSession session) {
		RentalOrder rentalOrder = rentalOrderSvc.getRentalOrderById(rentalId);
		rentalOrder.setPaymentStatus("已付");
		rentalOrderSvc.updateRentalOrder(rentalOrder);

		Mem mem = (Mem) session.getAttribute("loginSuccess");
		List<RentalOrder> rentalOrders = rentalOrderSvc.getRentalOrderByMemId(mem.getMemId());
		model.addAttribute("AllRentalOrderListData", rentalOrders);
		
		return "front_end/rental/listAllRentalOrderM";
	}
//=======================================	

	@GetMapping("f/addRentalOrder")
	public String addRentalOrder(ModelMap model, HttpSession session) {
		RentalOrder rentalOrder = new RentalOrder();

		Mem mem = (Mem) session.getAttribute("loginSuccess");
		rentalOrder.setMem(memSvc.getMemById(mem.getMemId()));

		Date today = new Date();
		rentalOrder.setApplyDate(today);

		rentalOrder.setResult("審核中");
		rentalOrder.setPaymentStatus("未付");
		rentalOrder.setDepositRefund("未退");

		model.addAttribute("rentalOrder", rentalOrder);
		return "front_end/rental/addRentalOrder";
	}

	@PostMapping("insert")
	public String insert(@Valid RentalOrder rentalOrder, BindingResult result, Model model, HttpSession session) {
		if (result.hasErrors()) {
			model.addAttribute("rentalOrder", rentalOrder);
			model.addAttribute("errorMsgs", result.getAllErrors());
			return "front_end/rental/addRentalOrder";
		}

		rentalOrderSvc.addRentalOrder(rentalOrder);
		model.addAttribute("rentalOrder", rentalOrder);
		model.addAttribute("successMsgs", "- (填寫成功)");

		Mem mem = (Mem) session.getAttribute("loginSuccess");
		List<RentalOrder> rentalOrders = rentalOrderSvc.getRentalOrderByMemId(mem.getMemId());
		model.addAttribute("AllRentalOrderListData", rentalOrders);
		return "front_end/rental/listAllRentalOrderM";
	}

	// ===============================================================
	@GetMapping("/listAllRentalOrderF")
	public String listAllRentalOrderF(HttpServletRequest req, Model model) {
		Map<String, String[]> map = new HashMap<>(req.getParameterMap());

		LocalDate today = LocalDate.now();
		String todayString = today.toString();
		map.put("startdate", new String[] { todayString });
		List<RentalOrder> list = rentalOrderSvc.getAllRentalOrder(map);

		
		Collections.sort(list, Comparator.comparing(RentalOrder::getRentalDate));

		if (list.isEmpty()) {
			model.addAttribute("errorMsgs", "查無相關資料");
			return "front_end/rental/listAllRentalOrderF";
		} else {
			model.addAttribute("AllRentalOrderListData", list);
			return "front_end/rental/listAllRentalOrderF";
		}

	}

}

//=========================================================================================================
@RestController
class RentalOrderControllerR {

	@Autowired
	RentalOrderService rentalOrderSvc;

	@GetMapping("/getPriceAndDeposit")
	public Map<String, Integer> getPriceAndDeposit(@RequestParam String screenId) {
		Map<String, Integer> priceAndDeposit = new HashMap<>();

		if (screenId.equals("A廳")) {
			priceAndDeposit.put("price", 30000);
			priceAndDeposit.put("deposit", 30000);
			priceAndDeposit.put("total", 60000);
		} else if (screenId.equals("B廳")) {
			priceAndDeposit.put("price", 20000);
			priceAndDeposit.put("deposit", 20000);
			priceAndDeposit.put("total", 40000);
		} else if (screenId.equals("C廳")) {
			priceAndDeposit.put("price", 32000);
			priceAndDeposit.put("deposit", 32000);
			priceAndDeposit.put("total", 64000);
		} else if (screenId.equals("D廳")) {
			priceAndDeposit.put("price", 45000);
			priceAndDeposit.put("deposit", 45000);
			priceAndDeposit.put("total", 90000);
		}

		return priceAndDeposit;

	}
}
