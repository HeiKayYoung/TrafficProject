package com.traffic.usetools;


public class SearchVO extends  PageVO  {

	private String bgno;                       
    private String searchKeyword = "";         
    private String searchType = "";           
    private String[] searchTypeArr;
    private String keyword;
    
    public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getBgno() {
        return bgno;
    }

    public void setBgno(String bgno) {
        this.bgno = bgno;
    }

    public String getSearchKeyword() {
        return searchKeyword;
    }
    
    public void setSearchKeyword(String searchKeyword) {
        this.searchKeyword = searchKeyword;
    }
    
    public String getSearchType() {
        return searchType;
    }
    
    public void setSearchType(String searchType) {
        this.searchType = searchType;
    }
    
    public String[] getSearchTypeArr() {
        return searchType.split(",");
    }
    
}
 