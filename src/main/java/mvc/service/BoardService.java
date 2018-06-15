package mvc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mvc.dao.BoardDao;
import mvc.dto.Board;
import mvc.dto.Claim;
import mvc.dto.Files;
import mvc.dto.HashTag;
import mvc.dto.LatLng;
import mvc.dto.Member;
import mvc.dto.Profile;

@Service
public class BoardService {

	@Autowired BoardDao boardDao;
	
	//게시글 업로드
	public void insertBoard(Board board) {
		boardDao.insertBoard(board);
	}
	
	//파일을 디비에 저장할때 게시글 번호가 필요해서 추가함.
	public int getBoardNo(Board board) {
		//제목과 내용을 이용해서 번호 가져오기
		return boardDao.getBoardNo(board);
	}
	
	public void insertFile(Files file) {
		boardDao.insertFile(file);
	}

	public void insertHashTag(HashTag hash) {
		boardDao.insertHashTag(hash);
	}

	public int checkHashTag(HashTag hash) {
		return boardDao.checkHashTag(hash);
	}

	public void updateHashTagHit(HashTag hash) {
		boardDao.updateHashTagHit(hash);
	}

	public void insertLatLng(LatLng latLng) {
		boardDao.insertLatLng(latLng);
	}

	public void updateDates(Board board) {
		boardDao.updateDates(board);
	}

	public List<Board> getBoardListByFollow(Member boardMember) {

		return boardDao.getBoardListByFollow(boardMember);
	}
	
	public boolean recommendCheck(Board board) {
		System.out.println(board);
		if( boardDao.selectCountRecommend(board) > 0 ) {
			return true;
		} else {
			return false;
		}
	}
	
	public boolean recommend(Board board) {
		if( recommendCheck(board) ) {
			boardDao.deleteRecommend(board);
			return false;
		} else {
			boardDao.insertRecommend(board);
			return true;
		}
	}
	
	public int getRecommend(Board board) {
		return boardDao.selectTotalRecommend(board);
	}

	public boolean pin(Board board) {
		if( pinCheck(board) ) {
			boardDao.deletePin(board);
			return false;
		} else {
			boardDao.insertPin(board);
			return true;
		}
	}

	private boolean pinCheck(Board board) {
		System.out.println(board);
		if( boardDao.selectCountPin(board) > 0 ) {
			return true;
		} else {
			return false;
		}
	}

	public int getPin(Board board) {
		return boardDao.selectPin(board);
	}

	public List<Board> getBoardListBySearch(Member boardMember) {
		// TODO Auto-generated method stub
		return boardDao.getBoardListBySearch(boardMember);
	}

	//신고 게시글 정보 받아오기
	public Board getBoardInfo(Board board) {
		return boardDao.getBordInfo(board);
	}
	
	//신고 등록
	public void insertClaim(Claim claim) {
		boardDao.insertClaim(claim);
	}

	public List<Files> getFiles(Member boardMember) {
		return boardDao.getFiles(boardMember);
	}
	//게시글 프로필 정보
	public List<Profile> getProfileList(Member boardMember) {
		return boardDao.getProfileList(boardMember);
	}
	
}
