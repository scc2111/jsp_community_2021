<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="게시물 리스트" />
<%@ include file="../part/head.jspf"%>

<section class="section section-article-write px-4">
	<div class="container mx-auto">

		<div class="card bordered shadow-lg">
			<div class="card-title">
				<a href="javascript:history.back();" class="cursor-pointer">
					<i class="fas fa-chevron-left"></i>
				</a>
				<span>게시물 리스트</span>
			</div>
			<div class="p-2 flex items-center">
				<a href="../article/write" role="button" class="btn btn-sm btn-primary">
					<span><i class="fas fa-pen"></i></span>
					<span class="pl-1">글쓰기</span>
				</a>
			</div>
			<hr />
			<div class="p-2 flex items-center">
				<div>
					<c:if test="${param.searchKeyword == null }">
						게시물 수 : ${totalArticlesCount}
					</c:if>
					<c:if test="${param.searchKeyword != null }">
						`${searchKeyword}` 검색결과 게시물 수 : ${totalArticlesCount}
					</c:if>
				</div>
				<div class="flex-grow"></div>
				<div>
					<form action="../article/list" class="flex">
						<c:if test="${boardId != 0}">
							<input name="boardId" type="hidden" value="${boardId}">
						</c:if>
						<div class="px-2">
						    <%-- <select name="searchKeywordTypeCode" class="select select-bordered w-full max-w-xs">
								<option value="title,body" <c:if test="${param.searchKeywordTypeCode eq 'title,body'}">selected='selected'</c:if>>제목,내용</option> 
								<option value="title" <c:if test="${param.searchKeywordTypeCode eq 'title'}">selected='selected'</c:if>>제목</option> 
								<option value="body" <c:if test="${param.searchKeywordTypeCode eq 'body'}">selected='selected'</c:if>>내용</option>
							</select> --%>
							<select name="searchKeywordTypeCode" class="select select-bordered w-full max-w-xs">
								<option value="title,body">제목,내용</option> 
								<option value="title">제목</option> 
								<option value="body">내용</option>
							</select>
							<script type="text/javascript">
								const $searchSelect = $('select[name="searchKeywordTypeCode"]');
								if('${param.searchKeywordTypeCode}'.trim().length > 0){
									$searchSelect.val('${param.searchKeywordTypeCode}');
								}else{
									$searchSelect.val('title,body');
								}
							</script>
						</div>
						<div class="px-2">
							<div class="form-control">
							  <input name="searchKeyword" type="text" placeholder="검색어" class="input input-bordered" value="${searchKeyword}">
							</div>
					  	</div>
						<div class="px-2">
						    <button type="submit" value="Submit" class="btn">검색</button>
						</div>
					</form>
				</div>
			</div>
			<hr />
			<div class="px-4">
				<c:forEach items="${articles}" var="article">
					<c:set var="detailUri" value="../article/detail?id=${article.id}" />

					<div class="py-4">
						<div class="grid gap-3" style="grid-template-columns: 100px 1fr;">
							<a href="${detailUri}">
								<img class="rounded-full w-full"
									src="https://i.pravatar.cc/200?img=37" alt="">
							</a>
							<a href="${detailUri}" class="hover:underline cursor-pointer">
								<span class="badge badge-outline">제목</span>
								<div class="line-clamp-3">${article.titleForPrint}</div>
							</a>
						</div>

						<div class="mt-3 grid sm:grid-cols-2 lg:grid-cols-4 gap-3">
							<a href="${detailUri}" class="hover:underline">
								<span class="badge badge-primary">번호</span>
								<span>${article.id}</span>
							</a>

							<a href="${detailUri}" class="cursor-pointer hover:underline">
								<span class="badge badge-accent">작성자</span>
								<span>${article.extra__writerName}</span>
							</a>

							<a href="${detailUri}" class="hover:underline">
								<span class="badge">등록날짜</span>
								<span class="text-gray-600 text-light">${article.regDate}</span>
							</a>

							<a href="${detailUri}" class="hover:underline">
								<span class="badge">수정날짜</span>
								<span class="text-gray-600 text-light">${article.updateDate}</span>
							</a>
						</div>

						<a href="${detailUri}"
							class="block mt-3 hover:underline cursor-pointer col-span-1 sm:col-span-2 xl:col-span-3">
							<span class="badge badge-outline">본문</span>

							<div class="mt-2">
								<img class="rounded" src="https://picsum.photos/id/237/300/300"
									alt="" />
							</div>

							<div class="line-clamp-3">${article.bodySummaryForPrint}</div>
						</a>
					</div>
					<div class="btns mt-3">
						<c:if test="${article.extra__actorCanModify}">
							<a href="../article/modify?id=${article.id}" class="btn btn-link">
								<span><i class="fas fa-edit"></i></span>
								<span>수정</span>
							</a>
						</c:if>
						<c:if test="${article.extra__actorCanDelete}">
							<a onclick="if ( !confirm('정말로 삭제하시겠습니까?') ) return false;" href="../article/doDelete?id=${article.id}" class="btn btn-link">
								<span><i class="fas fa-trash-alt"></i></span>
								<span>삭제</span>
							</a>
						</c:if>
					</div>
					<hr />
				</c:forEach>
			</div>
			<div class="my-2 mx-auto btn-group">
				<c:if test="${startPage > pageBlockCount}">
					<a href="${baseUri}page=1" class="btn btn-sm">＜＜처음</a>
				</c:if>
				<c:if test="${startPage > pageBlockCount}">
					<a href="${baseUri}page=${startPage - 1}" class="btn btn-sm">＜이전</a>
				</c:if>
				<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
					<c:set var="aClassStr" value="${i == page ? 'btn-active' : ''}" />
					<a href="${baseUri}page=${i}" class="${aClassStr} btn btn-sm">
						<span>${i}</span>&nbsp;
					</a>
				</c:forEach>
				<c:if test="${endPage < totalPage}">
					<a href="${baseUri}page=${endPage + 1}" class="btn btn-sm">다음＞</a>
				</c:if>
				<c:if test="${endPage < totalPage}">
					<a href="${baseUri}page=${totalPage}" class="btn btn-sm">끝＞＞</a>
				</c:if>
			</div>
		</div>
	</div>
</section>

<%@ include file="../part/foot.jspf"%>