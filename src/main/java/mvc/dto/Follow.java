package mvc.dto;

public class Follow {
	private String memid;
	private String flwid;
	public String getMemid() {
		return memid;
	}
	public void setMemid(String memid) {
		this.memid = memid;
	}
	public String getFlwid() {
		return flwid;
	}
	public void setFlwid(String flwid) {
		this.flwid = flwid;
	}
	public String toString() {
		return "Follow =[ "
				+ "memid : "+memid
				+ "flwid : "+flwid+ " ]";
	}
}
