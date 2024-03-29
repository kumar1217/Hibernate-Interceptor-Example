package com.shinde.common;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

/**
 * StockCategory generated by hbm2java
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "stock_category", catalog = "hibernate", uniqueConstraints = @UniqueConstraint(columnNames = {
		"STOCK_ID", "CATEGORY_ID" }))
public class StockCategory implements java.io.Serializable {

	private Integer stockCategoryId;
	private Stock stock;
	private Category category;

	public StockCategory() {
	}

	public StockCategory(Stock stock, Category category) {
		this.stock = stock;
		this.category = category;
	}

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "STOCK_CATEGORY_ID", unique = true, nullable = false)
	public Integer getStockCategoryId() {
		return this.stockCategoryId;
	}

	public void setStockCategoryId(Integer stockCategoryId) {
		this.stockCategoryId = stockCategoryId;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "STOCK_ID", nullable = false)
	public Stock getStock() {
		return this.stock;
	}

	public void setStock(Stock stock) {
		this.stock = stock;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CATEGORY_ID", nullable = false)
	public Category getCategory() {
		return this.category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

}
