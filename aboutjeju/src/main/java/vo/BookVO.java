package vo;

public class BookVO {
	int bno;
	String ono;
	int rno;
	int cno;
	String bsdate;
	String bedate;
	String pay;
	int bprice;
	String bname;
	String bphone;
	String way;
	int bookok;
	String aname;
	String rtype;
	String aimage;

	public BookVO(int bno, String ono, int rno, int cno, String bsdate, String bedate, String pay, int bprice,
			String bname, String bphone, String way, int bookok) {
		super();
		this.bno = bno;
		this.ono = ono;
		this.rno = rno;
		this.cno = cno;
		this.bsdate = bsdate;
		this.bedate = bedate;
		this.pay = pay;
		this.bprice = bprice;
		this.bname = bname;
		this.bphone = bphone;
		this.way = way;
		this.bookok = bookok;
	}

	public BookVO(int bno, String bsdate, String bedate, int bprice, String aname, String rtype, String aimage) {
		super();
		this.bno = bno;
		this.bsdate = bsdate;
		this.bedate = bedate;
		this.bprice = bprice;
		this.aname = aname;
		this.rtype = rtype;
		this.aimage = aimage;
	}

	public int getBno() {
		return bno;
	}

	public void setBno(int bno) {
		this.bno = bno;
	}

	public String getOno() {
		return ono;
	}

	public void setOno(String ono) {
		this.ono = ono;
	}

	public int getRno() {
		return rno;
	}

	public void setRno(int rno) {
		this.rno = rno;
	}

	public int getCno() {
		return cno;
	}

	public void setCno(int cno) {
		this.cno = cno;
	}

	public String getBsdate() {
		return bsdate;
	}

	public void setBsdate(String bsdate) {
		this.bsdate = bsdate;
	}

	public String getBedate() {
		return bedate;
	}

	public void setBedate(String bedate) {
		this.bedate = bedate;
	}

	public String getPay() {
		return pay;
	}

	public void setPay(String pay) {
		this.pay = pay;
	}

	public int getBprice() {
		return bprice;
	}

	public void setBprice(int bprice) {
		this.bprice = bprice;
	}

	public String getBname() {
		return bname;
	}

	public void setBname(String bname) {
		this.bname = bname;
	}

	public String getBphone() {
		return bphone;
	}

	public void setBphone(String bphone) {
		this.bphone = bphone;
	}

	public String getWay() {
		return way;
	}

	public void setWay(String way) {
		this.way = way;
	}

	public int getBookok() {
		return bookok;
	}

	public void setBookok(int bookok) {
		this.bookok = bookok;
	}

	public String getAname() {
		return aname;
	}

	public void setAname(String aname) {
		this.aname = aname;
	}

	public String getRtype() {
		return rtype;
	}

	public void setRtype(String rtype) {
		this.rtype = rtype;
	}

	public String getAimage() {
		return aimage;
	}

	public void setAimage(String aimage) {
		this.aimage = aimage;
	}

}
