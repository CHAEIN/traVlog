package mvc.dto;

import java.sql.Date;

public class Advertising {

   private int advno; 
   private String advid; 
   private Date advdate; 
   private int advapprove; 
   private String advtitle; 
   private int advprice; 
   private String advstart; 
   private Date advend ;
   private String advcontent; 
   private String  advfile;
   private String advname;
   public String getAdvname() {
      return advname;
   }
   public void setAdvname(String advname) {
      this.advname = advname;
   }
   public int getAdvno() {
      return advno;
   }
   public void setAdvno(int advno) {
      this.advno = advno;
   }
   public String getAdvid() {
      return advid;
   }
   public void setAdvid(String advid) {
      this.advid = advid;
   }
   public Date getAdvdate() {
      return advdate;
   }
   public void setAdvdate(Date advdate) {
      this.advdate = advdate;
   }
   public int getAdvapprove() {
      return advapprove;
   }
   public void setAdvapprove(int advapprove) {
      this.advapprove = advapprove;
   }
   public String getAdvtitle() {
      return advtitle;
   }
   public void setAdvtitle(String advtitle) {
      this.advtitle = advtitle;
   }
   public int getAdvprice() {
      return advprice;
   }
   public void setAdvprice(int advprice) {
      this.advprice = advprice;
   }
   public String getAdvstart() {
      return advstart;
   }
   public void setAdvstart(String advstart) {
      this.advstart = advstart;
   }
   public Date getAdvend() {
      return advend;
   }
   public void setAdvend(Date advend) {
      this.advend = advend;
   }
   public String getAdvcontent() {
      return advcontent;
   }
   public void setAdvcontent(String advcontent) {
      this.advcontent = advcontent;
   }
   public String getAdvfile() {
      return advfile;
   }
   public void setAdvfile(String advfile) {
      this.advfile = advfile;
   }
   @Override
   public String toString() {
      return "Advertising [advno=" + advno + ", advid=" + advid + ", advdate=" + advdate + ", advapprove="
            + advapprove + ", advtitle=" + advtitle + ", advprice=" + advprice + ", advstart=" + advstart
            + ", advend=" + advend + ", advcontent=" + advcontent + ", advfile=" + advfile + ", advname=" + advname
            + ", getAdvname()=" + getAdvname() + ", getAdvno()=" + getAdvno() + ", getAdvid()=" + getAdvid()
            + ", getAdvdate()=" + getAdvdate() + ", getAdvapprove()=" + getAdvapprove() + ", getAdvtitle()="
            + getAdvtitle() + ", getAdvprice()=" + getAdvprice() + ", getAdvstart()=" + getAdvstart()
            + ", getAdvend()=" + getAdvend() + ", getAdvcontent()=" + getAdvcontent() + ", getAdvfile()="
            + getAdvfile() + "]";
   }
   
   
}