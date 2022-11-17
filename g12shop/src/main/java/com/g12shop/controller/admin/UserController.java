package com.g12shop.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.g12shop.entity.Users;
import com.g12shop.service.UsersService;

@Controller(value = "UserControllerOfAdmin")
@RequestMapping("/admin/user")
public class UserController {
	
	@Autowired
	private UsersService usersService;
	
	@GetMapping("")
	public String doGetIndex(Model model) {
		model.addAttribute("isAdminUserPage", true);
		
		List<Users> users = usersService.findAll();
		model.addAttribute("users", users);
		model.addAttribute("userRequest", new Users());
		return "admin/user";
	}
	
	// /admin/user/delete?username={...}
	@GetMapping("/delete")
	public String doGetDelete(@RequestParam("username") String username, RedirectAttributes redirectAttributes) {
		try {
			usersService.deleteLogical(username);
			redirectAttributes.addFlashAttribute("succeedMessage", "User " + username + " was deleted");
		} catch (Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("errorMessage", "Cannot delete user " + username);
		}
		return "redirect:/admin/user";
	}

	@GetMapping("/edit")
	public String doGetEditUser(@RequestParam("username") String username, Model model) {
		Users userRequest = usersService.findByUsername(username);
		model.addAttribute("userRequest", userRequest);
		return "admin/user::#form";
	}
}
