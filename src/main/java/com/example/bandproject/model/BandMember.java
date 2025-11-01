package com.example.bandproject.model;


import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class BandMember {

    int no;
    int bandNo;
    String id; //회원 번호
    String name; //밴드 이름
    String nickname; //밴드 닉네임
    String role; //역할: MASTER 또는 MEMBER
    boolean approved; //가입 승인 여부
    LocalDateTime joinedAt; //가입일

}

/*
    id : PK
    FOREIGN KEY (id) REFERENCES member (id),
    FOREIGN KEY (name) REFERENCES band (name)
 */
