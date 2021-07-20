package com.jhs.exam.exam2.service;

import java.util.List;

import com.jhs.exam.exam2.container.Container;
import com.jhs.exam.exam2.dto.Article;
import com.jhs.exam.exam2.dto.Member;
import com.jhs.exam.exam2.dto.ResultData;
import com.jhs.exam.exam2.http.Rq;
import com.jhs.exam.exam2.repository.ArticleRepository;
import com.jhs.exam.exam2.util.Ut;

public class ArticleService {
	private ArticleRepository articleRepository = Container.articleRepository;

	public ResultData write(int boardId, int memberId, String title, String body) {
		int id = articleRepository.write(boardId, memberId, title, body);

		return ResultData.from("S-1", Ut.f("%d번 게시물이 생성되었습니다.", id), "id", id);
	}

	public List<Article> getForPrintArticles(Rq rq, Member actor, int page, int boardId, int articleCountForPage, String searchKeywordTypeCode, String searchKeyword) {
		
		int startNumber = (page - 1) * articleCountForPage;
		
		List<Article> articles =  articleRepository.getForPrintArticles(rq, startNumber, articleCountForPage, boardId, searchKeywordTypeCode, searchKeyword);
		
		for(Article article : articles) {
			updateForPrintData(actor, article);
		}
		
		return articles;
	}
	
	public int getTotalArticlesCount(String searchKeywordTypeCode, String searchKeyword, int boardId) {
		
		return articleRepository.getTotalArticlesCount(searchKeywordTypeCode, searchKeyword, boardId);
	}

	public Article getForPrintArticleById(Member member, int id) {
		Article article =  articleRepository.getForPrintArticleById(id);
		
		updateForPrintData(member, article);
		
		return article;
	}
	

	private void updateForPrintData(Member actor, Article article) {
		if(actor == null) {
			return;
		}
		
		boolean actorCanModify = actorCanModify(actor, article).isSuccess();
		boolean actorCanDelete = actorCanDelete(actor, article).isSuccess();
		
		article.setExtra__actorCanModify(actorCanModify);
		article.setExtra__actorCanDelete(actorCanDelete);
	}

	public ResultData delete(int id) {
		articleRepository.delete(id);

		return ResultData.from("S-1", Ut.f("%d번 게시물이 삭제되었습니다.", id), "id", id);
	}

	public ResultData modify(int id, String title, String body) {
		articleRepository.modify(id, title, body);

		return ResultData.from("S-1", Ut.f("%d번 게시물이 수정되었습니다.", id), "id", id);
	}

	public ResultData actorCanModify(Member loginedMember, Article article) {
		if(loginedMember.getId() != article.getMemberId()) {
			return ResultData.from("F-1", "권한이 없습니다.");
		}
		return ResultData.from("S-1", "수정 가능");
	}

	public ResultData actorCanDelete(Member loginedMember, Article article) {
		if(loginedMember.getId() != article.getMemberId()) {
			return ResultData.from("F-1", "권한이 없습니다.");
		}
		return ResultData.from("S-1", "삭제 가능");
	}

	

	

}