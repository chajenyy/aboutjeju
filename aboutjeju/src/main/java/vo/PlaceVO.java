package vo;

public class PlaceVO {
	int pno;
	String pname;
	String paddress;
	String pdetail;
	String pphone;
	String pimage;

	public PlaceVO(int pno, String pname, String paddress, String pdetail, String pphone, String pimage) {
		super();
		this.pno = pno;
		this.pname = pname;
		this.paddress = paddress;
		this.pdetail = pdetail;
		this.pphone = pphone;
		this.pimage = pimage;
	}

	public int getPno() {
		return pno;
	}

	public void setPno(int pno) {
		this.pno = pno;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public String getPaddress() {
		return paddress;
	}

	public void setPaddress(String paddress) {
		this.paddress = paddress;
	}

	public String getPdetail() {
		return pdetail;
	}

	public void setPdetail(String pdetail) {
		this.pdetail = pdetail;
	}

	public String getPphone() {
		return pphone;
	}

	public void setPphone(String pphone) {
		this.pphone = pphone;
	}

	public String getPimage() {
		return pimage;
	}

	public void setPimage(String pimage) {
		this.pimage = pimage;
	}

}
