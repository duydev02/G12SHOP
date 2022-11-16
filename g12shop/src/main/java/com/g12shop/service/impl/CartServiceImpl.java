package com.g12shop.service.impl;

import java.util.HashMap;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.g12shop.dto.CartDetailDto;
import com.g12shop.dto.CartDto;
import com.g12shop.entity.Accounts;
import com.g12shop.entity.OrderStatuses;
import com.g12shop.entity.Orders;
import com.g12shop.entity.Products;
import com.g12shop.service.CartService;
import com.g12shop.service.OrderDetailsService;
import com.g12shop.service.OrdersService;
import com.g12shop.service.ProductsService;
import com.g12shop.util.QuantityException;

@Service
public class CartServiceImpl implements CartService {

	@Autowired
	private ProductsService productsService;

	@Autowired
	private OrdersService ordersService;

	@Autowired
	private OrderDetailsService orderDetailsService;

	@Override
	public CartDto updateCart(CartDto cart, Long productId, Integer quantity, boolean isReplace) {
		Products product = productsService.findById(productId);

		HashMap<Long, CartDetailDto> details = cart.getDetails();

		// 1 - them moi sp
		// 2 - update:
		// 2.1 - cong don
		// 2.2 - replace
		// 3 - delete: update quantity ve 0

		if (!details.containsKey(productId)) {
			// them moi
			CartDetailDto newDetail = createNewCartDetail(product, quantity);
			details.put(productId, newDetail);
		} else if (quantity > 0) {
			// update
			if (isReplace) {
				// thay the
				details.get(productId).setQuantity(quantity);
			} else {
				// cong don
				Integer oldQuantity = details.get(productId).getQuantity();
				Integer newQuantity = oldQuantity + quantity;
				details.get(productId).setQuantity(newQuantity);
			}
		} else {
			// delete
			details.remove(productId);
		}
		cart.setTotalQuantity(getTotalQuantity(cart));
		cart.setTotalPrice(getTotalPrice(cart));
		Double shippingFee = 30000.0;
		if (cart.getTotalPrice() > 299000.0) {
			shippingFee = 0.0;
		}
		cart.setShippingFee(shippingFee);
		return cart;
	}

	@Override
	public Integer getTotalQuantity(CartDto cart) {
		Integer totalQuantity = 0;
		HashMap<Long, CartDetailDto> details = cart.getDetails();
		for (CartDetailDto cartDetail : details.values()) {
			totalQuantity += cartDetail.getQuantity();
		}
		return totalQuantity;
	}

	@Override
	public Double getTotalPrice(CartDto cart) {
		Double totalPrice = 0D;
		HashMap<Long, CartDetailDto> details = cart.getDetails();
		for (CartDetailDto cartDetail : details.values()) {

			Double percentDiscount = 1.0;
			if (cartDetail.getDiscount() != null) {
				Double discount = (double) cartDetail.getDiscount();
				if (discount > 0) {
					percentDiscount = 1.0 - discount / 100;
				}
			}
			totalPrice += cartDetail.getPrice() * percentDiscount * cartDetail.getQuantity();
		}
		return totalPrice;
	}

	@Transactional
	@Override
	public void insert(CartDto cart, Accounts account, String address, String phone) throws Exception {
		// insert vao ORDER
		Orders order = new Orders();
		order.setAccount(account);
		order.setAddress(address);
		order.setPhone(phone);
		order.setShippingFee(cart.getShippingFee());
		order.setTotalPrice(cart.getTotalPrice() + cart.getShippingFee());
		order.setOrderStatus(OrderStatuses.CHUA_XAC_NHAN);

		Orders orderResponse = ordersService.insert(order);
		// duyet hashmap de insert lan luot vao ORDER_DETAILS
		// trong luc duyet hashmap qua tung SP -> di update quanity cho tung SP do
		for (CartDetailDto cartDetail : cart.getDetails().values()) {
			Products product = productsService.findById(cartDetail.getProductId());
			if (checkQuantity(product, cartDetail)) {
				cartDetail.setOrderId(orderResponse.getId());
				orderDetailsService.insert(cartDetail);

				Integer newQuantity = product.getQuantity() - cartDetail.getQuantity();
				productsService.updateQuantity(newQuantity, cartDetail.getProductId());
			} else {
				throw new QuantityException("So luong trong gio hang phai nho hon trong kho");
			}
		}
	}

	private CartDetailDto createNewCartDetail(Products product, Integer quantity) {
		CartDetailDto cartDetail = new CartDetailDto();
		cartDetail.setProductId(product.getId());
		cartDetail.setPrice(product.getPrice());
		cartDetail.setDiscount(product.getDiscount());
		cartDetail.setQuantity(quantity);
		cartDetail.setSlug(product.getSlug());
		cartDetail.setName(product.getName());
		cartDetail.setImgName(product.getImgName());
		return cartDetail;
	}

	private boolean checkQuantity(Products product, CartDetailDto cartDetail) {
		return product.getQuantity() >= cartDetail.getQuantity();
	}

}
