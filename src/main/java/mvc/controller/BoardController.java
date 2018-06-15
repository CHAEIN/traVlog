package mvc.controller;

import java.io.File;
import java.io.IOException;
import java.io.Writer;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import mvc.dto.Board;
import mvc.dto.Claim;
import mvc.dto.Files;
import mvc.dto.FollowingRec;
import mvc.dto.HashTag;
import mvc.dto.LatLng;
import mvc.dto.Member;
import mvc.dto.Profile;
import mvc.service.BoardService;
import mvc.service.MainService;
import mvc.service.MemberService;
import spring.board.email.Email;
import spring.board.email.EmailSender;
@Controller
public class BoardController {
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Autowired
	MainService mainService;
	@Autowired
	EmailSender emailSender;
	@Autowired
	Email email;
	
	@Autowired MemberService memberService;
	@Autowired BoardService boardService;
	@Autowired ServletContext context;
	
	@RequestMapping(value = "/Manage_Page/home.do", method = RequestMethod.GET)
	public String ManageHome() {
		logger.info("관리자페이지 GET요청");
		return "Manage_Page/home";
	}

	// Login 파트
	@RequestMapping(value = "/traVlog/login.do", method = RequestMethod.GET)
	public void login() {
		logger.info("로그인페이지 GET요청");
	}
	
	@RequestMapping(value = "/traVlog/login.do", method = RequestMethod.POST)
	public String login(Member member, HttpSession session, Model model) {
		if (memberService.memberCheck(member) == 1) {
			//아이디와 네임 가져오기
			Member sessionMember = memberService.getMemberOne(member);
			// 로그인 .. memberService 가져오고 아이디와 이름 세션 생성
			session.setAttribute("memid", sessionMember.getMemid());
			session.setAttribute("memnick", sessionMember.getMemnick());
			
			return "redirect:/traVlog/main.do";
			
		} else {
			model.addAttribute("msg","비밀번호가 맞지 않거나 없는 아이디 입니다.");
			return "util/alert";
		}
	}
	
	@RequestMapping(value="/util/alert.do", method=RequestMethod.GET)
	public String alert() {
		
		return "util/alert";
	}
	
	//logout
//	@RequestMapping(value = "/traVlog/logout.do", method = RequestMethod.GET)
//	public String logout(Member member, HttpSession session) {
//		session.invalidate();
//		return "traVlog/login";
//	}
	
	@RequestMapping(value = "/traVlog/main.do", method = RequestMethod.GET)
	public String main(Member member, HttpSession session, Model model) {
		logger.info("메인페이지 GET요청");
		//로그인한 사용자 아이디 가져오기
		String memid = (String) session.getAttribute("memid");
		logger.info(memid);
		
		//사용자 정보 가져오기
		ArrayList<Member> memberInfo = memberService.MemberInfo(memid);
		ArrayList<Profile> profile = memberService.getProfile(memid);
		
		//인기 해시태그
		ArrayList<HashTag> tagList = mainService.topHash();
		
		//인기 사용자
		ArrayList<Member> memList = mainService.topMember();
		
		//board List가져오기 .. 친구와 내 게시글을 포함하여 가장 최신것부터 위로..
		Member boardMember = new Member();
		boardMember.setMemid((String)session.getAttribute("memid"));
		boardMember.setMemnick((String)session.getAttribute("memnick"));
		
		
		if(member.getSearch() == null || member.getSearch() =="") {
			//검색어가 없을때
			List<Board> boardList = boardService.getBoardListByFollow(boardMember);
			List<Files> filesList = boardService.getFiles(boardMember);
			List<Profile> profileList = boardService.getProfileList(boardMember);
			
			model.addAttribute("boardList",boardList);
			model.addAttribute("filesList",filesList);
			model.addAttribute("profileList",profileList);
			
			logger.info("대체 여기엔 뭐가들어있는데?"+boardMember.getMemid());
			logger.info("여기 안돌아가냐?");
//			Logger.info("왜 안나와?"+boardList.get(0).toString());
//			Logger.info("프로필 사진 정보가 들어있나요?"+profileList.get(0).toString());
			
		}else if(member.getSearch() != null || member.getSearch() != "") {
			//검색어가 있을때..
			boardMember.setSearch(member.getSearch());
			List<Board> boardList = boardService.getBoardListBySearch(boardMember);
			model.addAttribute("boardList",boardList);
			List<Files> filesList = boardService.getFiles(boardMember);
			model.addAttribute("filesList",filesList);
			//06.13 게시글 프로필 사진 추가
			List<Profile> profileList = boardService.getProfileList(boardMember);
			model.addAttribute("profileList",profileList);
			System.out.println(boardList.get(0).toString());
		}

		//일단 3개만 출력하기 위해 count도 보냄
		int count = 2;
		//가져오기 끝
		model.addAttribute("count",count);
//		model.addAttribute("boardList",boardList);
		model.addAttribute("memberInfo", memberInfo);
		model.addAttribute("tagList", tagList);
		model.addAttribute("memberList", memList);
		model.addAttribute("profile", profile);
		
		return "traVlog/main";
	}

	
	
	// 메인페이지 무한스크롤시 AJax 작동메서드
	@RequestMapping(value = "/traVlog/addBoardList.do", method = RequestMethod.GET)
	public void addBoard(int count, String search, HttpSession session, Model model) {
		logger.info("무한스크롤 AddBoardList1 요청");
		if(search != "" && search != null) {
			//검색 값이 존재할 떄
//			count = count+2;
			Member boardMember = new Member();
			boardMember.setSearch(search);
			boardMember.setMemid((String)session.getAttribute("memid"));
			boardMember.setMemnick((String)session.getAttribute("memnick"));
			List<Board> boardList = boardService.getBoardListByFollow(boardMember);
			List<Files> filesList = boardService.getFiles(boardMember);
			model.addAttribute("boardList",boardList);
			model.addAttribute("filesList",filesList);
			//06.13 게시글 프로필 사진 추가
			List<Profile> profileList = boardService.getProfileList(boardMember);
			model.addAttribute("profileList",profileList);
		}else {
			//검색 값이 없을 떄
			count = count+2;
			Member boardMember = new Member();
			boardMember.setMemid((String)session.getAttribute("memid"));
			boardMember.setMemnick((String)session.getAttribute("memnick"));
			List<Board> boardList = boardService.getBoardListByFollow(boardMember);
			List<Files> filesList = boardService.getFiles(boardMember);
			model.addAttribute("boardList",boardList);
			model.addAttribute("filesList",filesList);
			//06.13 게시글 프로필 사진 추가
			List<Profile> profileList = boardService.getProfileList(boardMember);
			model.addAttribute("profileList",profileList);
		}
		
		model.addAttribute("count",count);

	}
	
	@RequestMapping(value = "/traVlog/settingprofile.do", method = RequestMethod.GET)
	public void settingProfile() {
		logger.info("세팅페이지 프로필 GET요청");
	}
	
	@RequestMapping(value = "/traVlog/settingpass.do", method = RequestMethod.GET)
	public void settingPass() {
		logger.info("세팅페이지 비밀번호 변경 GET요청");
	}
	
	@RequestMapping(value = "/traVlog/mylist.do", method = RequestMethod.GET)
	public void mylist() {
		logger.info("컨텐츠 상세보기 페이지 GET요청");
	}

	@RequestMapping(value = "/traVlog/find.do", method = RequestMethod.GET)
	public void find() {
		logger.info("아이디/패스워드찾기 페이지 GET요청");
	}
	
	@RequestMapping(value = "/traVlog/findid.do", method = RequestMethod.POST)
	public ModelAndView findid(@RequestParam Map<String, Object> paramMap, ModelMap model) throws Exception{
		logger.info("아이디 찾기");
		ModelAndView mav;
        String name=(String) paramMap.get("idmemname");
        String e_mail=(String) paramMap.get("idmememail");
        System.out.println(paramMap);
        String id=memberService.findId(paramMap);
        System.out.println(id);
        if(id!=null) {
            email.setContent("[traVlog] 아이디를 확인해주세요.\n "
            		+ "본 메일은 아이디 확인을 위해 발송되는 메일입니다.\n\n\n "
            		+ name+"님의 아이디는 "+id+" 입니다.");
            email.setReceiver(e_mail);
            email.setSubject("[traVlog] "+name+"님 아이디 찾기 메일입니다.");
            emailSender.SendEmail(email);
//            mav= new ModelAndView("redirect:/traVlog/login.do");
          mav= new ModelAndView("util/alert");
          mav.addObject("msg", "ID찾기 성공 이메일을 확인해주세요.");
          mav.addObject("url", "/traVlog/login.do");
           return mav;
        }else {
        	mav= new ModelAndView("util/alert");
            mav.addObject("msg", "ID찾기 실패 회원정보를 확인해주세요.");
            mav.addObject("url", "/traVlog/find.do");
             return mav;
        }

	}
	
	@RequestMapping(value = "/traVlog/findpw.do", method = RequestMethod.POST)
	public ModelAndView findpw(@RequestParam Map<String, Object> paramMap, ModelMap model) throws Exception{
		logger.info("비밀번호 찾기");
		ModelAndView mav;
        String name=(String) paramMap.get("pwmemname");
        String id=(String) paramMap.get("pwmemid");
        String e_mail=(String) paramMap.get("pwmememail");
        String pw=memberService.findPw(paramMap);
        System.out.println(pw);
        if(pw!=null) {
            email.setContent("[traVlog] 비밀번호를 변경해주세요.\n "
            		+ "본 메일은 비밀번호 확인을 위해 발송되는 메일입니다.\n "
            		+ "보안을 위해 비밀번호를 변경하는 것을 추천합니다.\n\n\n"
            		+ name+"님의 비밀번호는 "+pw+" 입니다.");
            email.setReceiver(e_mail);
            email.setSubject("[traVlog] "+name+"님 비밀번호 찾기 메일입니다.");
            emailSender.SendEmail(email);
            mav= new ModelAndView("util/alert");
            mav.addObject("msg", "PW찾기 성공 이메일을 확인해주세요.");
            mav.addObject("url", "/traVlog/login.do");
             return mav;
          }else {
          	mav= new ModelAndView("util/alert");
              mav.addObject("msg", "PW찾기 실패 회원정보를 확인해주세요.");
              mav.addObject("url", "/traVlog/find.do");
               return mav;
          }

	}

	@RequestMapping(value = "/traVlog/write.do", method = RequestMethod.GET)
	public void write(HttpSession session) {
		session.getAttribute("memnick");
		logger.info("글쓰기페이지 GET요청");
	}
	
	//글쓰기
	@RequestMapping(value = "/traVlog/write.do", method = RequestMethod.POST)
	public String write(Board board, HttpSession session, LatLng latLng) {
		logger.info("글쓰기페이지 POST요청 ( 글 작성하기 실행 )");
		logger.info(board.toString()+"insertBoard 실행");
		boardService.insertBoard(board);
		logger.info("insertBoard 성공");
		
		//파일 업로드하기 ... 
			List<MultipartFile> list = board.getUpload();
			if(list.get(0).getOriginalFilename() != null && list.get(0).getOriginalFilename()!="") {
				
			for(int i=0; i<list.size(); i++) {
				System.out.println(list.get(i).getOriginalFilename());
				System.out.println("이건가?"+list.get(i).getContentType());
			}
			String uID = UUID.randomUUID().toString().split("-")[0];
			//파일 경로 가져오기
			String realpath = context.getRealPath("/resources/upload");
			
			for(int i=0; i<list.size(); i++) {
			//파일이 저장될 이름
			String stored = uID+"_"+list.get(i).getOriginalFilename();
			String fileType = list.get(i).getContentType();
			
			File dest = new File(realpath,stored);
			logger.info(dest.getPath());
				try {
					list.get(i).transferTo(dest);
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
				
				//Files는 디비(DTO)에있는 TB_FILES이다.
				Files files = new Files();
				files.setFiloriginfile(list.get(i).getOriginalFilename());
				files.setFilsavefile(stored);
				files.setFilsize(list.get(i).getSize());
				//파일 타입 추가
				files.setFiltype(fileType);
				
				//글번호 가져오기
				files.setBodno(boardService.getBoardNo(board));
				//파일 집어넣기
				boardService.insertFile(files);
			}
		}
		/*해쉬태그 생성하기~~
		 * 받아온 board의 bodhashtag를 trim() 한 후, split("#")으로 리스트를 생성해서
		 * list.size()만큼 hashtag 생성.. */
		String[] tagList;
		HashTag hash = new HashTag();
		String tags;
		if(board.getBodhashtag() != null || board.getBodhashtag()!="") {
			logger.info("해시태그값 : "+board.getBodhashtag());
			tags = board.getBodhashtag().trim();
			tagList = tags.split("#");
			for(int i=1; i<tagList.length;i++) {
				logger.info(tagList[i]);
				hash.setTagname(tagList[i]);
				
				//해시태그가 존재하면 조회수(hit) 업데이트
				if(boardService.checkHashTag(hash) > 0){
					logger.info("해시태그가 존재해서 조회수 업데이트 실행");
					boardService.updateHashTagHit(hash);
				}else{
					if(hash.getTagname()!=null || hash.getTagname() !="") {
					//해시태그가 존재하지 않으면 insertHashTag로 태그 삽입.
					logger.info("해시태그가 없어서 insertHashTag 실행");
					boardService.insertHashTag(hash);
					}else {
						logger.info("해시태그의 값이 null이거나 공백임.");
					}
				}
			}
		}
		//날짜 가져오기 및 날짜 넣기
		if(board.getStartdate() != null && board.getEnddate() != null) {
			Board insertDateBoard = new Board();
			
			insertDateBoard.setBodno(boardService.getBoardNo(board));
			insertDateBoard.setStartdate(board.getStartdate());
			insertDateBoard.setEnddate(board.getEnddate());
			
			logger.info(insertDateBoard.toString());
			
			boardService.updateDates(insertDateBoard);
			
		}
		//좌표 가져오기 및 좌표 넣기
		//update이용해서 적용
		String position;
		String[] positionList;
		if (latLng != null) {
			if (latLng.getPosition() != null) {
				latLng.setBodno(boardService.getBoardNo(board));
				position = latLng.getPosition();
				// 가져오는 좌표값의 괄호 ( )를 없애기
				position = position.replace("(", "");
				position = position.replace(")", "");
				logger.info("전부 받는 좌표 값은?" + position);
				positionList = position.split(",");

				for (int i = 0; i < positionList.length; i++) {
					positionList[i] = positionList[i].trim();
					// logger.info(positionList[i]);

					// x,y값 나눠서 set한 후 DB에 저장
					if (i < 1) {
						latLng.setPositionx(Double.parseDouble(positionList[i]));// 1,3,5번째 값을 x좌표로
					} else {
						if (i % 2 == 0) {
							latLng.setPositionx(Double.parseDouble(positionList[i]));// 1,3,5번째 값을 x좌표로
						} else if (i % 2 == 1) {
							latLng.setPositiony(Double.parseDouble(positionList[i]));
							// latlng삽입
							boardService.insertLatLng(latLng);
							logger.info("POSITION: insertLatLng 완료");
						}
					}

				}
			}
		}
		return "redirect:/traVlog/main.do";
	}
	
	@RequestMapping(value = "/traVlog/join.do", method = RequestMethod.GET)
	public void join() {
		logger.info("회원가입페이지 GET요청");
	}
	@RequestMapping(value = "/traVlog/join.do", method = RequestMethod.POST)
	public String join(Member member) {
		logger.info("회원가입 요청");
		logger.info(member.toString());
		
		memberService.createMember(member);
		logger.info("회원가입 완료");
		return "traVlog/login";
	}
	
	//아이디 중복체크
	@RequestMapping(value="/idcheck.do", method=RequestMethod.POST)
		@ResponseBody
	public Map<Object,Object> idcheck(@RequestBody String memid){
		logger.info("아이디 중복 체크 요청");
		logger.info(memid);
		int count = 0;
		Map<Object,Object> map = new HashMap<>();
		count = memberService.idcheck(memid);
		map.put("count", count);
		logger.info("중복체크값"+count);
		return map;
	}
	
	//닉네임 중복체크
		@RequestMapping(value="/nickcheck.do", method=RequestMethod.POST)
			@ResponseBody
		public Map<Object,Object> nickcheck(@RequestBody String memnick){
			logger.info("닉네임 중복 체크 요청");
			int count = 0;
			Map<Object,Object> map = new HashMap<>();
			count = memberService.nickcheck(memnick);
			map.put("count", count);
			logger.info("중복체크값"+count);
			return map;
		}
		

		@RequestMapping(value = "/traVlog/followerfind.do", method = RequestMethod.GET)
		public String followerFind(Member member, HttpSession session, Model model) {
			logger.info("친구찾기 GET요청");

			//현재 로그인중인 사람의 id를 가지고 오기..
			String memid = (String) session.getAttribute("memid");
			logger.info(memid);

			//추천친구 가져오기
			ArrayList<FollowingRec> recList = mainService.recommend(memid);
			int cntRec = mainService.countRecMember(memid);
			
			//추천친구가 없다면 인기 사용자 가져오기!
			ArrayList<Member> memList = mainService.topMember();
			
			
			//나의 팔로워 가져오기
			ArrayList<FollowingRec> folList = mainService.follower(memid);
			int cntFol = mainService.countFolMember(memid);
			
			//팔로워가 없다면 관리자 계정 추천하기
			ArrayList<FollowingRec> adList = mainService.admin();
			
			model.addAttribute("cntRec", cntRec);
			model.addAttribute("recList", recList);
			model.addAttribute("memList", memList);
			model.addAttribute("cntFol", cntFol);
			model.addAttribute("folList", folList);
			model.addAttribute("adList", adList);
			
			return "traVlog/followerFind";
		}
		
		@RequestMapping(value="/traVlog/recommend.do", method=RequestMethod.GET)
		public void boardRecommend(Board board,	Writer writer, HttpSession session) {
			logger.info("board:"+board);
			board.setMemnick( (String)session.getAttribute("memnick") );

			boolean result = boardService.recommend(board);
			
			int recommend = boardService.getRecommend(board);
			
			try {
				writer.write("{\"result\":"+result+", \"recommend\":"+recommend+"}");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		@RequestMapping(value="/traVlog/pin.do", method=RequestMethod.GET)
		public void boardPin(Board board, Writer writer, HttpSession session) {
			logger.info("board:"+board);
			board.setMemnick( (String)session.getAttribute("memnick") );

			boolean result = boardService.pin(board);
			
			int pin = boardService.getPin(board);
			
			try {
				writer.write("{\"result\":"+result+", \"pin\":"+pin+"}");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		@RequestMapping(value="/traVlog/claim.do", method=RequestMethod.GET)
		public void claim(Member member, Board board, HttpSession session, Model model) {
			logger.info("신고 팝업창 요청");
			//로그인한 사용자 아이디 가져오기
			String memid = (String) session.getAttribute("memid");
			logger.info(memid);
			
			//게시글 정보 가져오기
			logger.info("가져온 게시글 정보"+board.toString());
			Board claimBoard = boardService.getBoardInfo(board);
			System.out.println(claimBoard.toString());
			
			model.addAttribute("claimBoard",claimBoard);
		}
		
		@RequestMapping(value = "/traVlog/claim.do", method = RequestMethod.POST)
		public ModelAndView joinProc(HttpSession session, Claim claim) {
			logger.info("신고 처리");
			ModelAndView mav;
			String clmName = (String) session.getAttribute("memnick");
			 
			claim.setClmName(clmName);
			logger.info(claim.toString());

			boardService.insertClaim(claim);
			logger.info("신고 처리 완료");

			mav= new ModelAndView("util/alert");
			mav.addObject("msg", "신고 처리가 완료 되었습니다.");
	        mav.addObject("action", "window.close()");
			return mav;
		}
}




