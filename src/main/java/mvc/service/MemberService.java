package mvc.service;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mvc.dao.MemberDao;
import mvc.dto.Advertising;
import mvc.dto.Follow;
import mvc.dto.Member;
import mvc.dto.Profile;

@Service
public class MemberService {
	@Autowired MemberDao memberDao;
	
	//1이면 데이타 일치, 0이면 데이타 없음
	public int memberCheck(Member member) {
		return memberDao.memberCount(member);
	}

	public Member getMemberOne(Member member) {
		return memberDao.getMemberOne(member);
	}

	public void createMember(Member member) {
		memberDao.createMember(member);
	}

	public int idcheck(String memid) {
		return memberDao.idcheck(memid);
	}

	public int nickcheck(String memnick) {
		return memberDao.nickcheck(memnick);
	}

	public String findId(Map<String, Object> paramMap) {
		return memberDao.findId(paramMap);
	}
	
	public String findPw(Map<String, Object> paramMap) {
		return memberDao.findPw(paramMap);
	}

	public ArrayList<Member> MemberInfo(String memid) {
		return memberDao.MemberInfo(memid);
	}

	public String getProfile(String memnick) {
	      return memberDao.getProfile(memnick);
   }

   public int countProfile(String memnick) {
      return memberDao.countProfile(memnick);
   }

   public void followAdmin(Member member) {
      memberDao.followAdmin(member);
   }

   public ArrayList<Advertising> adInfo() {
      return memberDao.adInfo();
   }

	public void insertFollow(Follow insertFollow) {
		memberDao.insertFollow(insertFollow);
	}

	public Member getMemberByNick(Member member) {
		return memberDao.getMemberByNick(member);
	}

}
