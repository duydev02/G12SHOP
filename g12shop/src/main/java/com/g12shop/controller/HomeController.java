package com.g12shop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class HomeController {

    @GetMapping({"", "/index"})
    public String doGetHome(Model model) {
        return "index";
    }

    @GetMapping("shop-grid")
    public String doGetShopGrid() {
        return "shop-grid";
    }

    @GetMapping("shop-details")
    public String doGetShopDetail() {
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
    public String doGetAbout() {
        return "about";
    }

    @GetMapping("contact")
    public String doGetContact() {
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
