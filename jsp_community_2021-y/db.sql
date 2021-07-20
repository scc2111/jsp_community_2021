# DB 생성
DROP DATABASE IF EXISTS jsp_board;
CREATE DATABASE jsp_board;
USE jsp_board;

# article Table 생성
CREATE TABLE article (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    delDate DATETIME DEFAULT NULL,
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
    memberId INT(10) UNSIGNED NOT NULL,
    boardId INT(10) UNSIGNED NOT NULL,
    hitCount INT(10) UNSIGNED NOT NULL DEFAULT 0,
    likeCount INT(10) UNSIGNED NOT NULL DEFAULT 0,
    dislikeCount INT(10) UNSIGNED NOT NULL DEFAULT 0,
    title CHAR(100) NOT NULL,
    `body` TEXT NOT NULL
);

# test article 생성
INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
boardId = 2,
title = '제목1',
`body` = '내용1';

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
boardId = 2,
title = '제목2',
`body` = '내용2';

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
memberId = 3,
boardId = 2,
title = '제목3',
`body` = '내용3';

# member Table 생성
CREATE TABLE `member`(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    delDate DATETIME DEFAULT NULL,  # 삭제날짜
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,  # 삭제상태(0:미삭제, 1:삭제)
    loginId CHAR(50) UNIQUE NOT NULL,
    loginPw CHAR(100) NOT NULL,
    `name` CHAR(30) NOT NULL,
    nickName CHAR(30) UNIQUE NOT NULL,
    email CHAR(100) NOT NULL,
    cellPhone CHAR(20) NOT NULL,
    authLevel SMALLINT(2) UNSIGNED NOT NULL DEFAULT 3 COMMENT '(3=일반, 7=관리자)'
);

# test member 생성
INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'admin',
loginPw = 'admin',
`name` = '윤종',
nickName = '관리자',
email = 'scc2111@naver.com',
cellPhone = '0102131334',
authLevel = 7;

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'user1',
loginPw = 'user1',
`name` = '보라돌이',
nickName = '뚜비',
email = 'adad11@gmail.com',
cellPhone = '010121323434';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'user2',
loginPw = 'user2',
`name` = '나나',
nickName = '뽀',
email = 'aaa@naver.com',
cellPhone = '0101234676';

# board Table 생성
CREATE TABLE board(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '번호',
    regDate DATETIME NOT NULL COMMENT '등록날짜',
    updateDate DATETIME NOT NULL COMMENT '수정날짜',
    `code` CHAR(20) NOT NULL UNIQUE COMMENT '코드',
    `name` CHAR(20) NOT NULL UNIQUE COMMENT '이름',
    delDate DATETIME DEFAULT NULL COMMENT '삭제날짜',
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '삭제여부',
    blindDate DATETIME DEFAULT NULL COMMENT '블라인드 날짜',
    blindStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '블라인드 여부'
);

# test board 생성
INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'notice',
`name` = 'Notice';

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'free',
`name` = 'Free';


# test 게시물 추가
DELIMITER $$
DROP PROCEDURE IF EXISTS dataInsert$$
CREATE PROCEDURE dataInsert() #함수 생성
BEGIN #시작    
DECLARE i INT DEFAULT 3; #i값 생성        
WHILE(i<100) DO #while문         
INSERT INTO article (regDate, updateDate, memberid, boardId, title, `body`) 
VALUE (NOW(), NOW(), i % 2 + 1, i % 2 + 1, CONCAT('제목',i), CONCAT('내용',i));       
SET i=i+1;        
END WHILE; #while문 끝         
END $$ 

CALL dataInsert(); #함수 호출 