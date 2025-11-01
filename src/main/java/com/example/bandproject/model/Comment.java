package com.example.bandproject.model;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Setter
@Getter
public class Comment {
    private int no;
    private int bandNo;
    private int articleNo;
    private String writerId;
    private String content;
    private  LocalDateTime commentedAt;

}