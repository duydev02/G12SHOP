package com.g12shop.entity;

public enum OrderStatuses {

	CHUA_XAC_NHAN("Chưa xác nhận"), DA_XAC_NHAN("Đã xác nhận"), DANG_GIAO_HANG("Đang giao hàng"),
	DA_GIAO_HANG("Đã giao hàng");

	public final String label;

	private OrderStatuses(String label) {
		this.label = label;
	}
}
