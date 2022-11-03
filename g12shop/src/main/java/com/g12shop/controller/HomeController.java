package com.g12shop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class HomeController {

    @GetMapping({"", "/index"})
<<<<<<< HEAD
    public String doGetHome() {
=======
    public String doGetHome(Model model) {
    	model.addAttribute("isIndexPage", true);
>>>>>>> b40064c8780919095f4daa9fc074a61d738bc3b6
        return "index";
    }

    @GetMapping("shop-grid")
    public String doGetShopGrid(Model model) {
    	model.addAttribute("isShopPage", true);
        return "shop-grid";
    }

    @GetMapping("shop-details")
    public String doGetShopDetail(Model model) {
    	model.addAttribute("isShopPage", true);
        return "shop-details";
    }

    @GetMapping("shopping-cart")
    public String doGetShoppingCart() {
        return "shopping-cart";
    }

    @GetMapping("checkout")
    public String doGetCheckout() {
        return "checkout";
    }

    @GetMapping("about")
    public String doGetAbout(Model model) {
    	model.addAttribute("isAboutPage", true);
        return "about";
    }

    @GetMapping("contact")
    public String doGetContact(Model model) {
    	model.addAttribute("isContactPage", true);
        return "contact";
    }

    @GetMapping("login")
    public String doGetLogin() {
        return "login";
    }

    @GetMapping("register")
    public String doGetRegister() {
        return "register";
    }
}
