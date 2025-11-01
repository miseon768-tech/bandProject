package com.example.bandproject.model;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Setter
@Getter
public class Member {

    int no;
    String id;
    String password;
    String email;
    String name;
    String nickname;
    String interest;
    boolean agree;
    LocalDateTime joinAt;

}