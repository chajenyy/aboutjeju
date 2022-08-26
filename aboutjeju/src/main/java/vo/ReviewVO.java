package vo;

public class ReviewVO {
	int reviewno;
	int bno;
	int ano;
	String title;
	String contents;
	int star;
	String date;
	String comment;

	public ReviewVO(int reviewno, int bno, int ano, String title, String contents, int star, String date,
			String comment) {
		super();
		this.reviewno = reviewno;
		this.bno = bno;
		this.ano = ano;
		this.title = title;
		this.contents = contents;
		this.star = star;
		this.date = date;
		this.comment = comment;
	}

	public int getReviewno() {
		return reviewno;
	}

	public void setReviewno(int reviewno) {
		this.reviewno = reviewno;
	}

	public int getBno() {
		return bno;
	}

	public void setBno(int bno) {
		this.bno = bno;
	}

	public int getAno() {
		return ano;
	}

	public void setAno(int ano) {
		this.ano = ano;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public int getStar() {
		return star;
	}

	public void setStar(int star) {
		this.star = star;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

}
