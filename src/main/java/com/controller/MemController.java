package com.controller;

import java.util.Properties;
import java.util.concurrent.TimeUnit;
import java.util.ArrayList;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
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
import com.entity.Mem;

import redis.clients.jedis.Jedis;

@Controller
@RequestMapping("/mem")
public class MemController {

	@Autowired
	MemService memSvc;

	//
	@GetMapping("addMem")
	public String addMem(ModelMap model) {
		Mem mem = new Mem();
		model.addAttribute("mem", mem);
		return "back_end/mem/addMem";
	}

	@PostMapping("insert")
	public String insert(@Valid Mem mem, BindingResult result, Model model) {
		if (result.hasErrors()) {
			model.addAttribute("mem", mem);
			model.addAttribute("errorMsgs", result.getAllErrors());
			return "back_end/mem/addMem";
		}
		Mem existingMemE = memSvc.getMemByEmail(mem.getMemEmail());
		Mem existingMemA = memSvc.getMemByAccount(mem.getMemAcount());

		if (existingMemE != null) {
			model.addAttribute("errorMsg", "已存在之會員信箱");
			return "back_end/mem/addMem";
		} else if (existingMemA != null) {
			model.addAttribute("errorMsg", "已存在之會員帳號");
			return "back_end/mem/addMem";
		}
		memSvc.addMem(mem);
		model.addAttribute("mem", mem);
		model.addAttribute("successMsgs", "- (新增成功)");
		return "back_end/mem/listOneMem";
	}

	@PostMapping("getOne_For_Update")
	public String getOne_For_Update(@RequestParam("memId") Integer memId, Model model) {
		Mem mem = memSvc.getMemById(memId);
		model.addAttribute("mem", mem);
		return "back_end/mem/updateMem";
	}

	@PostMapping("update")
	public String update(@Valid Mem mem, BindingResult result, Model model) {
		if (result.hasErrors()) {
			model.addAttribute("errorMsgs", result.getAllErrors());
			return "back_end/mem/updateMem";
		}

		Mem existingMem = memSvc.getMemByEmail(mem.getMemEmail());
		if (existingMem != null && !existingMem.getMemId().equals(mem.getMemId())) {
			model.addAttribute("errorMsg", "已存在之會員信箱");
			return "back_end/mem/updateMem";
		}

		memSvc.updateMem(mem);

		model.addAttribute("successMsgs", "- (修改成功)");
		model.addAttribute("mem", mem);
		return "back_end/mem/listOneMem";
	}

	@PostMapping("listMems_ByCompositeQuery")
	public String listAllMem(HttpServletRequest req, Model model) {
		Map<String, String[]> map = req.getParameterMap();
		List<Mem> list = memSvc.getAllMem(map);
		List<Mem> list2 = memSvc.getAllMem();
		model.addAttribute("AllMemListData", list2);
		if (list.isEmpty()) {
			model.addAttribute("errorMsgs", "查無相關資料");
			return "back_end/mem/select";
		} else {
			model.addAttribute("AllMemListData", list);
			return "back_end/mem/listAllMem";
		}
	}

	@PostMapping("getOne_For_Display")
	public String getOne_For_Display(@RequestParam("memId") Integer memId, Model model) {
		Mem mem = memSvc.getMemById(memId);
		model.addAttribute("mem", mem);
		return "back_end/mem/listOneMem";
	}

	@GetMapping("get_SuspendedMem")
	public String suspendedMem_Display(Model model) {

		List<Mem> suspendedMem = new ArrayList<>();
		suspendedMem.addAll(memSvc.getMemByStatus("已停權"));
		suspendedMem.addAll(memSvc.getMemByStatus("已註銷"));

		List<Mem> list2 = memSvc.getAllMem();
		model.addAttribute("AllMemListData", list2);
		if (suspendedMem.isEmpty()) {
			model.addAttribute("errorMsgs", "查無相關資料");
			return "back_end/mem/select";
		} else {
			model.addAttribute("AllMemListData", suspendedMem);
			return "back_end/mem/listAllMem";
		}
	}

	@GetMapping("/select")
	public String select_page(Model model) {
		return "back_end/mem/select";
	}

	@GetMapping("/listAllMem")
	public String listAllMem(Model model) {
		return "back_end/mem/listAllMem";
	}

	@ModelAttribute("AllMemListData")
	protected List<Mem> referenceListData(Model model) {

		List<Mem> list = memSvc.getAllMem();
		return list;
	}
//========FrontEnd===========================================================================

	@GetMapping("/login")
	public String login(Model model) {
		return "front_end/mem/mem_login";
	}

	@PostMapping("memLogin")
	public String loginMem(@RequestParam("memAcount") String memAcount, @RequestParam("memPassword") String memPassword,
			Model model, HttpSession session) {

		Mem mem = memSvc.getMemByAccount(memAcount);

		if (mem != null && mem.getMemPassword().equals(memPassword)) {
			if (mem.getMemStatus().equals("已驗證")) {
				session.setAttribute("loginSuccess", mem);
				return "front_end/mem/mem_Index";
			} else if (mem.getMemStatus().equals("已停權") || mem.getMemStatus().equals("已註銷")) {
				model.addAttribute("errorMsgs", "無使用權限，詳情請洽客服");
				return "front_end/mem/mem_login";
			} else {
				model.addAttribute("errorMsgs", "帳號尚未完成驗證"); //
				return "front_end/mem/mem_login";
			}
		} else {
			model.addAttribute("errorMsgs", "會員帳號或密碼錯誤");
			return "front_end/mem/mem_login";
		}
	}

	@GetMapping("/logout")
	public String logout(Model model, HttpSession session) {
		session.removeAttribute("loginSuccess");
		return "front_end/mem/mem_login";
	}

	// =========================================================================================
	@GetMapping("memUpdateF")
	public String updateMemF(Model model, HttpSession session) {
		Mem mem = (Mem) session.getAttribute("loginSuccess");
		model.addAttribute("mem", mem);
		return "front_end/mem/updateMemF";
	}

	@PostMapping("updateF")
	public String updateF(@Valid Mem mem, BindingResult result, Model model, HttpSession session) {
		if (result.hasErrors()) {
			model.addAttribute("errorMsgs", result.getAllErrors());
			return "front_end/mem/updateMemF";
		}

		Mem existingMem = memSvc.getMemByEmail(mem.getMemEmail());
		if (existingMem != null && !existingMem.getMemId().equals(mem.getMemId())) {
			model.addAttribute("errorMsg", "已存在之會員信箱");
			return "front_end/mem/updateMemF";
		}

		memSvc.updateMem(mem);

		model.addAttribute("successMsgs", "- (修改成功)");
		model.addAttribute("mem", mem);
		session.setAttribute("loginSuccess", mem);
		return "front_end/mem/updateMemF";
	}

	// ===================================
	@GetMapping("memIndexF")
	public String memIndexF(Model model, HttpSession session) {
		Mem mem = (Mem) session.getAttribute("loginSuccess");
		model.addAttribute("mem", mem);
		return "/front_end/mem/mem_Index";
	}
	
	//=============================================
	@GetMapping("/signup")
	public String signupMem(Model model) {
		Mem mem = new Mem();
		mem.setMemStatus("未驗證");
		model.addAttribute("mem", mem);
		return "front_end/mem/mem_signup";
	}

	@PostMapping("memSignUp")
	public String signup(@Valid Mem mem, BindingResult result, Model model) {

		if (result.hasErrors()) {
			model.addAttribute("mem", mem);
			model.addAttribute("errorMsgs", result.getAllErrors());
			return "front_end/mem/mem_signup";
		}
		Mem existingMemE = memSvc.getMemByEmail(mem.getMemEmail());
		Mem existingMemA = memSvc.getMemByAccount(mem.getMemAcount());

		if (existingMemE != null) {

			return "front_end/mem/mem_signup";
		} else if (existingMemA != null) {

			return "front_end/mem/mem_signup";
		}
		memSvc.addMem(mem);
		model.addAttribute("memEmail", mem.getMemEmail());
		return "front_end/mem/mem_verification";
	}

	// =====================================================

	private Jedis jedis = null;

	@PostMapping("/sendVCode")
	public String sendVerificationCode(@RequestParam("memEmail") String memEmail, Model model) {
		String randomCode = RandomCode();
		String subject = "會員註冊驗證";
		String text = "您的驗證碼是：" + randomCode;

		jedis = new Jedis("localhost", 6379);
		jedis.select(11);
		if (sendEmail(memEmail, subject, text)) {
			jedis.set(memEmail, randomCode);
			jedis.expire(memEmail, 600);
			model.addAttribute("errorMsgs", "驗證碼已寄出");
			model.addAttribute("memEmail", memEmail);
			return "front_end/mem/mem_verification";
		} else {
			model.addAttribute("errorMsgs", "驗證碼寄送失敗");
			model.addAttribute("memEmail", memEmail);
			return "front_end/mem/mem_verification";
		}
	}

	@PostMapping("/VerifyCode")
	public String registerMember(@RequestParam("memEmail") String memEmail, @RequestParam("inputCode") String inputCode, Model model) {
		String randomCode = jedis.get(memEmail);
		
		
		if(inputCode == null || inputCode.isEmpty()) {
			model.addAttribute("errorMsgs", "請輸入驗證碼");
			model.addAttribute("memEmail", memEmail);
			return "front_end/mem/mem_verification";
		}
		if (randomCode != null && randomCode.equals(inputCode)) {
			 Mem mem = memSvc.getMemByEmail(memEmail);
			 mem.setMemStatus("已驗證");
			 memSvc.updateMem(mem);
			 model.addAttribute("errorMsgs", "驗證碼已完成，請登入會員");
				return "front_end/mem/mem_login";
		} else {
			model.addAttribute("errorMsgs", "驗證失敗");
			model.addAttribute("memEmail", memEmail);
			return "front_end/mem/mem_verification";
		}
	}



	private String RandomCode() {

		StringBuilder sb = new StringBuilder();
		String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
		for (int i = 0; i < 6; i++) {
			int index = (int) (Math.random() * characters.length());
			sb.append(characters.charAt(index));
		}
		return sb.toString();
	}

	private boolean sendEmail(String to, String subject, String text) {
		String from = "vvv709171@gmail.com";
		String password = "szgbroidhlqgolfa";

		Properties properties = new Properties();
		properties.put("mail.smtp.host", "smtp.gmail.com");
		properties.put("mail.smtp.port", "465");
		properties.put("mail.smtp.socketFactory.port", "465");
		properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		properties.put("mail.smtp.auth", "true");

		Session session = Session.getInstance(properties, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(from, password);
			}
		});

		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(from));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
			message.setSubject(subject);
			message.setText(text);

			Transport.send(message);
			return true;
		} catch (MessagingException e) {
			e.printStackTrace();
			return false;
		}
	}

}

//=========================
@RestController
class MemControllerR {
	@Autowired
	MemService memSvc;

	@GetMapping("/checkAccount")
	public Map<String, Boolean> checkAccount(@RequestParam("memAcount") String memAcount, Model model) {
		Map<String, Boolean> response = new HashMap<>();
		response.put("exists", (memSvc.getMemByAccount(memAcount) != null));
		return response;
	}

	@GetMapping("/checkEmail")
	public Map<String, Boolean> checkEmail(@RequestParam("memEmail") String memEmail, Model model) {
		Map<String, Boolean> response = new HashMap<>();
		response.put("exists", (memSvc.getMemByEmail(memEmail) != null));
		return response;
	}

}
