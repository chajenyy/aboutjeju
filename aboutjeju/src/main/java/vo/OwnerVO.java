package vo;

public class OwnerVO {
	String ono;
	String oid;
	String opw;
	String ofindpw;
	String ofindpwa;
	String oname;
	String ophone;

	public OwnerVO(String ono, String oid, String opw, String ofindpw, String ofindpwa, String oname, String ophone) {
		super();
		this.ono = ono;
		this.oid = oid;
		this.opw = opw;
		this.ofindpw = ofindpw;
		this.ofindpwa = ofindpwa;
		this.oname = oname;
		this.ophone = ophone;
	}

	public OwnerVO(String ofindpw, String ofindpwa, String oname, String ophone) {
		super();
		this.ofindpw = ofindpw;
		this.ofindpwa = ofindpwa;
		this.oname = oname;
		this.ophone = ophone;
	}

	public String getOno() {
		return ono;
	}

	public void setOno(String ono) {
		this.ono = ono;
	}

	public String getOid() {
		return oid;
	}

	public void setOid(String oid) {
		this.oid = oid;
	}

	public String getOpw() {
		return opw;
	}

	public void setOpw(String opw) {
		this.opw = opw;
	}

	public String getOfindpw() {
		return ofindpw;
	}

	public void setOfindpw(String ofindpw) {
		this.ofindpw = ofindpw;
	}

	public String getOname() {
		return oname;
	}

	public void setOname(String oname) {
		this.oname = oname;
	}

	public String getOphone() {
		return ophone;
	}

	public void setOphone(String ophone) {
		this.ophone = ophone;
	}

	public String getOfindpwa() {
		return ofindpwa;
	}

	public void setOfindpwa(String ofindpwa) {
		this.ofindpwa = ofindpwa;
	}

}
