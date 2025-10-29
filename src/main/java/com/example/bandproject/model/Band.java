package com.example.bandproject.model;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class Band {
    int no;
    String name;
    String description;
    String master_member_id;
    LocalDateTime created_at;
    LocalDateTime updated_at;
    boolean is_public;
}
