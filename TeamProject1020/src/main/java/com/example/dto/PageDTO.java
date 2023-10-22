package com.example.dto;

import java.util.List;

import org.apache.ibatis.type.Alias;
@Alias("PageDTO")
public class PageDTO {

	private List<ProductDTO> list;
	private int curPage;
	private int perPage=5;
	private int totalCount;
	
	@Override
	public String toString() {
		return "PageDTO [list=" + list + ", curPage=" + curPage + ", perPage=" + perPage + ", totalCount=" + totalCount
				+ "]";
	}
	public List<ProductDTO> getList() {
		return list;
	}
	public void setList(List<ProductDTO> list) {
		this.list = list;
	}
	public int getCurPage() {
		return curPage;
	}
	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}
	public int getPerPage() {
		return perPage;
	}
	public void setPerPage(int perPage) {
		this.perPage = perPage;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	
	
}
