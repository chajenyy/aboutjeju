package vo;

public class ConvenienceVO {
	int cvno;
	int ano;
	String coption;


	public ConvenienceVO(int cvno, int ano, String coption) {
		super();
		this.cvno = cvno;
		this.ano = ano;
		this.coption = coption;
	}
	
	public ConvenienceVO() {}

	public int getCvno() {
		return cvno;
	}

	public void setCvno(int cvno) {
		this.cvno = cvno;
	}

	public int getAno() {
		return ano;
	}

	public void setAno(int ano) {
		this.ano = ano;
	}

	public String getCoption() {
		return coption;
	}

	public void setCoption(String coption) {
		this.coption = coption;
	}

}

