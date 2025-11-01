package com.example.bandproject.model;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Setter
@Getter
public class LikedBand {
    int idx;
    String memberId;
    int articleNo;
    int no;
    String writerId;
    String topic;
    String title;
    String content;
    LocalDateTime wroteAt;

}
