package mvc.dto;

import java.sql.Date;

public class Comments {
	private int comno; //대댓글이 달릴 댓글의 번호
	private int cosno;
	private String coscontent;
	private Date coswrittendate;
	private String coswriter;
	
	public int getComno() {
		return comno;
	}

	public void setComno(int comno) {
		this.comno = comno;
	}

	public int getCosno() {
		return cosno;
	}

	public void setCosno(int cosno) {
		this.cosno = cosno;
	}

	public String getCoscontent() {
		return coscontent;
	}

	public void setCoscontent(String coscontent) {
		this.coscontent = coscontent;
	}

	public Date getCoswrittendate() {
		return coswrittendate;
	}

	public void setCoswrittendate(Date coswrittendate) {
		this.coswrittendate = coswrittendate;
	}

	public String getCoswriter() {
		return coswriter;
	}

	public void setCoswriter(String coswriter) {
		this.coswriter = coswriter;
	}

	@Override
	public String toString() {
		return "Comments=[ cosno : "+cosno+
				", coscontent : "+coscontent+
				", coswrittendate : "+coswrittendate+
				", coswriter : "+coswriter+
				", comno : "+comno+"]";
	}
}
