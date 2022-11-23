package com.g12shop.controller;

import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.g12shop.config.EncoderConfig;
import com.g12shop.constant.SessionConstant;
import com.g12shop.entity.OrderStatuses;
import com.g12shop.entity.Orders;
import com.g12shop.entity.Users;
import com.g12shop.service.OrderDetailsService;
import com.g12shop.service.OrdersService;
import com.g12shop.service.SessionService;
import com.g12shop.service.UsersService;
import com.g12shop.util.SessionUtil;
import com.g12shop.util.UserNotFoundExcepion;

import net.bytebuddy.utility.RandomString;

@Controller
public class UserController {

	@Autowired
	private UsersService usersService;

	@Autowired
	private EncoderConfig encoderConfig;
	
	@Autowired
	private SessionService sessionService;
	
	@Autowired
	private OrdersService ordersService;
	
	@Autowired
	private OrderDetailsService orderDetailsService;

	@GetMapping("/login")
	public String doGetLogin(Model model) {
		model.addAttribute("userRequest", new Users());
		return "login";
	}

	@GetMapping("/register")
	public String doGetRegister(Model model) {
		model.addAttribute("userRequest", new Users());
		return "register";
	}

	@GetMapping("/logout")
	public String doGetLogout(HttpSession session) {
		session.removeAttribute(SessionConstant.CURRENT_USER);
		return "redirect:/index";
	}

	@GetMapping("/forgot-password")
	public String doGetForgotPassword() {
		return "/forgot-password";
	}

	@GetMapping("/verify")
	public String verifyUser(@Param("verificationCode") String verificationCode, RedirectAttributes ra) {
		if (usersService.verificationUser(verificationCode)) {
			ra.addFlashAttribute("message", "Your account is activated, please login again!");
			return "redirect:/login";
		} else {
			ra.addFlashAttribute("message", "The code is expired. please try again!");
			return "redirect:/register";
		}
	}
	
	@GetMapping("/reset-password")
	public String doGetResetPassword(@Param("token")String token, RedirectAttributes ra, Model model) {
		Users user = usersService.getResetPasswordToken(token);
		
		if(user == null || token == null) {
			ra.addFlashAttribute("message", "the token has expired, try again!");
			return "redirect:/forgot-password";
		}else {
			model.addAttribute("token", token);
			return "reset-password";
		}
	}

	@GetMapping("/profile/{username}")
	public String doGetProfile(@PathVariable("username") String username, HttpSession session, Model model) {
		Users user = (Users) session.getAttribute(SessionConstant.CURRENT_USER);
		if (user == null || username == null || !username.equals(user.getUsername())) {
			return "redirect:/index";
		}
		model.addAttribute("userRequest", user);
		return "profile";
	}

	@GetMapping("/security/{username}")
	public String doGetSecurity(@PathVariable("username") String username, HttpSession session) {
		Users user = (Users) session.getAttribute(SessionConstant.CURRENT_USER);
		if (user == null || username == null || !username.equals(user.getUsername())) {
			return "redirect:/index";
		}
		return "security";
	}
	
	@GetMapping("/my-order/{username}")
	public String doGetOrder(@PathVariable("username") String username, HttpSession session, Model model) {
		Users user = (Users) session.getAttribute(SessionConstant.CURRENT_USER);
		if (user == null || username == null || !username.equals(user.getUsername())) {
			return "redirect:/index";
		}
		// All
		List<Orders> orders = ordersService.findByOrderByCreatedDateDesc();
		model.addAttribute("orders", orders);
		// CHUA_XAC_NHAN
		List<Orders> ordersChuaXN = ordersService.findByOrderStatus(OrderStatuses.CHUA_XAC_NHAN);
		model.addAttribute("ordersChuaXN", ordersChuaXN);
		// DA_XAC_NHAN
		List<Orders> ordersDaXN = ordersService.findByOrderStatus(OrderStatuses.DA_XAC_NHAN);
		model.addAttribute("ordersDaXN", ordersDaXN);
		// DANG_GIAO_HANG
		List<Orders> ordersDangGH = ordersService.findByOrderStatus(OrderStatuses.DANG_GIAO_HANG);
		model.addAttribute("ordersDangGH", ordersDangGH);
		// DA_GIAO_HANG
		List<Orders> ordersDaGH = ordersService.findByOrderStatus(OrderStatuses.DA_GIAO_HANG);
		model.addAttribute("ordersDaGH", ordersDaGH);
		
		return "profile-order";
	}
	
	@GetMapping("/my-order/orderdetails")
	public String doGetOrderDetails(@RequestParam("id") Long id, Model model) {
		List<com.g12shop.entity.OrderDetails> orderDetails = orderDetailsService.findByOrderId(id);
		Orders order = ordersService.findById(id);
		model.addAttribute("order", order);
		model.addAttribute("orderDetails", orderDetails);
		return "profile-order::#table-order-details";
	}

	@PostMapping("/login")
	public String doPostLogin(@Valid @ModelAttribute("userRequest") Users userRequest, BindingResult result,
			RedirectAttributes ra, HttpSession session) throws Exception {
		if (result.hasErrors()) {
			result.getAllErrors().forEach(error -> System.out.println(error.getDefaultMessage()));
			ra.addFlashAttribute("message", "Error, try again!");
		}
		try {
			Users userResponse = usersService.doLogin(userRequest.getUsername(),
					userRequest.getHashPassword());
			if (userResponse != null) {
				session.setAttribute(SessionConstant.CURRENT_USER, userResponse);
				return "redirect:/index";
			} else {
				ra.addFlashAttribute("message", "Mật khẩu không chính xác");
				return "redirect:/login";
			}
		} catch (UserNotFoundExcepion e) {
			ra.addFlashAttribute("message", e.getMessage());
			return "redirect:/login";
		}
	}

	@PostMapping("/register")
	public String doPostRegister(@Valid @ModelAttribute("userRequest") Users userRequest, BindingResult result,
			RedirectAttributes ra, HttpServletRequest request) throws Exception {
		if (result.hasErrors()) {
			result.getAllErrors().forEach(error -> System.out.println(error.getDefaultMessage()));
			ra.addFlashAttribute("message", "Error, try again!");
		}
		try {
			Users user = usersService.doRegister(userRequest);
			String siteURL = SessionUtil.getSiteURL(request);
			usersService.sendVerificationEmail(user, siteURL);
			ra.addFlashAttribute("message",
					"Successfully registration, please go to your email and verify to activate your account!");
			return "redirect:/register";
		} catch (UserNotFoundExcepion e) {
			ra.addFlashAttribute("message", e.getMessage());
			return "redirect:/register";
		}
	}

	@PostMapping("/change-password")
	public String doPostChangePassword(@RequestParam("currentPassword") String currentPassword,
			@RequestParam("newPassword") String newPassword, RedirectAttributes ra, HttpSession session) {
		Users user = (Users) session.getAttribute(SessionConstant.CURRENT_USER);

		if (user == null) {
			ra.addFlashAttribute("message", "Please Login!");
			return "redirect:/login";
		} else if (currentPassword.equals(newPassword)) {
			ra.addFlashAttribute("message", "Your new pasword must be different than the current one, try again!");
			return "redirect:/security/" + user.getUsername();
		} else if (!encoderConfig.passwordEncoder().matches(currentPassword, user.getHashPassword())) {
			ra.addFlashAttribute("message", "Your current password is incorrect!");
			return "redirect:/security/" + user.getUsername();
		} else {
			usersService.changePassword(user, newPassword);
			session.removeAttribute(SessionConstant.CURRENT_USER);
			ra.addFlashAttribute("message", "Your password has been changed successfully!");
			return "redirect:/login";
		}
	}
	
	@PostMapping("/forgot-password")
	public String doPostForgotPassword(@RequestParam("email")String email, HttpServletRequest request, RedirectAttributes ra) {
		String token = RandomString.make(30);
		
		try {
			usersService.forgotPassword(token, email);
			
			String linkPasswordReset = SessionUtil.getSiteURL(request) + "/reset-password?token=" + token;
			usersService.sendMailActivated(email, linkPasswordReset);
			ra.addFlashAttribute("message", "we have send a reset password link to your email, please check.");
		} catch (UserNotFoundExcepion e) {
			ra.addFlashAttribute("message", e.getMessage());
		}catch (UnsupportedEncodingException | MessagingException e) {
			ra.addFlashAttribute("message", "Error while sending email.");
		}
		return "redirect:/forgot-password";
	}
	
	@PostMapping("/reset-password")
	public String doPostResetPassword(@RequestParam("token")String token, @RequestParam("password")String password, 
			HttpServletRequest request, RedirectAttributes ra)throws Exception{
		Users user = usersService.getResetPasswordToken(token);
		
		if(user == null) {
			ra.addFlashAttribute("message", "Invalid Token");
			return "redirect:/forgot-password";
		}else {
			usersService.updatePassword(user, password);
			ra.addFlashAttribute("message", "You have successfully changed your password, please login");
			return "redirect:/login";
		}
	}
	
	@PostMapping("/profile/change")
	public String doPostChange(@ModelAttribute("userRequest") Users userRequest, RedirectAttributes redirectAttributes,
			@RequestParam("attach") MultipartFile attach) {
		Users currenUser = sessionService.get("currentUser");
		String fullname = userRequest.getFullname();
		String email = userRequest.getEmail();
		try {
			String newImage = currenUser.getImgUrl();
			if (!attach.isEmpty()) {
				Path path = Paths.get("src/main/resources/static/user/img/user");

				if (!Files.exists(path)) {
					Files.createDirectories(path);
				}
				InputStream inputStream = attach.getInputStream();
				String s = System.currentTimeMillis() + attach.getOriginalFilename();
				String imageHashName = Integer.toHexString(s.hashCode()) + s.substring(s.lastIndexOf("."));
				Files.copy(inputStream, path.resolve(imageHashName),
						StandardCopyOption.REPLACE_EXISTING);
				newImage = imageHashName;
			}
			usersService.change(currenUser, fullname, email, newImage);
			redirectAttributes.addFlashAttribute("succeedMessage", "Change profile successfully!");
		} catch (Exception e) {
			redirectAttributes.addFlashAttribute("succeedMessage", "Change profile error!");
		}
		return "redirect:/profile/" + currenUser.getUsername();
	}
}
