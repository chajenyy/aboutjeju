package vo;

public class FoodVO {
	int fno;
	String fname;
	String faddress;
	String fdetail;
	String fphone;
	String fimage;

	public FoodVO(int fno, String fname, String faddress, String fdetail, String fphone, String fimage) {
		super();
		this.fno = fno;
		this.fname = fname;
		this.faddress = faddress;
		this.fdetail = fdetail;
		this.fphone = fphone;
		this.fimage = fimage;
	}

	public int getFno() {
		return fno;
	}

	public void setFno(int fno) {
		this.fno = fno;
	}

	public String getFname() {
		return fname;
	}

	public void setFname(String fname) {
		this.fname = fname;
	}

	public String getFaddress() {
		return faddress;
	}

	public void setFaddress(String faddress) {
		this.faddress = faddress;
	}

	public String getFdetail() {
		return fdetail;
	}

	public void setFdetail(String fdetail) {
		this.fdetail = fdetail;
	}

	public String getFphone() {
		return fphone;
	}

	public void setFphone(String fphone) {
		this.fphone = fphone;
	}

	public String getFimage() {
		return fimage;
	}

	public void setFimage(String fimage) {
		this.fimage = fimage;
	}

}
