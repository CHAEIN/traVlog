package mvc.dto;

import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Files {
	private int bodno;
	//originfile name
	private String filoriginfile;
	//savefile name
	private String filsavefile;
	private long filsize;
	private Date fildate;
	private int filidx;
	private String filtype;
	public int getFilidx() {
		return filidx;
	}

	public void setFilidx(int filidx) {
		this.filidx = filidx;
	}

	public int getBodno() {
		return bodno;
	}

	public void setBodno(int bodno) {
		this.bodno = bodno;
	}

	public String getFiloriginfile() {
		return filoriginfile;
	}

	public void setFiloriginfile(String filoriginfile) {
		this.filoriginfile = filoriginfile;
	}

	public String getFilsavefile() {
		return filsavefile;
	}

	public void setFilsavefile(String filsavefile) {
		this.filsavefile = filsavefile;
	}

	public long getFilsize() {
		return filsize;
	}

	public void setFilsize(long filsize) {
		this.filsize = filsize;
	}

	public Date getFildate() {
		return fildate;
	}

	public void setFildate(Date fildate) {
		this.fildate = fildate;
	}

	public String getFiltype() {
		return filtype;
	}

	public void setFiltype(String filtype) {
		this.filtype = filtype;
	}

}
