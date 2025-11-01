package com.example.bandproject.model;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Setter
@Getter
public class Comment {
    private int no;
    private String writerId;
    private String content;
    private int bandNo;
    private int articleNo;
    private  LocalDateTime commentedAt;

}

/*
    constraint foreign key (articleNo) references article (no)  ON DELETE CASCADE,
    constraint foreign key (writerId) references member (id)  ON DELETE CASCADE
    CONSTRAINT FOREIGN KEY (bandNo) REFERENCES band(no);
 */