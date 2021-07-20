package com.jhs.exam.exam2.service;

import com.jhs.exam.exam2.container.Container;
import com.jhs.exam.exam2.dto.Board;
import com.jhs.exam.exam2.dto.ResultData;
import com.jhs.exam.exam2.repository.BoardRepository;

public class BoardService {
	private BoardRepository boardRepository = Container.boardRepository;

	public Board getBoardById(int boardId) {
		Board board = boardRepository.getBoardById(boardId);
		
		return board;
	}

}