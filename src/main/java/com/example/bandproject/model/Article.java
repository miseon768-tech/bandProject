package com.example.bandproject.model;

import lombok.Getter;
import lombok.Setter;
import java.time.LocalDateTime;

@Getter
@Setter
public class Article {
    private int no;
    private int memberNo;
    private String writerId;
    private int bandNo;

    private String title;
    private String content;
    private LocalDateTime wroteAt;

    private int viewCnt;
    private int likeCnt;
    private int commentCnt;
}
