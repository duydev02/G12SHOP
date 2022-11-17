package com.g12shop.controller.admin;

import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.g12shop.entity.Users;
import com.g12shop.service.UsersService;
import com.g12shop.util.SessionUtil;

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

	@PostMapping("/create")
	public String doPostCreateUser(@Valid @ModelAttribute("userRequest") Users userRequest, BindingResult bindingResult,
			RedirectAttributes redirectAttributes, @RequestParam("attach") MultipartFile attach,
			HttpServletRequest request) {
		if (bindingResult.hasErrors()) {
			String error = "";
			outerloop: for (Object object : bindingResult.getAllErrors()) {
				if (object instanceof ObjectError) {
					ObjectError objectError = (ObjectError) object;
					System.out.println(objectError.getCode());
					switch (objectError.getCode()) {
					case "Size":
						error = "Fullname";
						break outerloop;
					case "Email":
						error = "Email";
						break outerloop;
					default:
						error = "...";
						break outerloop;
					}
				}
			}
			redirectAttributes.addFlashAttribute("errorMessage", "User's " + error + " is not valid");
		} else {
			try {
				if (!attach.isEmpty()) {
					Path path = Paths.get("target/classes/static/user/img/user/");

					if (!Files.exists(path)) {
						Files.createDirectories(path);
					}

					InputStream inputStream = attach.getInputStream();
					Files.copy(inputStream, path.resolve(attach.getOriginalFilename()),
							StandardCopyOption.REPLACE_EXISTING);
					userRequest.setImgUrl(attach.getOriginalFilename());
				}
				String siteURL = SessionUtil.getSiteURL(request);
				usersService.save(userRequest, siteURL);
				redirectAttributes.addFlashAttribute("succeedMessage",
						"User " + userRequest.getUsername() + " has been created successfully");
			} catch (Exception e) {
				e.printStackTrace();
				redirectAttributes.addFlashAttribute("errorMessage",
						"Cannot create user: " + userRequest.getUsername() + ". " + e.getMessage());
			}
		}
		return "redirect:/admin/user";
	}

	@PostMapping("/edit")
	public String doPostEditUser(@Valid @ModelAttribute("userRequest") Users userRequest, BindingResult bindingResult,
			RedirectAttributes redirectAttributes, @RequestParam("attach") MultipartFile attach,
			HttpServletRequest request) {
		if (bindingResult.hasErrors()) {
			String error = "";
			outerloop: for (Object object : bindingResult.getAllErrors()) {
				if (object instanceof ObjectError) {
					ObjectError objectError = (ObjectError) object;
					System.out.println(objectError.getCode());
					switch (objectError.getCode()) {
					case "Size":
						error = "Fullname";
						break outerloop;
					case "Email":
						error = "Email";
						break outerloop;
					default:
						error = "...";
						break outerloop;
					}
				}
			}
			redirectAttributes.addFlashAttribute("errorMessage", "User's " + error + " is not valid");
		} else {
			try {
				if (!attach.isEmpty()) {
					Path path = Paths.get("target/classes/static/user/img/user/");

					if (!Files.exists(path)) {
						Files.createDirectories(path);
					}

					InputStream inputStream = attach.getInputStream();
					Files.copy(inputStream, path.resolve(attach.getOriginalFilename()),
							StandardCopyOption.REPLACE_EXISTING);
					userRequest.setImgUrl(attach.getOriginalFilename());
				} else {
					Users checkUser = usersService.findByUsername(userRequest.getUsername());
					userRequest.setImgUrl(checkUser.getImgUrl());
				}
				Users user = usersService.findByUsername(userRequest.getUsername());
				String emailCurrent = user.getEmail();
				if (userRequest.getEmail() != emailCurrent) {
					String siteURL = SessionUtil.getSiteURL(request);
					usersService.update(userRequest, siteURL);
				} else {
					usersService.update(userRequest);
				}
				redirectAttributes.addFlashAttribute("succeedMessage",
						"User " + userRequest.getUsername() + " has been edited successfully");
			} catch (Exception e) {
				e.printStackTrace();
				redirectAttributes.addFlashAttribute("errorMessage",
						"Cannot edit user: " + userRequest.getUsername() + ". " + e.getMessage());
			}
		}
		return "redirect:/admin/user";
	}
}
