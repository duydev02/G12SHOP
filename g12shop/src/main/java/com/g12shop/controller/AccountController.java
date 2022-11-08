package com.g12shop.controller;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.g12shop.constant.SessionConstaint;
import com.g12shop.entity.Accounts;
import com.g12shop.service.AccountsService;

@Controller
public class AccountController {
	
	@Autowired
	private AccountsService accountsService;
	
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
    
    @PostMapping("/login")
    public String doPostLogin(@Valid Accounts account ,@ModelAttribute("accountRequest") Accounts accountRequest
    		, RedirectAttributes ra, BindingResult result, HttpSession session) {
		if (result.hasErrors()) {
			result.getAllErrors().forEach(error -> System.out.println(error.getDefaultMessage()));
			ra.addFlashAttribute("message", "Error, try again!");
		}
		try {
			Accounts accountResponse = accountsService.doLogin(accountRequest.getUsername(), accountRequest.getHashPassword());
			if(accountResponse != null) {
				session.setAttribute(SessionConstaint.CURRENT_USER, accountResponse);
				return "redirect:/index";
			}else {
				ra.addFlashAttribute("message", "Sai mật khẩu");
				return "redirect:/login";
			}
		} catch (Exception e) {
			ra.addFlashAttribute("message", e.getMessage());
			return "redirect:/login";
		}
    }
}
