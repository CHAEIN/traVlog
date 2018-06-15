package mvc.dto;

import java.sql.Date;

public class Comment {

	private int comno;
	private int bodno;
	private String comwriter;
	private String comcontent;
	private Date comwrittendate;
	
	
	public int getComno() {
		return comno;
	}
	public void setComno(int comno) {
		this.comno = comno;
	}
	public int getBodno() {
		return bodno;
	}
	public void setBodno(int bodno) {
		this.bodno = bodno;
	}
	public String getComcontent() {
		return comcontent;
	}
	public void setComcontent(String comcontent) {
		this.comcontent = comcontent;
	}
	public Date getComwrittendate() {
		return comwrittendate;
	}
	public void setComwrittendate(Date comwrittendate) {
		this.comwrittendate = comwrittendate;
	}
	public String getComwriter() {
		return comwriter;
	}
	public void setComwriter(String comwriter) {
		this.comwriter = comwriter;
	}
	
	@Override
	public String toString() {
		return "Comment =[comno : "+ comno+
				", bodno : "+bodno+
				", comcontent : "+ comcontent+
				", comwrittendate : " +comwrittendate+ 
				", comwriter : "+comwriter+"]";
	}
	
}
