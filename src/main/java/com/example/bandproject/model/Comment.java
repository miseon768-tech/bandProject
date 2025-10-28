package com.example.bandproject.model;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Setter
@Getter
public class Comment {
    int no;
    int articleNo;
    String writerId;
    String content;
    LocalDateTime commentedAt;
}
