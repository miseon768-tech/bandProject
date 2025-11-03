package com.example.bandproject.model;


import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class BandMember {

    int no;
    int memberNo;
    int bandNo;
    String id;
    String name;
    String nickname;
    String role; //역할: MASTER 또는 MEMBER
    boolean approved; //가입 승인 여부
    LocalDateTime joinedAt;

}

/*
    id : PK
    FOREIGN KEY (id) REFERENCES member (id),
    FOREIGN KEY (name) REFERENCES band (name)
 */
