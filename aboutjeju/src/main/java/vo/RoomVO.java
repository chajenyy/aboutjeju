package vo;

public class RoomVO {
	int rno;
	int ano;
	String rtype;
	int rcount;
	int price;
	int discount;
	int rpeople;
	
	public RoomVO() {}
	
	public RoomVO(int rno, int ano, String rtype, int rcount, int price, int discount, int rpeople) {
		super();
		this.rno = rno;
		this.ano = ano;
		this.rtype = rtype;
		this.rcount = rcount;
		this.price = price;
		this.discount = discount;
		this.rpeople = rpeople;
	}

	public int getRno() {
		return rno;
	}

	public void setRno(int rno) {
		this.rno = rno;
	}

	public int getAno() {
		return ano;
	}

	public void setAno(int ano) {
		this.ano = ano;
	}

	public String getRtype() {
		return rtype;
	}

	public void setRtype(String rtype) {
		this.rtype = rtype;
	}

	public int getRcount() {
		return rcount;
	}

	public void setRcount(int rcount) {
		this.rcount = rcount;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getDiscount() {
		return discount;
	}

	public void setDiscount(int discount) {
		this.discount = discount;
	}

	public int getRpeople() {
		return rpeople;
	}

	public void setRpeople(int rpeople) {
		this.rpeople = rpeople;
	}

}
