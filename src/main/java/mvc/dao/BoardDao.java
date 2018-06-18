package mvc.dao;

import java.util.List;

import mvc.dto.Board;
import mvc.dto.Claim;
import mvc.dto.Files;
import mvc.dto.HashTag;
import mvc.dto.LatLng;
import mvc.dto.Member;
import mvc.dto.Profile;

public interface BoardDao {

	//게시글 삽입
	public void insertBoard(Board board);
	
	//글번호 얻어오기
	public int getBoardNo(Board board);
	
	//파일 정보 삽입
	public void insertFile(Files file);
	
	//해시태그 체크
	public int checkHashTag(HashTag hash);
	//해시태그 삽입
	public void insertHashTag(HashTag hash);
	//해시태그 조회수 업데이트
	public void updateHashTagHit(HashTag hash);

	//좌표 입력
	public void insertLatLng(LatLng latLng);

	//게시글에 여행날짜 업데이트하기.
	
	//날짜 없이 입력할 경우 insertBoard실행
	public void updateDates(Board board);
	
	public List<Board> getBoardListByFollow(Member boardMember);

	/* 작성자가 추천한 글번호인지 조회 */
	public int selectCountRecommend(Board board);
	
	/*추천 삽입 */
	public void insertRecommend(Board board);
	
	/*추천 삭제  */
	public void deleteRecommend(Board board);
	
	/*총 추천 수 구하기 */
	public int selectTotalRecommend(Board board);

	/*핀 삽입*/
	public void deletePin(Board board);
	/*핀 삭제*/
	public void insertPin(Board board);
	/*핀 여부 구하기*/
	public int selectPin(Board board);
	/*핀 개수 구하기*/
	public int selectCountPin(Board board);
	
	public List<Board> getBoardListBySearch(Member boardMember);

	public Board getBordInfo(Board board);

	public void insertClaim(Claim claim);

	public List<Files> getFiles(Member boardMember);

	public List<Profile> getProfileList(Member boardMember);

	public List<LatLng> getAllLatLng();

	public List<LatLng> getPositionListByBodno(LatLng latlng);

}
