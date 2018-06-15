package mvc.dao;

import java.util.List;

import mvc.dto.Board;
import mvc.dto.Comment;
import mvc.dto.Comments;

public interface CommentDao {
	//댓글 작성 메서드
	public void insertComment(Comment comment);

	public List<Comment> getCommentListByBodno(Board commentBoard);

	public void deleteCommentByComno(Comment comment);

	public void updateCommentByComno(Comment comment);

	public List<Comments> getCommentsList();

	public void insertComments(Comments comments);

	public void deleteCommentsByCosno(Comments comments);

	public void updateCommentsByCosno(Comments comments);
	
}
