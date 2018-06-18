package mvc.dao;

import java.util.ArrayList;
import java.util.List;

import mvc.dto.Member;
import mvc.dto.FollowingRec;
import mvc.dto.HashTag;

public interface MainDao {

	public ArrayList<HashTag> topHash();

	public ArrayList<Member> topMember();

	public ArrayList<FollowingRec> recMember(String memid);

	public int countRecMember(String memid);

	public ArrayList<FollowingRec> follower(String memid);
	
	public int countFolMember(String memid);

	public ArrayList<FollowingRec> admin();

	public List<Member> getMemberListBySearch(Member member);
	
}
