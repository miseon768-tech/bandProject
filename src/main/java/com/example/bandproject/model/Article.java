package com.example.bandproject.model;

import lombok.Getter;
import lombok.Setter;
import java.time.LocalDateTime;

@Getter
@Setter
public class Article {
    private int no;
    private String title;
    private String content;
    private String writerId;
    private String topic;
    private int viewCnt;
    private LocalDateTime regDate = LocalDateTime.now();
}
