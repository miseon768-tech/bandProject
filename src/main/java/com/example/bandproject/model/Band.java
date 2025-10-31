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
    LocalDateTime created_at; //생성일

}

/*
    id : PK
    FOREIGN KEY (id) REFERENCES member (id)

 */