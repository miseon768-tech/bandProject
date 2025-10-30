package com.example.bandproject.model;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class Band {
    String id;
    String name ;
    String nickname;
    String description;
    LocalDateTime created_at;

}
