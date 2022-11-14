package com.g12shop.controller;

import java.io.UnsupportedEncodingException;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.g12shop.config.EncoderConfig;
import com.g12shop.constant.SessionConstant;
import com.g12shop.entity.Accounts;
import com.g12shop.service.AccountsService;
import com.g12shop.util.SessionUtil;
import com.g12shop.util.UserNotFoundExcepion;

import net.bytebuddy.utility.RandomString;

@Controller
public class AccountController {

	@Autowired
	private AccountsService accountsService;

	@Autowired
	private EncoderConfig encoderConfig;

	@GetMapping("/login")
	public String doGetLogin(Model model) {
		model.addAttribute("accountRequest", new Accounts());
		return "login";
	}

	@GetMapping("/register")
	public String doGetRegister(Model model) {
		model.addAttribute("accountRequest", new Accounts());
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
	public String verifyAccount(@Param("verificationCode") String verificationCode, RedirectAttributes ra) {
		if (accountsService.verificationAccount(verificationCode)) {
			ra.addFlashAttribute("message", "Your account is activated, please login again!");
			return "redirect:/login";
		} else {
			ra.addFlashAttribute("message", "The code is expired. please try again!");
			return "redirect:/register";
		}
	}
	
	@GetMapping("/reset-password")
	public String doGetResetPassword(@Param("token")String token, RedirectAttributes ra, Model model) {
		Accounts account = accountsService.getResetPasswordToken(token);
		
		if(account == null || token == null) {
			ra.addFlashAttribute("message", "the token has expired, try again!");
			return "redirect:/forgot-password";
		}else {
			model.addAttribute("token", token);
			return "reset-password";
		}
	}

	@GetMapping("/profile/{username}")
	public String doGetProfile(@PathVariable("username") String username, HttpSession session, Model model) {
		Accounts account = (Accounts) session.getAttribute(SessionConstant.CURRENT_USER);
		if (!username.equals(account.getUsername())) {
			return "redirect:/index";
		}
		model.addAttribute("userRequest", account);
		return "profile";
	}

	@GetMapping("/security/{username}")
	public String doGetSecurity(@PathVariable("username") String username, HttpSession session) {
		Accounts account = (Accounts) session.getAttribute(SessionConstant.CURRENT_USER);
		if (!username.equals(account.getUsername())) {
			return "redirect:/index";
		}
		return "security";
	}

	@PostMapping("/login")
	public String doPostLogin(@Valid @ModelAttribute("accountRequest") Accounts accountRequest, BindingResult result,
			RedirectAttributes ra, HttpSession session) throws Exception {
		if (result.hasErrors()) {
			result.getAllErrors().forEach(error -> System.out.println(error.getDefaultMessage()));
			ra.addFlashAttribute("message", "Error, try again!");
		}
		try {
			Accounts accountResponse = accountsService.doLogin(accountRequest.getUsername(),
					accountRequest.getHashPassword());
			if (accountResponse != null) {
				session.setAttribute(SessionConstant.CURRENT_USER, accountResponse);
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
	public String doPostRegister(@Valid @ModelAttribute("accountRequest") Accounts accountRequest, BindingResult result,
			RedirectAttributes ra, HttpServletRequest request) throws Exception {
		if (result.hasErrors()) {
			result.getAllErrors().forEach(error -> System.out.println(error.getDefaultMessage()));
			ra.addFlashAttribute("message", "Error, try again!");
		}
		try {
			Accounts account = accountsService.doRegister(accountRequest);
			String siteURL = SessionUtil.getSiteURL(request);
			accountsService.sendVerificationEmail(account, siteURL);
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
		Accounts account = (Accounts) session.getAttribute(SessionConstant.CURRENT_USER);

		if (account == null) {
			ra.addFlashAttribute("message", "Please Login!");
			return "redirect:/login";
		} else if (currentPassword.equals(newPassword)) {
			ra.addFlashAttribute("message", "Your new pasword must be different than the current one, try again!");
			return "redirect:/security/" + account.getUsername();
		} else if (!encoderConfig.passwordEncoder().matches(currentPassword, account.getHashPassword())) {
			ra.addFlashAttribute("message", "Your current password is incorrect!");
			return "redirect:/security/" + account.getUsername();
		} else {
			accountsService.changePassword(account, newPassword);
			session.removeAttribute(SessionConstant.CURRENT_USER);
			ra.addFlashAttribute("message", "Your password has been changed successfully!");
			return "redirect:/login";
		}
	}
	
	@PostMapping("/forgot-password")
	public String doPostForgotPassword(@RequestParam("email")String email, HttpServletRequest request, RedirectAttributes ra) {
		String token = RandomString.make(30);
		
		try {
			accountsService.forgotPassword(token, email);
			
			String linkPasswordReset = SessionUtil.getSiteURL(request) + "/reset-password?token=" + token;
			accountsService.sendMailActivated(email, linkPasswordReset);
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
		Accounts account = accountsService.getResetPasswordToken(token);
		
		if(account == null) {
			ra.addFlashAttribute("message", "Invalid Token");
			return "redirect:/forgot-password";
		}else {
			accountsService.updatePassword(account, password);
			ra.addFlashAttribute("message", "You have successfully changed your password, please login");
			return "redirect:/login";
		}
	}
}
