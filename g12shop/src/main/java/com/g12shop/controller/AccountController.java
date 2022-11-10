package com.g12shop.controller;

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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.g12shop.config.EncoderConfig;
import com.g12shop.constant.SessionConstaint;
import com.g12shop.entity.Accounts;
import com.g12shop.service.AccountsService;
import com.g12shop.util.SessionUtil;
import com.g12shop.util.UserNotFoundExcepion;

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
		session.removeAttribute(SessionConstaint.CURRENT_USER);
		return "redirect:/index";
	}

	@GetMapping("/change-password")
	public String doGetChangePassword() {
		return "/change-password";
	}

	@GetMapping("/forgot-password")
	public String doGetForgotPassword() {
		return "/forgot-password";
	}

	@GetMapping("/reset-password")
	public String doGetResetPassword() {
		return "/reset-password";
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
				session.setAttribute(SessionConstaint.CURRENT_USER, accountResponse);
				return "redirect:/index";
			} else {
				ra.addFlashAttribute("message", "Tài khoản hoặc mật khẩu không đúng");
				return "redirect:/login";
			}
		} catch (UserNotFoundExcepion e) {
			ra.addFlashAttribute("message", e.getMessage());
			return "redirect:/login";
		}
	}

	@PostMapping("/register")
	public String doPostRegister(@Valid @ModelAttribute("accountRequest") Accounts accountRequest,
			BindingResult result, RedirectAttributes ra, HttpServletRequest request) throws Exception {
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
	public String doPostChangePassword(@RequestParam("oldPassword") String oldPassword,
			@RequestParam("newPassword") String newPassword, RedirectAttributes ra, HttpSession session) {
		Accounts accounts = (Accounts) session.getAttribute(SessionConstaint.CURRENT_USER);

		if (accounts == null) {
			ra.addFlashAttribute("message", "Please Login!");
			return "redirect:/login";
		} else if (oldPassword.equals(newPassword)) {
			ra.addFlashAttribute("message", "Your new pasword must be different than the old one, try again!");
			return "redirect:/change-password";
		} else if (!encoderConfig.passwordEncoder().matches(oldPassword, accounts.getHashPassword())) {
			ra.addFlashAttribute("message", "Your old password is incorrect!");
			return "redirect:/change-password";
		} else {
			accountsService.changePassword(accounts, newPassword);
			session.removeAttribute(SessionConstaint.CURRENT_USER);
			ra.addFlashAttribute("message", "Your password has been changed successfully!");
			return "redirect:/login";
		}
	}
}
