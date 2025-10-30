package com.example.bandproject.model;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class Band {
    int no;
    String name;
    String nickname;
    String description;
    String id;
    LocalDateTime created_at;
    LocalDateTime updated_at;

}
