package mvc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mvc.dao.CommentDao;
import mvc.dto.Board;
import mvc.dto.Comment;
import mvc.dto.Comments;

@Service
public class CommentService {
	@Autowired CommentDao commentDao;


	public void insertComment(Comment comment) {
		commentDao.insertComment(comment);
	}

	//bodno 기준으로 댓글 리스트 가져오기
	public List<Comment> getCommentListByBodno(Board commentBoard) {
		
		return commentDao.getCommentListByBodno(commentBoard);
	}

	public void deleteCommentByComno(Comment comment) {
		commentDao.deleteCommentByComno(comment);
	}

	public void updateCommentByComno(Comment comment) {
		commentDao.updateCommentByComno(comment);
	}

	public List<Comments> getCommentsList() {
		return commentDao.getCommentsList();
	}

	public void insertComments(Comments comments) {
		commentDao.insertComments(comments);
	}

	public void deleteCommentsByCosno(Comments comments) {
		commentDao.deleteCommentsByCosno(comments);
	}

	public void updateCommentsByCosno(Comments comments) {
		commentDao.updateCommentsByCosno(comments);
	}
	
}
