package mvc.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mvc.dto.Member;
import mvc.dto.FollowingRec;
import mvc.dto.HashTag;
import mvc.dto.LatLng;
import mvc.dao.MainDao;

@Service
public class MainService {
	@Autowired MainDao mainDao;
	

	public ArrayList<HashTag> topHash() {
		return mainDao.topHash();
	}


	public ArrayList<Member> topMember() {
		return mainDao.topMember(); 
	}


	public ArrayList<FollowingRec> recommend(String memid) {
		return mainDao.recMember(memid); 
	}
	
	public int countRecMember(String memid) {
		return mainDao.countRecMember(memid);
	}

	public ArrayList<FollowingRec> follower(String memid) {
		return mainDao.follower(memid);
	}
	
	public int countFolMember(String memid) {
		return mainDao.countFolMember(memid);
	}

	public ArrayList<FollowingRec> admin() {
		return mainDao.admin();
	}


	public List<Member> getMemberListBySearch(Member member) {
		return mainDao.getMemberListBySearch(member);
	}


}
