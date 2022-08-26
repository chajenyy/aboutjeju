package vo;

public class AccomodationVO {
	int ano;
	String ono;
	String aname;
	String aaddress;
	String aimage;
	String atype;
	String adetail;
	String aphone;
	float star;
	int discount;
	int price;
	
	public AccomodationVO() {}

	public AccomodationVO(int ano, String ono, String aname, String aaddress, String aimage, String atype,
			String adetail, String aphone) {
		super();
		this.ano = ano;
		this.ono = ono;
		this.aname = aname;
		this.aaddress = aaddress;
		this.aimage = aimage;
		this.atype = atype;
		this.adetail = adetail;
		this.aphone = aphone;
	}

	public AccomodationVO(int ano, String ono, String aname, String aaddress, String aimage, String atype,
			String adetail, String aphone, float star) {
		super();
		this.ano = ano;
		this.ono = ono;
		this.aname = aname;
		this.aaddress = aaddress;
		this.aimage = aimage;
		this.atype = atype;
		this.adetail = adetail;
		this.aphone = aphone;
		this.star = star;
	}

	public AccomodationVO(int ano, String ono, String aname, String aaddress, String aimage, String atype,
			String adetail, String aphone, int discount, int price) {
		super();
		this.ano = ano;
		this.ono = ono;
		this.aname = aname;
		this.aaddress = aaddress;
		this.aimage = aimage;
		this.atype = atype;
		this.adetail = adetail;
		this.aphone = aphone;
		this.discount = discount;
		this.price = price;
	}

	public int getAno() {
		return ano;
	}

	public void setAno(int ano) {
		this.ano = ano;
	}

	public String getOno() {
		return ono;
	}

	public void setOno(String ono) {
		this.ono = ono;
	}

	public String getAname() {
		return aname;
	}

	public void setAname(String aname) {
		this.aname = aname;
	}

	public String getAaddress() {
		return aaddress;
	}

	public void setAaddress(String aaddress) {
		this.aaddress = aaddress;
	}

	public String getAimage() {
		return aimage;
	}

	public void setAimage(String aimage) {
		this.aimage = aimage;
	}

	public String getAtype() {
		return atype;
	}

	public void setAtype(String atype) {
		this.atype = atype;
	}

	public String getAdetail() {
		return adetail;
	}

	public void setAdetail(String adetail) {
		this.adetail = adetail;
	}

	public String getAphone() {
		return aphone;
	}

	public void setAphone(String aphone) {
		this.aphone = aphone;
	}

	public float getStar() {
		return star;
	}

	public void setStar(float star) {
		this.star = star;
	}

	public int getDiscount() {
		return discount;
	}

	public void setDiscount(int discount) {
		this.discount = discount;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}
	
}
