package mvc.dao;

import java.util.List;

import mvc.dto.Board;
import mvc.dto.Files;
import mvc.dto.Member;

public interface MypageDao {
	
	// 해당 계정정보 불러오기
	
	public Member selectMember(String memnick);
	
    // 해당 계정 작성글 리스트 불러오기
	
	public List selectPage(String memnick);
	
	// 해당 계정 작성글 사진 불러오기
	
	public List selectPic(String memnick);
	
    // 해당 계정 상세 작성글 내용 불러오기
	
	public Board selectContent(int bodno);
	
	// 해당 계정 상세 사진 불러오기
	
	public List selectContentPic(int bodno);

}
