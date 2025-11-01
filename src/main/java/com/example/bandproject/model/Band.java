package com.example.bandproject.model;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class Band {

    int no;
    String id; //마스터 회원 번호
    String name ; //밴드 이름
    String nickname; //밴드(마스터) 닉네임
    String description; //밴드 설명
    LocalDateTime createdAt; //생성일

    int likeCnt; //좋아요 수
    int viewCnt; //조회수

}

/*
    id : PK
    FOREIGN KEY (id) REFERENCES member (id)

 */